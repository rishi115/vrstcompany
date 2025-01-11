import 'package:dio/dio.dart';
import 'package:vrsstranslinkcompany/Model/DriverListModel.dart';

import '../Model/Driver.dart';
import '../helpers/SharedPreference/shared_preferences_constants.dart';
import '../helpers/SharedPreference/shared_preferences_methods.dart';
import '../helpers/api_constants.dart';
import '../helpers/api_utils.dart';

class DriverService {

  Future<void> registerDriver(Driver driver,String driverGender,String driverStatus ,String driverLicenseType,
      String driverLastInactivedate,String driverInductionDate,String driverDateOfBirth,String driverJoiningDate,
      String driverLanguageKnown ,String driverRestDays,String driverInductionType,String driverVehicle,
      String driverBloodGroup) async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.addDriver;
    try {
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      double lat = double.parse(driver.latitude!);
      double long = double.parse(driver.longitude!);
      final response = await apiUtils.post(url: url,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
          data: {
            "firstName": driver.firstName,
            "middleName": driver.middleName,
            "lastName": driver.lastName,
            "contactNumber": driver.contactNumber,
            "gender": driverGender,
            "status": driverStatus,
            "statusComment": driver.statusComment,
            "lastInactiveDate": driverLastInactivedate,
            "experience": driver.experience,
            "licenseType": driverLicenseType,
            "licenseNumber": driver.licenseNumber,
            "emergencyContact": driver.emergencyContactNumber,
            "dateOfBirth":driverDateOfBirth,
            "dateOfJoining": driverJoiningDate,
            "restDays": 12,
            "languagesKnown": [
              driverLanguageKnown
            ],
            "maritalStatus": 'Single',
            "bloodGroup": driverBloodGroup,
            "vehicle": "609d4d6a1c45a80f6ccbd469", // ObjectId of the Vehicle
            "rfid": driver.rfid,
            "inductionDate": driverInductionDate,
            "inductionType":  driverInductionType,
            "address": driver.address,
            "locality": driver.locality,
            "latitude": lat,
            "longitude": long,
          });

      if (response.data['message'] == 'Employee added successfully') {
        print('add driver successfull');
      }
    } catch (e) {
      print('Error adding driver: $e');
    }
  }

  Future<List<DriverListModel>> getAllDriver() async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.getDriverByVendorId;
    String vendorId = await getStringFromCache(SharedPreferenceString.vendorId);
    String token = await getStringFromCache(SharedPreferenceString.accessToken);
    List<DriverListModel> driverList = [];
    final response = await apiUtils.get(url: "$url$vendorId",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }));
    if (response.data['success'] == true) {
      for (var item in response.data['data']) {
        driverList.add(DriverListModel.fromJson(item));
      }
    }
    return driverList;
  }
}