import 'package:get/get.dart';
import 'package:vrsstranslinkcompany/Model/HelpdeskModel.dart';
import 'package:vrsstranslinkcompany/Services/HelpdeskService.dart';

class HelpdeskController extends GetxController {
  final HelpdeskService helpdeskService = HelpdeskService();
  var helpDeskList = <HelpdeskModel>[].obs;

  getHelpdesk() {
    helpdeskService.getHelpdesk().then((value) {
      helpDeskList.assignAll(value);
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHelpdesk();
  }
}