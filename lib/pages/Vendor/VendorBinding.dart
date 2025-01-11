import 'package:get/get.dart';

import 'VendorController.dart';

class VendorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorController>(() => VendorController());
  }
}