
import 'controllers/AuthService.dart';
import 'routing/routes.dart';
import 'helpers/SharedPreference/shared_preferences_constants.dart';
import 'helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
class PreLoginCacheService {
  Future<String> getPreLoginDataFromCache() async {
    bool isLoggedIn =
    await getBooleanFromCache(SharedPreferenceString.isLoggedIn);
    String token = await getStringFromCache(SharedPreferenceString.accessToken);
    if (isLoggedIn && token.isNotEmpty) {
      return CompanyrootRoute;
    }
    return authenticationPageRoute;
  }
}

class PremiumGuard extends GetMiddleware {
  final authService = Get.find<AuthService>();


  @override
  RouteSettings? redirect(String? route) {
    return authService.isPremium.value
        ? null
        : const RouteSettings(name: authenticationPageRoute);
  }
}

