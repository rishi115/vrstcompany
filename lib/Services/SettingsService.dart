import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/GuardModel.dart';
import '../Model/ShiftModel.dart';
import '../Model/SupervisorModel.dart';
import '../helpers/SharedPreference/shared_preferences_constants.dart';
import '../helpers/SharedPreference/shared_preferences_methods.dart';
import '../helpers/api_constants.dart';
import '../helpers/api_utils.dart';
import 'package:vrsstranslinkcompany/Model/OfficeModel.dart';


class SettingsService {
  Future<bool> createShift(String login,String logout,) async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.createShift;
    try {
      String companyId = await getStringFromCache(
          SharedPreferenceString.companyId);
      String token=await getStringFromCache(SharedPreferenceString.accessToken);
      final response = await apiUtils.post(url: url,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
          data: {
            "loginTime": login,
            "logoutTime": logout,
            "tripType":"login",
            "company": companyId
      });

      if (response.data['success'] == 'true') {
       Get.snackbar('Success', 'Shift created successfully');
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<void> deleteShift(
      String shiftId
      )async{
    String url = ApiStringConstants.baseurl + ApiStringConstants.deleteShift;
    try {
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.delete(api: "$url$shiftId",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {
        print('shift deleted successfully');
        Get.snackbar('Success', 'Shift deleted successfully');
      }
    } catch (e) {
      print('Error adding shift: $e');
    }

  }

  Future<List<ShiftModel>> getAllShift() async {
    String url = "${ApiStringConstants.baseurl}${ApiStringConstants
        .getAllShift}";
    List<ShiftModel> shiftList = [];
    try {
      String companyId = await getStringFromCache(
          SharedPreferenceString.companyId);
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: "$url/$companyId",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {
        print('got all shift successfully');
        for (var item in response.data['data']) {
          shiftList.add(ShiftModel.fromJson(item));
        }
      }
    } catch (e) {
      print('Error adding shift: $e');
    }
    return shiftList;
  }

  Future<void> addOffice(OfficeModel office) async {
    String companyId = await getStringFromCache(
        SharedPreferenceString.companyId);

    String url = ApiStringConstants.baseurl + ApiStringConstants.addOffice;
    try {
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.post(url: url,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
          data: {
            "name": office.name,
            "latitude": office.latitude,
            "longitude": office.longitude,
            "address": office.address, // Replace with a valid ObjectId from Employee collection
            "supervisorId":office.supervisorId,
            "company": companyId
      }
      );

      if (response.data['success'] == true) {
        print('Office added successfully');
      }
    } catch (e) {
      print('Error adding office: $e');
    }
  }

  Future<void> addAgency(
String agencyName,
String address,
String primaryContact,
String primaryEmail,
      BuildContext context

      ) async {
    String companyId = await getStringFromCache(
        SharedPreferenceString.companyId);

    String url = ApiStringConstants.baseurl + ApiStringConstants.addAgency;
    try {
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.post(url: url,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
          data:   {
            "name": agencyName,
            "company": companyId,
            "address": address,
            "primaryContact": primaryContact,
            "primaryEmail": primaryEmail,
            "status": "active",
            "disabled": false
          }
      );

      if (response.data['success'] == true) {
        print('Office added successfully');
        Navigator.pop(context);
        agencyName='';
        address='';
        primaryContact='';
        primaryEmail='';

      }
    } catch (e) {
      print('Error adding office: $e');
    }
  }

  Future<void> addGuard(
      Guard guard,
      BuildContext context
      ) async {

    String companyId = await getStringFromCache(
        SharedPreferenceString.companyId);

    String url = ApiStringConstants.baseurl + ApiStringConstants.addGuard;

    try {
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      
      final response = await apiUtils.post(url: url,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
          data: {
            "firstName": guard.firstName,
            "middleName": guard.middleName,
            "lastName": guard.lastName,
            "address": guard.address,
            "latitude": guard.latitude,
            "longitude": guard.longitude,
            "age": guard.age,
            "gender": guard.gender,
            "contact": guard.contactNumber,
            "otp": 6789,
            "status": "active",
            "uid": guard.uid,
            "office": guard.office,
            "company": companyId,
            "agency": guard.agency,
            "photo": guard.photo,
            "adharCard": guard.adharCard
          }
      );

      if (response.data['success'] == true) {
        print('Office added successfully');
        Navigator.pop(context);
        guard.firstName = '';
        guard.middleName = '';
        guard.lastName = '';
        guard.address = '';
        guard.contactNumber = '';
        guard.age = '';
        guard.latitude = '';
        guard.longitude = '';
        guard.office = '';
        guard.agency = '';
        guard.photo = '';
        guard.adharCard = '';
        guard.uid = '';
      }else{
        Get.snackbar('Error', response.data['message']);
      }
    } catch (e) {
      print('Error adding office: $e');
    }
  }

  Future<List<GaurdModel>> getGuard() async {
    String url = "${ApiStringConstants.baseurl}${ApiStringConstants.getGuard}";
    List<GaurdModel> guardList = [];
    try {
      String companyId = await getStringFromCache(
          SharedPreferenceString.companyId);
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: "$url$companyId",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {
        print('got all guard successfully');
        for (var item in response.data['data']) {
          guardList.add(GaurdModel.fromJson(item));
        }
      }
    } catch (e) {
      print('Error adding agency: $e');
    }
    return guardList;
  }


  Future<List<AgencyList>> getAllAgency() async {
    String url = "${ApiStringConstants.baseurl}${ApiStringConstants.getAgency}";
    List<AgencyList> officeList = [];
    try {
      String companyId = await getStringFromCache(
          SharedPreferenceString.companyId);
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: "$url$companyId",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {
        print('got all Agency successfully');
        for (var item in response.data['data']) {
          officeList.add(AgencyList.fromJson(item));
        }
      }
    } catch (e) {
      print('Error adding agency: $e');
    }
    return officeList;
  }
  Future<List<OfficeModel>> getAllOffice() async {
    String url = "${ApiStringConstants.baseurl}${ApiStringConstants.getOffice}";
    List<OfficeModel> officeList = [];
    try {
      String companyId = await getStringFromCache(
          SharedPreferenceString.companyId);
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: "$url$companyId",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {
        print('got all office successfully');
        for (var item in response.data['data']) {
          officeList.add(OfficeModel.fromJson(item));
        }
      }
    } catch (e) {
      print('Error adding office: $e');
    }
    return officeList;
  }

  Future<void> disableOffice(String officeId) async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.disableOffice;
    try {
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.get(
          url: "$url$officeId",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {
       Get.snackbar('Success', 'Office disabled successfully');
      }
    } catch (e) {
      print('Error adding office: $e');
    }
  }

  Future<List<SupervisorModel>> getSupervisor() async {
    String url = "${ApiStringConstants.baseurl}${ApiStringConstants.getSupervisor}";
    List<SupervisorModel> supervisorModel = [];
    try {
      String companyId = await getStringFromCache(
          SharedPreferenceString.companyId);
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: "$url$companyId",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {
        print('got all supervisor successfully');
        for (var item in response.data['data']) {
          supervisorModel.add(SupervisorModel.fromJson(item));
        }
      }
    } catch (e) {
      print('Error adding office: $e');
    }
    return supervisorModel;
  }
  Future<void> makeEmployeeSupervisor(String Id) async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.makeEmployeeSupervisor;
    try {
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: url+Id,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
      );

      if (response.data['success'] == true) {
        print('Employee made supervisor successfully');
      }
    } catch (e) {
      print('Error adding office: $e');
    }
  }
  Future<String> bulkAdd(
      Uint8List? fileBytes, String name
      ) async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.getFileUrl;
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(url));
    request.headers.addAll({
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

    var response = await request.send();

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(await response.stream.bytesToString());
      if (jsonResponse['success'] == true) {
        // Extract the 'data' field
        final fileUrl = jsonResponse['data'];
        return fileUrl;
      } else {
        print('Request failed');
      }
    } else {
      final respStr = await response.stream.bytesToString();
      print('Upload successful! Response: $respStr');
    }
    return '';

  }

}