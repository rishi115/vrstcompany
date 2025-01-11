import 'package:get/get.dart';

import '../TripController/TripController.dart';

class TripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripController>(() => TripController());
  }
}
