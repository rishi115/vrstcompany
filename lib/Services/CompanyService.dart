import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/CompanyVendorModel.dart';
import '../helpers/SharedPreference/shared_preferences_constants.dart';
import '../helpers/SharedPreference/shared_preferences_methods.dart';
import '../helpers/api_constants.dart';
import '../helpers/api_utils.dart';
import '../widgets/custom_text.dart';

class CompanyService{
  Future<List<CompanyModelVendor>> getCompanyByVendorId() async {
    String url = ApiStringConstants.baseurl +
        ApiStringConstants.getCompanyByVendorId;
   List<CompanyModelVendor> companyList = [];
    try {
      String token = await getStringFromCache(SharedPreferenceString.accessToken);
      String vendorId = await getStringFromCache(SharedPreferenceString.vendorId);
      final response = await apiUtils.get(url: "$url$vendorId",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        for (var item in response.data['data']) {
          companyList.add(CompanyModelVendor.fromJson(item));
        }
      }
    } catch (e) {
      print('Error getting company details: $e');
    }
    return companyList;
  }
  Future<CompanyModel> getCompanyById(String id) async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.getCompanyById;
    CompanyModel companyModel = CompanyModel();
    try {
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: url + id,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {
        companyModel = CompanyModel.fromJson(response.data['data']);
      }
    } catch (e) {
      print('Error adding employee: $e');
    }
    return companyModel;
  }
  Future<void> assignVehicleToCompany( String vehicleId) async{
    String url = ApiStringConstants.baseurl + ApiStringConstants.assignVehicleToCompany;
    String vendorId = await getStringFromCache(SharedPreferenceString.vendorId);
    try {
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.put(url: '$url/$vehicleId',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
        data: {
          'company': vendorId,
        },
      );
      if (response.data['success'] == true) {
        Get.dialog(
          AlertDialog(
            backgroundColor: Colors.white,
            title: const CustomText(text:'VEHICLE ASSIGNED TO COMPANY!'),
            content: Container(
              width: 400,
              height: 100,
              child: const Column(
                children: [
                  CustomText(text:'VEHICLE ASSIGNED SUCCESSFULLY!'),
                ],
              ),
            ),
            actions: [
            ],
          ),
        );
      }
    } catch (e) {
      print('Error adding employee: $e');
    }
  }


}