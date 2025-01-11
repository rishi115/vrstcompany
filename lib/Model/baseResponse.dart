class ApiResponse {
  dynamic message;
  dynamic error;
  dynamic data;
  dynamic otp;
  dynamic login_user_type;
  dynamic success;

  ApiResponse({
    this.message,
    this.data,
    this.otp,
    this.error,
    this.login_user_type,
    this.success,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json["message"],
      data: json["data"],
      otp: json["otp"],
      error: json["error"],
      login_user_type: json["user_type"],
      success: json["success"],
    );
  }

  Map<String, dynamic> apiBaseResponseToJson(ApiResponse instance) {
    return <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'otp': instance.otp,
      'error': instance.error,
      'login_user_type': instance.login_user_type,
      'success': instance.success,
    };
  }
}
