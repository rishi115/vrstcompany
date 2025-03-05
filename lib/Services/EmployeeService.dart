import 'dart:html';
import 'dart:io';
import 'dart:typed_data';import 'dart:html' as html; // For browser-specific functionality
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


import 'package:dio/dio.dart';
import 'package:vrsstranslinkcompany/Model/EmployeeListModel.dart';
import '../Model/EmployeeDetailsModel.dart';
import '../Model/EmployeeModel.dart';
import '../helpers/SharedPreference/shared_preferences_constants.dart';
import '../helpers/SharedPreference/shared_preferences_methods.dart';
import '../helpers/api_constants.dart';
import '../helpers/api_utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EmployeeService {
  Future<void> registerEmployee(Employee employee,
      String transportInactiveDate, String dateOfBirth,BuildContext context,
      String joiningDate) async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.addEmployee;
    try {
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      String companyId = await getStringFromCache(
          SharedPreferenceString.companyId);
      double lat = double.parse(employee.latitude!);
      double long = double.parse(employee.longitude!);
      final response = await apiUtils.post(url: url,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
          data: {
            "firstName": employee.firstName,
            "middleName": employee.middleName,
            "lastName": employee.lastName,
            "contactNumber": employee.contactNumber,
            "secondaryContactNumber": employee.secondaryContactNumber,
            "employeeId": employee.employeeId,
            "secondaryId": employee.secondaryId,
            "employmentType": employee.employmentType,
            "dateOfBirth": dateOfBirth,
            "gender": employee.gender,
            "email": employee.email,
            "joiningDate": joiningDate,
            "supervisorName": employee.supervisorName,
            "isSupervisor": employee.isSupervisor,
            "transportInactiveDate": transportInactiveDate,
            "rfid": employee.rfid,
            "pickupReimbursementZone": employee.pickupReimbursementZone,
            "dropReimbursementZone": employee.dropReimbursementZone,
            "languagesKnown": employee.languagesKnown,
            "address": employee.address,
            "locality": employee.locality,
            "latitude": lat,
            "longitude": long,
            "age": int.parse(employee.age!),
            "office": employee.office,
            "company": companyId,
            "disability": employee.disability,
            "status": "active",
            "nodalPoint": employee.nodalPoint,
          });

      if (response.data['message'] == 'Employee added successfully') {
        showDialog(
            context:context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Employee Added Successfully'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      employee.firstName = '';
                      employee.middleName = '';
                      employee.lastName = '';
                      employee.contactNumber = '';
                      employee.secondaryContactNumber = '';
                      employee.employeeId = '';
                      employee.secondaryId = '';
                      employee.dateOfBirth = '';
                      employee.email = '';
                      employee.joiningDate = '';
                      employee.supervisorName = '';
                      employee.isSupervisor = false;
                      employee.transportInactiveDate = '';
                      employee.rfid = '';
                      employee.address = '';
                      employee.locality = '';
                      employee.latitude = '';
                      employee.longitude = '';
                      employee.age = '';
                      employee.disability = '';
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        employee.firstName = '';
        employee.middleName = '';
        employee.lastName = '';
        employee.contactNumber = '';
        employee.secondaryContactNumber = '';
        employee.employeeId = '';
        employee.secondaryId = '';
        employee.dateOfBirth = '';
        employee.email = '';
        employee.joiningDate = '';
        employee.supervisorName = '';
        employee.isSupervisor = false;
        employee.transportInactiveDate = '';
        employee.rfid = '';
        employee.address = '';
        employee.locality = '';
        employee.latitude = '';
        employee.longitude = '';
        employee.age = '';
        employee.disability = '';

      }else{
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Employee Not Added'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
      }
    } catch (e) {
      print('Error adding employee: $e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Fill all the fields correctly'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

    }
  }

  Future<List<EmployeeListModel>> getAllEmployee() async {
    String url = "${ApiStringConstants.baseurl}${ApiStringConstants
        .getAllEmployee}";
    List<EmployeeListModel> employeeList = [];
    try {
      String companyId = await getStringFromCache(
          SharedPreferenceString.companyId);
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: url + "/" + companyId,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {
        print('got all employee successfully');
        for (var item in response.data['data']) {
          employeeList.add(EmployeeListModel.fromJson(item));
        }
      }
    } catch (e) {
      print('Error adding employee: $e');
    }
    return employeeList;
  }

  Future<EmployeeDetails> getEmployeeDetails(String id) async {
    String url = ApiStringConstants.baseurl +
        ApiStringConstants.getEmployeeDetails + id;
    EmployeeDetails employeeDetails = EmployeeDetails();
    try {
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: url,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {
        print('got employee details successfully');
        employeeDetails = EmployeeDetails.fromJson(response.data['data']);
      }
    } catch (e) {
      print('Error getting employee details: $e');
    }
    return employeeDetails;
  }

  Future<void> bulkAdd(Uint8List? fileBytes, String name) async {
    String token = await getStringFromCache(SharedPreferenceString.accessToken);
    String url = ApiStringConstants.baseurl + ApiStringConstants.bulkEmployee;
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(url));
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
      // Usually optional for MultipartRequest
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

  // Future<void> employeeReport(String employeeId) async {
  //   Future<void> downloadFile(String url, String fileName) async {
  //     try {
  //       // Create an anchor element with the file URL
  //       final anchor = html.AnchorElement(href: url)
  //         ..target = '_blank'  // Opens the link in a new tab
  //         ..download = fileName // Suggests a name for the downloaded file
  //         ..click();           // Triggers the download
  //
  //       print('Download started for $fileName');
  //     } catch (e) {
  //       print('Error downloading file: $e');
  //     }
  //   }
  //   String company = await getStringFromCache(SharedPreferenceString.companyId);
  //    String fileUrl = ApiStringConstants.baseurl + ApiStringConstants.excelOfEmployeesByCompanyId + company;
  //   const String fileName = 'downloaded_file.pdf';
  //
  //   downloadFile(fileUrl, fileName);
  // }
}