import 'package:dio/dio.dart';
import 'package:vrsstranslinkcompany/Model/HelpdeskModel.dart';

import '../helpers/SharedPreference/shared_preferences_constants.dart';
import '../helpers/SharedPreference/shared_preferences_methods.dart';
import '../helpers/api_constants.dart';
import '../helpers/api_utils.dart';

class HelpdeskService{
  Future<List<HelpdeskModel>> getHelpdesk() async {
    String url = "${ApiStringConstants.baseurl}${ApiStringConstants.getHelpdeskById}";
    List<HelpdeskModel> complaint = [];
    try {
      String companyId = await getStringFromCache(SharedPreferenceString.companyId);
      String token = await getStringFromCache(SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: url + companyId,
          options: Options(headers:{
            'Authorization': 'Bearer $token',
          }));
      if(response.data['success']==true){
        print('got all complaint successfully');
        for (var item in response.data['data']) {
          complaint.add(HelpdeskModel.fromJson(item));
        }
      }
    } catch (e) {
      print('Error adding complaint: $e');
    }
    return complaint;
  }
}