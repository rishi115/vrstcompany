import 'package:vrsstranslinkcompany/Services/LoginService.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../routing/routes.dart';

class AuthController extends GetxController{
  final TextEditingController emailController = TextEditingController();
  RxString email = ''.obs;
  final TextEditingController passwordController = TextEditingController();
  RxString password = ''.obs;
  RxBool isLoading = false.obs;

  LoginService loginService = LoginService();

  @override
  void onInit() {
    // Listen to changes in the text field and update the observable
    emailController.addListener(() {
      email.value = emailController.text;
    });
    passwordController.addListener(() {
      password.value = passwordController.text;
    });
    super.onInit();
  }
  void checkLogin(String email, String password) {
     isLoading.value = true;

      // Get.offAllNamed(CompanyrootRoute);
      loginService.authenticateUserAsCompany(email, password);
      isLoading.value = false;
  }
}