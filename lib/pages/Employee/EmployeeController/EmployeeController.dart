import 'dart:typed_data';

import 'package:vrsstranslinkcompany/Model/EmployeeDetailsModel.dart';
import 'package:vrsstranslinkcompany/Model/EmployeeListModel.dart';
import 'package:vrsstranslinkcompany/Services/EmployeeService.dart';
import 'package:vrsstranslinkcompany/Services/NodalService.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vrsstranslinkcompany/Services/SettingsService.dart';

import '../../../Model/EmployeeModel.dart';
import '../AddEmployeeContainer/AddEmployee.dart';
import '../AddEmployeeContainer/AddInBulk.dart';
import '../Widget/EmployeeLocation/Employeelocation.dart';

class EmployeeController extends GetxController{
  final employee = Employee().obs;
  final EmployeeService _employeeService = EmployeeService();
  final NodalService _nodalService = NodalService();
  RxString selectedCategory = 'Male'.obs;
  var otherTextController = TextEditingController();
  final SettingsService _settingsService = SettingsService();
  var officeList = [].obs;
  RxString launguageknown = 'English'.obs;
  RxString isSuperVisor = ''.obs;
  RxString TransportInactiveday = ''.obs;
  RxString DateofBirth = ''.obs;
  RxString DateofJoining = ''.obs;
  RxString employmenttype = 'Permanent'.obs;
  var employeeList= <EmployeeListModel>[].obs;
  var filterEmployeeList= <EmployeeListModel>[].obs;
  var nodalList = [].obs;
  var loading = false.obs;
  var officeName = ''.obs;

  Future<void> SelectDate(BuildContext context,RxString datepicked) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 100),
      lastDate: DateTime(currentDate.year + 1),
    );
    if(picked != null && picked != currentDate){
      datepicked.value = picked.toString();
    }
  }
  addemployee(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEmployeePage()));
  }
  gotolocation(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  GlobalLocation(
      Latitude: employee.value.latitude!,
      Longitude: employee.value.longitude!,
    )));
  }
  addEmployeeInbulk(
      BuildContext context,
      ){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEmployeeInBulk()));
  }
  addInBulk(
      Uint8List bytes,
      String fileName,
      ){
    _employeeService.bulkAdd(
      bytes,fileName
    );
  }

  // getReport(String id){
  //   _employeeService.employeeReport(id);
  // }

  registerEmployee(){
  employee.value.gender ??= selectedCategory.value;
  employee.value.languagesKnown ??= [launguageknown.value];
  employee.value.isSupervisor ??= false;
  employee.value.employmentType ??= employmenttype.value;
  employee.value.pickupReimbursementZone ??= ['Dhaka'];
  employee.value.dropReimbursementZone ??= ['Dhaka'];

  _employeeService.registerEmployee(employee.value,
      TransportInactiveday.value,DateofBirth.value,DateofJoining.value);
  }

  Future<EmployeeDetails> getEmployeeDetails(String id){
    return _employeeService.getEmployeeDetails(id);
  }

  Future<void> getAllEmployee()async {
    loading.value = true;
    _employeeService.getAllEmployee().then((value) {
      employeeList.value = value;
      filterEmployeeList.value = value;
    });
    loading.value = false;
  }


  void listFilter(String value) {
    if (value.isEmpty) {
      filterEmployeeList.value = List.from(employeeList);
    } else {
      filterEmployeeList.value = employeeList.where((element) {
        final companyName = element.firstName?.toLowerCase();
        return companyName != null && companyName.contains(value.toLowerCase());
      }).toList();
    }
  }
  Future<void> allApi() async {
    loading.value = true;
    await Future.wait([
    _employeeService.getAllEmployee(),
    _nodalService.getAllNodalPoint(),
      _settingsService.getAllOffice()
    ]).then((value) {
      employeeList.value = value[0] as List<EmployeeListModel>;
      filterEmployeeList.value = value[0] as List<EmployeeListModel>;
      nodalList.value = value[1];
      officeList.value = value[2];
    });
    loading.value = false;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    allApi();
  }


  
}