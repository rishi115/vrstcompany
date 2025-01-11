import 'package:vrsstranslinkcompany/controllers/AuthService.dart';
import 'package:vrsstranslinkcompany/helpers/SharedPreference/shared_preferences_constants.dart';
import 'package:vrsstranslinkcompany/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:vrsstranslinkcompany/helpers/api_constants.dart';
import 'package:vrsstranslinkcompany/routing/routes.dart';
import 'package:get/get.dart';
import '../helpers/api_utils.dart';

class LoginService{
 void authenticateUserAsCompany(String username, String password) async {
   AuthService authService = Get.find<AuthService>();
    String url = ApiStringConstants.baseurl + ApiStringConstants.companyLogin;
    try {

      final response = await apiUtils.post(url: url, data: {
        "email": username,
        "password": password
      });

     if(response.data['message']=='Login successfull'){
       setBooleanIntoCache(SharedPreferenceString.isLoggedIn, true);
       setStringIntoCache(SharedPreferenceString.accessToken, response.data['token']);
        setStringIntoCache(SharedPreferenceString.companyId, response.data["data"]['_id']);

       authService.setIsPremium(true);
       Get.offAllNamed(CompanyrootRoute);

     }else{
        Get.snackbar('Error',"Invalid credentials");
     }

    } catch (e) {
      Get.snackbar('Error',"Invalid credentials");
      return null;
    }
  }
}