import 'package:dio/dio.dart';
import 'GlobalContext.dart';
import 'SharedPreference/shared_preferences_methods.dart';
import 'custom_log_interceptor.dart';
import 'log_util.dart';
import 'package:flutter/material.dart';


final title = "ApiUtils";

ApiUtils apiUtils = ApiUtils();

class ApiUtils {
  static ApiUtils _apiUtils = ApiUtils._i();
  final Dio _dio = Dio();

  ApiUtils._i() {
    _dio.interceptors.add(CustomLogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError error, handler) async {
        if (error.response?.statusCode == 400 &&
        error.response?.data['message'] == "Invalid token"
        ) {
          // Token expired logic
          handleSessionExpired();
        }
        handler.next(error);
      },
    ));
  }
  void handleSessionExpired() {
    // Clear token or session data
    secureHeaders["Authorization"] = "";

    // Show a dialog or use a global handler
    showDialog(
      context: GlobalContext.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Session Expired"),
          content: Text("Your session has expired. Please log in again."),
          actions: [
            TextButton(
              onPressed: () {
                removeAllFromCache();
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }


  factory ApiUtils() {
    return _apiUtils;
  }

  Map<String, String> header = {"Content-Type": "application/json"};

  Map<String, String> headers = {"Content-Type": "application/json", "api-version": "1"};

  Map<String, String> secureHeaders = {"Content-Type": "application/json", "api-version": "1", "Authorization": ""};

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? data,
  }) async {
    var result = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
      data: data,
    );
    return result;
  }

  Future<Response> post({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    //Sending FormData:
    //FormData formData = FormData.fromMap({"name": ""});

    var result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> postWithProgress({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    //
    var result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onSendProgress: onSendProgress,
    );
    return result;
  }

  Future<Response> put({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var result = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> delete({
    required String api,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    //Options options = Options(headers: secureHeaders);

    //var result = await _dio.delete(api, options: options);
    var result = await _dio.delete(
      api,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> multiPart({
    required String url,
    FormData? formData,
    Options? options,
  }) async {
    var result =  await _dio.post(
      url,
      data: formData,
      options: options,
    );
    return result;
  }

  String handleError(dynamic error) {
    String errorDescription = "";

    Log.loga(title, "handleError:: error >> $error");

    if (error is DioError) {
      Log.loga(title, '************************ DioError ************************');

      DioError dioError = error as DioError;
      Log.loga(title, 'dioError:: $dioError');
      if (dioError.response != null) {
        Log.loga(title, "dioError:: response >> " + dioError.response.toString());
      }

      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
        case DioErrorType.connectionTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.badCertificate:
          errorDescription = 'Caused by an incorrect certificate';
          break;
        case DioErrorType.badResponse:
          errorDescription = "Received invalid status code: ${dioError.response?.statusCode}";
          break;
        case DioErrorType.connectionError:
          errorDescription = 'Caused for example by a `xhr.onError` or SocketExceptions.';
          break;
        case DioErrorType.unknown:
          errorDescription = "Connection to API server failed due to internet connection";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    Log.loga(title, "handleError:: errorDescription >> $errorDescription");
    return errorDescription;
  }

  getFormattedError() {
    return {'error': 'Error'};
  }

  getNetworkError() {
    return "No Internet Connection.";
  }
}
