import 'package:get/get.dart';

import '../NodalPointController/NodalPointController.dart';


class NodalPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NodalPointController>(() => NodalPointController());
  }
}