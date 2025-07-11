import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vrsstranslinkcompany/Model/EmployeeListModel.dart';
import 'package:vrsstranslinkcompany/Model/GuardModel.dart';
import 'package:vrsstranslinkcompany/Services/EmployeeService.dart';
import 'package:vrsstranslinkcompany/Services/HomeService.dart';
import 'package:vrsstranslinkcompany/Services/SettingsService.dart';

import '../../../Model/HomeModel.dart';
import '../../../Model/OfficeModel.dart';
import '../../../Model/ShiftModel.dart';
import '../../Setting/AddOffice.dart';

class HomeController extends GetxController {
  var shiftList = <ShiftModel>[].obs;
  final SettingsService settingsService = SettingsService();
  final HomeService homeService = HomeService();
  final EmployeeService employeeService = EmployeeService();
  RxBool isLoading = false.obs;
  var selectedValue = <Map<String, dynamic>>[].obs; // Properly typed observable list
  var selectedShift = <String, dynamic>{}.obs; // Properly typed observable map
  var todayTripList = [].obs;
  var weeklySelected = false.obs;
  var tripAnalytics = TripAnalytics().obs;
  var tripAnalyticsLoading =false.obs;
  var tripLoading = false.obs;
  var vendorDistributionLoading = false.obs;
  var selectedShiftId = ''.obs;
  var selectedTripType = ''.obs;
  var VendorDistribution = VendorDistributionModel().obs;
  var officeList = <OfficeModel>[
    OfficeModel(
      id: '1',
      name: 'VRSSTranslink',
      address: 'Kathmandu, Nepal',
    )
  ].obs;
  var vehicleCount = 0.obs;
  var employeeCount = 0.obs;
  var employeeList = <EmployeeListModel>[].obs;
  var guardList = <GaurdModel>[].obs;
  var guardCount = 0.obs;


  getShiftList() async {
    isLoading.value = true;
    shiftList.value = await settingsService.getAllShift();
    isLoading.value = false; // Update the loading state
  }

  shiftChange(){


  }
  getTripCount() async {
    tripAnalyticsLoading.value = true;
    tripAnalytics.value =
   await homeService.getTripCount(
      shiftId: selectedShiftId.value,
      tripType: selectedTripType.value, period: 'monthly',
    );
    tripAnalyticsLoading.value = false;
  }
  getVendorDistribution() async {
    vendorDistributionLoading.value = true;
    VendorDistribution.value = await homeService.getVendorDistribution(
      selectedShiftId.value,
    );
    vendorDistributionLoading.value = false;
  }
  refreshApi() async {
    tripAnalyticsLoading.value = true;
    vendorDistributionLoading.value = true;

    await Future.wait([
      homeService.getTripCount(
        shiftId: selectedShiftId.value,
        tripType: selectedTripType.value,
        period: 'monthly',
      ),
      homeService.getVendorDistribution(selectedShiftId.value),
    ]).then((value) {
      tripAnalytics.value = value[0] as TripAnalytics;
      tripAnalyticsLoading.value = false;
      VendorDistribution.value = value[1] as VendorDistributionModel;
      vendorDistributionLoading.value = false;
    });
  }
  getAllApi() async {
    isLoading.value = true;
    tripAnalyticsLoading.value = true;
    tripLoading.value = true;
    vendorDistributionLoading.value = true;
    await Future.wait([
      settingsService.getAllOffice(),
      settingsService.getAllShift(),
      homeService.getTripCount(
        shiftId: selectedShiftId.value,
        tripType: selectedTripType.value,
        period: 'monthly',
      ),
      homeService.getTodayTripData(),
        homeService.getVendorDistribution(selectedShiftId.value),
      employeeService.getAllEmployee(),
      settingsService.getGuard(),
    ]).then((value) {
      officeList.value = value[0] as List<OfficeModel>;
      shiftList.value = value[1] as List<ShiftModel>;
      DateTime currentDate = DateTime.now();
      String formattedDate = DateFormat('MMMM dd, yyyy').format(currentDate);

      selectedValue.value = shiftList
          .expand((shift) {
        DateTime loginTime = DateFormat.jm().parse(shift.loginTime!);
        DateTime logoutTime = DateFormat.jm().parse(shift.logoutTime!);
        DateTime combinedLoginTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          loginTime.hour,
          loginTime.minute,
        );
        DateTime combinedLogoutTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          logoutTime.hour,
          logoutTime.minute,
        );

        return [
          {
            'display': "${DateFormat('hh:mm a').format(combinedLoginTime)}, $formattedDate",
            'metadata': {
              'shiftId': shift.id,
              'tripType': 'login',
            },
          },
          {
            'display': "${DateFormat('hh:mm a').format(combinedLogoutTime)}, $formattedDate",
            'metadata': {
              'shiftId': shift.id,
              'tripType': 'logout',
            },
          },
        ];
      })
          .toList()
        ..sort((a, b) {
          // Cast a and b to Map<String, dynamic>
          Map<String, dynamic> entryA = a;
          Map<String, dynamic> entryB = b;

          // Extract and parse time from the display field
          DateTime timeA = DateFormat('hh:mm a').parse(entryA['display']!.split(',')[0]);
          DateTime timeB = DateFormat('hh:mm a').parse(entryB['display']!.split(',')[0]);

          return timeA.compareTo(timeB);
        });



      isLoading.value = false;
      tripAnalytics.value = value[2] as TripAnalytics;
      tripAnalyticsLoading.value = false;
      todayTripList.value = value[3] as List<TripData>;
      tripLoading.value = false;
      VendorDistribution.value = value[4] as VendorDistributionModel;
      vendorDistributionLoading.value = false;
      employeeList.value = value[5] as List<EmployeeListModel>;
      employeeCount.value = employeeList.length;
      guardList.value = value[6] as List<GaurdModel>;
      guardCount.value = guardList.length;





    });

  }

  @override
  void onInit() {
    getAllApi();
    super.onInit();
  }


  
}
