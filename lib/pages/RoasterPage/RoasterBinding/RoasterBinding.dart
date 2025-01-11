import '../RoasterController/RoasterController.dart';
import 'package:get/get.dart';

class RoasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoasterController>(() => RoasterController());
  }
}
