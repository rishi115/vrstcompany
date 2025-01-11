import 'package:get/get.dart';

import '../EmployeeController/EmployeeController.dart';


class EmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeController>(() => EmployeeController());
  }
}