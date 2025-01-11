import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:vrsstranslinkcompany/Model/EmployeeDetailsModel.dart';
import '../Model/NodalPointModel.dart';
import '../helpers/SharedPreference/shared_preferences_constants.dart';
import '../helpers/SharedPreference/shared_preferences_methods.dart';
import '../helpers/api_constants.dart';
import '../helpers/api_utils.dart';

class NodalService{
  Future<bool> createNodal(
      String nodalPointName, String address, String latitude, String longitude,
      String officeId
      ) async {

    String url = ApiStringConstants.baseurl + ApiStringConstants.createNodal;
    try {
      String companyId = await getStringFromCache(SharedPreferenceString.companyId);
      String token = await getStringFromCache(SharedPreferenceString.accessToken);
      final response = await apiUtils.post(url: url,
          options: Options(headers:{
            'Authorization': 'Bearer $token',
          }),
          data: {
            "address": address,
            "latitude": latitude,
            "longitude": longitude,
            "nodalPointName": nodalPointName,
            // "listOfEmployees": [
            //   "6700def8e1a623341a951378", // Replace with valid ObjectId from Employee collection
            //   "6700def8e1a623341a951379",  // Replace with valid ObjectId from Employee collection
            //   "6700def8e1a623341a95137a"
            // ],
            "company": companyId, // Replace with valid ObjectId from Company collection
            "office": officeId,  // Replace with valid ObjectId from Office collection
            "disabled": false
          }
      );

      if(response.data['success']=='true'){
        print('add Nodal Point');
        return true;


      }

    }  catch (e) {
      return false;
    }
    return false;
  }
  Future<List<NodalPointModel>> getAllNodalPoint()async {
    String url = "${ApiStringConstants.baseurl}${ApiStringConstants.getAllNodal}";
    List<NodalPointModel> nodalList = [];
    try {
      String companyId = await getStringFromCache(SharedPreferenceString.companyId);
      String token = await getStringFromCache(SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: url +"/"+ companyId,
          options: Options(headers:{
            'Authorization': 'Bearer $token',
          }));
      if(response.data['success']==true){
        print('got all nodal successfully');
        for (var item in response.data['nodalData']) {
          nodalList.add(NodalPointModel.fromJson(item));
        }
      }
    } catch (e) {
      print('Error adding nodal: $e');
    }
    return nodalList;
  }
  Future<List<EmployeeDetails>> getUnassignedEmployee()async {
    String url = "${ApiStringConstants.baseurl}${ApiStringConstants.getUnassignedEmployee}";
    List<EmployeeDetails> employeeList = [];
    try {
      String companyId = await getStringFromCache(SharedPreferenceString.companyId);
      String token = await getStringFromCache(SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: "$url$companyId",
          options: Options(headers:{
            'Authorization': 'Bearer $token',
          }));
      if(response.data['success']==true){
        print('got all employee successfully');
        for (var item in response.data['data']) {
          employeeList.add(EmployeeDetails.fromJson(item));
        }
      }
    } catch (e) {
      print('Error adding employee: $e');
    }
    return employeeList;
  }
  Future<void> assignEmployeeToNodal(
      List<String> selectedId,
      String nodalId
      ) async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.assignEmployeeToNodal;
    try {
      String companyId = await getStringFromCache(SharedPreferenceString.companyId);
      String token = await getStringFromCache(SharedPreferenceString.accessToken);
      final response = await apiUtils.post(url: url,
          options: Options(headers:{
            'Authorization': 'Bearer $token',
          }),
          data: {
            "nodalId": nodalId,
            "listOfEmployees": selectedId
          });

      if(response.data['success']=='true'){
        print('assign employee to nodal');
      }

    }  catch (e) {
      print('Error adding employee: $e');
    }
  }

  Future<bool> unAssignEmployeeToNodal(
      String nodalId,
      String selectedId      ) async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.removeEmployeeFromNodal;
    try {
      String token = await getStringFromCache(SharedPreferenceString.accessToken);
      final response = await apiUtils.post(url: url,
          options: Options(headers:{
            'Authorization': 'Bearer $token',
          }),
          data: {
            "nodalId":nodalId ,
            "employeeId": selectedId
          });

      if(response.data['success']=='true'){
        print('unassign employee to nodal');
        return true;
      }

    }  catch (e) {
      print('Error adding employee: $e');
    }
    return false;
  }

  Future<void> bulkAdd(
      Uint8List? fileBytes, String name
      ) async {
    String token = await getStringFromCache(SharedPreferenceString.accessToken);
    String url = ApiStringConstants.baseurl + ApiStringConstants.bulkNodal;
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(url));
    request.headers.addAll({
      'Authorization':  'Bearer $token',
      'Content-Type': 'multipart/form-data', // Usually optional for MultipartRequest
      // Add more headers if necessary
    });
    // Add the image as a multipart file
    request.files.add(
      http.MultipartFile.fromBytes(
        'file', // This is the name of the form field on the server
        fileBytes!,
        filename: name, // Adjust according to image type
      ),
    );

    // Send the request
    var response = await request.send();

    // Handle the response
    if (response.statusCode == 201) {
      // Convert the stream to a string and then to JSON
      final respStr = await response.stream.bytesToString();
      print('Upload successful! Response: $respStr');
    } else {
      final respStr = await response.stream.bytesToString();
      print('Upload successful! Response: $respStr');
    }

  }
}