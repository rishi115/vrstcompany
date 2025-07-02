import 'package:get/get.dart';
import 'package:vrsstranslinkcompany/Model/HelpdeskModel.dart';
import 'package:vrsstranslinkcompany/Services/HelpdeskService.dart';

class HelpdeskController extends GetxController {
  final HelpdeskService helpdeskService = HelpdeskService();
  var helpDeskList = <HelpdeskModel>[].obs;
  var isLoading = false.obs;


  getHelpdesk() async {
    isLoading(true);
    try{
    await helpdeskService.getHelpdesk().then((value) {
      helpDeskList.assignAll(value);
    });
    }finally{
      isLoading(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHelpdesk();
  }
}