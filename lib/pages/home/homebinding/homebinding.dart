import 'package:get/get.dart';

import '../homecontroller/homecontroller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}