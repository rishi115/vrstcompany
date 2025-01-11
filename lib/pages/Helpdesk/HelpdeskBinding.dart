import 'package:get/get.dart';
import 'HelpdeskController.dart';

class HelpdeskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpdeskController>(() => HelpdeskController());
  }
}