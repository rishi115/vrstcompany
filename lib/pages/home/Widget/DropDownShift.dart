import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../homecontroller/homecontroller.dart';

class SimpleDropdown extends StatefulWidget {
  @override
  _SimpleDropdownState createState() => _SimpleDropdownState();
}

class _SimpleDropdownState extends State<SimpleDropdown> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.selectedValue.isEmpty) {
        return Center(child: CircularProgressIndicator()); // Loading indicator
      }
      return DropdownButton<Map<String, dynamic>>(
        value: homeController.selectedShift.value.isEmpty
            ? (homeController.selectedValue.isNotEmpty
            ? homeController.selectedValue[0]
            : null)
            : homeController.selectedShift.value,
        isExpanded: true,
        elevation: 0,
        underline: Container(),
        items: homeController.selectedValue.map((entry) {
          return DropdownMenuItem<Map<String, dynamic>>(
            value: entry,
            child: Text(
              entry['display'],
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            homeController.selectedShift.value = newValue;
            String shiftId = newValue['metadata']['shiftId'];
            String tripType = newValue['metadata']['tripType'];
            homeController.selectedShiftId.value = shiftId;
            homeController.selectedTripType.value = tripType;
            homeController.refreshApi();
          }
        },
        icon: Icon(Icons.arrow_drop_down),
      );
    });
  }
}
