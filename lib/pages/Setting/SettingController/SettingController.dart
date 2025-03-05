import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vrsstranslinkcompany/Model/EmployeeListModel.dart';
import 'package:vrsstranslinkcompany/Services/EmployeeService.dart';
import 'package:vrsstranslinkcompany/Services/SettingsService.dart';
import 'package:get/get.dart';
import '../../../Model/EmployeeDetailsModel.dart';
import '../../../Model/GuardModel.dart';
import '../../../Model/OfficeModel.dart';
import '../../../Model/ShiftModel.dart';
import '../../../Model/SupervisorModel.dart';

class SettingController extends GetxController {
  final SettingsService _settingsService = SettingsService();
  final  guard = Guard().obs;
  final office = OfficeModel().obs;
  var LoginTime = DateTime.now().toString().substring(11, 16).obs;
  var logintime = DateTime.now().obs;
  var selectedSupervisorId =false;
  RxInt type=1.obs;
  var employeeListModel = <EmployeeListModel>[].obs;
  final EmployeeService _employeeService = EmployeeService();
  var supervisorList = <SupervisorModel>[].obs;
  var shiftList = <ShiftModel>[].obs;
  var officesList = <OfficeModel>[].obs;
  RxBool loading = false.obs;
  var LogoutTime = DateTime.now().toString().substring(11, 16).obs;
  var logouttime = DateTime.now().obs;
  RxBool SupervisorHover = false.obs;
  var officeName =<String>[].obs;
  var agency=<String>[].obs;
  var agencyList = <AgencyList>[].obs;
  var officeId = ''.obs;
  var offices = ''.obs;
  var agencyId = ''.obs;
  var supervisorId = ''.obs;
  PlatformFile? objFile;
  var image = ''.obs;
  var adharCard = ''.obs;


  Future<String> chooseFileUsingFilePicker() async {
    var result = await FilePicker.platform.pickFiles();
    if (result != null) {
      objFile = result.files.single;
      try {
        // Assuming _driverService.bulkAdd returns a Future<String> that we should await
        String uploadResult = await _settingsService.bulkAdd(objFile!.bytes!, objFile!.name);
        return uploadResult; // Return the result from the upload
      } catch (e) {
        print("Error uploading file: $e");
        return 'Error uploading file: $e'; // Return a meaningful error message
      }
    } else {
      Get.snackbar('No file selected', 'Please select a file', snackPosition: SnackPosition.BOTTOM);
      return 'No file selected'; // Return a message when no file is selected
    }
  }
  void pickTime(BuildContext context,String tripType) async {

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null  && tripType=='Login') {
      LoginTime.value = time.format(context);
      logintime.value = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        time.hour,
        time.minute,
      );

    }else if(time != null && tripType=='Logout'){
      LogoutTime.value = time.format(context);
      logouttime.value = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        time.hour,
        time.minute,
      );
    }

  }

  addSupervisor(String id){
    _settingsService.makeEmployeeSupervisor(id);
  }

  RefreshApi(){
    allApi();
  }
  deleteShift(
      String id
      )
  {
    _settingsService.deleteShift(
      id
    );
    _settingsService.getAllShift();
  }

  getAllShift() async {

    await _settingsService.getAllShift().then((value) {
      shiftList.value = value;
    });
  }
  getAgency() async {
   await _settingsService.getAllAgency().then((value) {
      agencyList.value = value;
    });
  }
createShift() async {
  await  _settingsService.createShift(
      DateFormat('h:mm a').format(logintime.value).toString(),
      DateFormat('h:mm a').format(logouttime.value).toString(),);
  _settingsService.getAllShift();

  }
addGuard(
    BuildContext context
    ) async {
    guard.value.photo = image.value;
    guard.value.adharCard = adharCard.value;
  await _settingsService.addGuard(guard.value,context);}

  Future<void> addOffice(
      BuildContext context
      ) async {
    loading.value = true;
    try {
      await _settingsService.addOffice(office.value);
      Navigator.pop(context);
    } catch (error) {
      print("Failed to add office: $error");
    } finally {
      loading.value = false;
    }
  }

  Future<void> addAgency(
      String name,
      String address,
      String primaryContact,
      String primaryEmail,
      BuildContext context
      )async {
    try {
      await _settingsService.addAgency(
          name,
          address,
          primaryContact,
          primaryEmail,
          context
      );
    } catch (error) {
      print("Failed to add agency: $error");
    } finally {
      loading.value = false;
    }

  }


void allApi() {
    Future.wait([
    _settingsService.getAllShift(),
     _settingsService.getAllOffice(),
      _settingsService.getSupervisor(),
      _settingsService.getAllAgency(),

    ]).then((value) {
      shiftList.value = value[0] as List<ShiftModel>;
      officesList.value = value[1] as List<OfficeModel>;
      supervisorList.value = value[2] as List<SupervisorModel>;
      agencyList.value = value[3] as List<AgencyList>;
    });
    for (var element in officesList) {
      officeName.add(element.name!);
    }
}
void getSupervisor(){
    _settingsService.getSupervisor().then((value) {
      supervisorList.value = value;
    });
  }

void getAllEmployee(){
  _employeeService.getAllEmployee().then((value) {
    employeeListModel.value = value;
  });
  }

void getAllOffice(){
  _settingsService.getAllOffice().then((value) {
    officesList.value = value;
  });
  }

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    allApi();
    getAllEmployee();
  }
}


