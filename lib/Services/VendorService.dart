import 'package:dio/dio.dart';
import 'package:vrsstranslinkcompany/Model/VendorModel.dart';

import '../helpers/SharedPreference/shared_preferences_constants.dart';
import '../helpers/SharedPreference/shared_preferences_methods.dart';
import '../helpers/api_constants.dart';
import '../helpers/api_utils.dart';

class VendorService{
  Future<List<VendorModelById>> getVendorByCompanyId() async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.getVendorByCompanyId;
    List<VendorModelById> vendorList = [];
    try {
      String id = await getStringFromCache(SharedPreferenceString.companyId);
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: url + id,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {
        for (var item in response.data['vendors']) {
          vendorList.add(VendorModelById.fromJson(item));
        }
      }
    } catch (e) {
      print('Error adding employee: $e');
    }
    return vendorList;
  }
  Future<VendorModelById> getVendorById(String id) async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.getVendorById;
    VendorModelById vendor =  VendorModelById();
    try {
      String token = await getStringFromCache(
          SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: url + id,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {
        vendor = VendorModelById.fromJson(response.data['vendor']);
      }
    } catch (e) {
      print('Error adding employee: $e');
    }
    return vendor;
  }

}