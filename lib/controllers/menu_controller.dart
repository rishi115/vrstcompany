import 'package:flutter/material.dart';
import 'package:vrsstranslinkcompany/routing/routes.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = homePageDisplayName.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case homePageDisplayName:
        return _customIcon('assets/home.png', itemName);
      case dashBoardPageDisplayName:
        return _customIcon('assets/dashboard.png', itemName);
      case mapPageDisplayName:
        return _customIcon('assets/Maps.png', itemName);
      case driversPageDisplayName:
        return _customIcon('assets/Drivers.png', itemName);
      case vechilePageDisplayName:
        return _customIcon('assets/Vehicle.png', itemName);
      case roasterPageDisplayName:
        return _customIcon('assets/NodalPoint.png', itemName);
      case employeesPageDisplayName:
        return _customIcon('assets/Employee.png', itemName);
      case settingsPageDisplayName:
        return _customIcon('assets/FilterImage.png', itemName);
      case nodalPointPageDisplayName:
        return _customIcon('assets/NodalPoint.png', itemName);
      case vendorPageDisplayName:
        return _customIcon('assets/company.png', itemName);
      case tripPageDisplayName:
        return _customIcon('assets/Trips.png', itemName);
      case teamPageDisplayName:
        return _customIcon('assets/Teams.png', itemName);
      case helpdeskPageDisplayName:
        return _customIcon('assets/Helpdesk.png', itemName);
      case authenticationPageDisplayName:
        return _customIcon('assets/Logout.png', itemName);
      default:
        return _customIcon('assets/home.png', itemName);
    }
  }

  Widget _customIcon(String imagePath, String itemName) {
    if (isActive(itemName)) {
      return Image.asset(
        imagePath,
        width: 27,
        height: 27, // Optional: Change the color if needed
      );
    } else {
      return Image.asset(
        imagePath,
        width: 27,
        height: 27, // Optional: Change the color if needed
      );
    }
  }


}
