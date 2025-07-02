import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../Services/ReportService.dart';

class ReportController extends GetxController{
  final RxString tripType = 'All'.obs;
  final RxString status = 'All'.obs;
  RxString tripStartDate = ''.obs;
  RxString tripEndDate = ''.obs;
  RxString employeeStartDate = ''.obs;
  RxString employeeEndDate = ''.obs;
  RxString routeStartDate = ''.obs;
  RxString routeEndDate = ''.obs;
  final ReportService _reportService = ReportService();

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
  void setTripType(String value) => tripType.value = value;
  void setStatus(String value) => status.value = value;

void excelOfTrips() {
    _reportService.excelOfTripsByCompanyId(
      'Trips Report',
      tripStartDate.value,
      tripEndDate.value,
      tripType.value,
      status.value,
    );
  }

  void excelOfRoutes() {
    _reportService.excelOfRoutesByCompanyId(
      'Routes Report',
      routeStartDate.value,
      routeEndDate.value,
      tripType.value,
      status.value,
    );
  }

  void excelOfEmployee() {
    _reportService.excelOfEmployeeByCompanyId(
      'Employee Report',
      employeeStartDate.value,
      employeeEndDate.value,
      tripType.value,
    );
  }



}