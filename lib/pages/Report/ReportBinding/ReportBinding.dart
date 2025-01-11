import 'package:get/get.dart';
import '../ReportController/ReportController.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportController());
  }
}