import 'package:vrsstranslinkcompany/Model/TripData.dart';
import 'package:vrsstranslinkcompany/Services/TripService.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../ScheduleTrip/ScheduleTrip.dart';

class TripController extends GetxController {
  RxString monthYear = "${Month[DateTime.now().month]}  ${DateTime.now().year.toString().substring(2)}".obs;
  final TripService tripService = TripService();
  RxString day = DateTime.now().day.toString().obs; // Corrected day assignment
  RxString selectedDriver = "Driver 1".obs;
  RxBool loading = false.obs;
  RxString time = "09:30 PM".obs;
  var tripList = <TripByDate>[].obs;
  var selectedDate = DateTime.now().obs;
  Future<void> selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(currentDate.year + 1),
    );
    if (picked != null && picked != currentDate) {
      // Format selected date
      String selectedMonthYear = "${Month[picked.month]}  ${picked.year.toString().substring(2)}";
      // Update monthYear with selected month and year
      monthYear.value = selectedMonthYear;
      selectedDate.value = picked;
      // Update day with selected day
      day.value = picked.day.toString();
      tripList.clear();
      getTripByCompanyId();
    }
  }
  Future selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (selectedTime != null) {
      // Format selected time
      String formattedTime = "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}";
      // Update time with selected time
      time.value = formattedTime;
    }
  }
  var openContainer=<int>[].obs;

  void toggleContainer(int index) {
    if (openContainer.contains(index)) {
      openContainer.remove(index);
    } else {
      openContainer.add(index);
    }
  }

    getTripByCompanyId() async {
    loading.value = true;
    tripList.value = await tripService.getTripByCompanyId(
        selectedDate.value.toString().split(' ')[0]
    );
    print(tripList.length);
    loading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getTripByCompanyId();
  }
}
