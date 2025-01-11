import 'package:get/get.dart';

import '../controller/authcontroller.dart';


class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}