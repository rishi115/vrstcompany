import 'package:flutter/material.dart';
import 'package:vrsstranslinkcompany/pages/404/error.dart';
import 'package:vrsstranslinkcompany/pages/Employee/Employee.dart';
import 'package:vrsstranslinkcompany/pages/Helpdesk/Helpdesk.dart';
import 'package:vrsstranslinkcompany/pages/Map/Map.dart';
import 'package:vrsstranslinkcompany/pages/Report/Report.dart';
import 'package:vrsstranslinkcompany/pages/RoasterPage/screen/RoasterPage.dart';
import 'package:vrsstranslinkcompany/pages/Trips/Trips.dart';
import 'package:vrsstranslinkcompany/pages/home/homepage.dart';
import 'package:get/get.dart';
import '../pages/Employee/EmployeeBinding/EmployeeBinding.dart';
import '../pages/Helpdesk/HelpdeskBinding.dart';
import '../pages/Map/MapBinding.dart';
import '../pages/NodalPoint/NodalPoint.dart';
import '../pages/NodalPoint/NodalPointBinding/NodalPointBinding.dart';
import '../pages/Report/ReportBinding/ReportBinding.dart';
import '../pages/RoasterPage/RoasterBinding/RoasterBinding.dart';
import '../pages/Setting/Setting.dart';
import '../pages/Setting/SettingBinding/SettingBinding.dart';
import '../pages/Trips/TripBinding/TripBinding.dart';
import '../pages/Vendor/VendorBinding.dart';
import '../pages/Vendor/VendorPage.dart';
import '../pages/home/homebinding/homebinding.dart';
import '../routing/routes.dart';

Route<dynamic> companyGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePageRoute:
      return _getPageRoute( HomePage(),binding: HomeBinding());
    case mapPageRoute:
      return _getPageRoute( const MapsScreen(),binding: MapBinding());
    case roasterPageRoute:
      return _getPageRoute( RoasterPage(),binding: RoasterBinding());
    case employeesPageRoute:
      return _getPageRoute( EmployeePage(),binding: EmployeeBinding());
    case nodalPointPageRoute:
      return _getPageRoute( const NodalPoint(),binding: NodalPointBinding());
    case tripPageRoute:
      return _getPageRoute(  TripsScreen(),binding: TripBinding());
    case teamPageRoute:
      return _getPageRoute( PageNotFound());
    case helpdeskPageRoute:
      return _getPageRoute( Helpdesk(),binding: HelpdeskBinding());
    case settingsPageRoute:
      return _getPageRoute( Settings(),binding: SettingBinding());
    case vendorPageRoute:
      return _getPageRoute( CompanyPage(),binding: VendorBinding());
    case reportPageRoute:
      return _getPageRoute( ReportPage(),binding: ReportBinding());
    default:
      return _getPageRoute( const PageNotFound());
  }
}

PageRoute _getPageRoute(Widget child, {Bindings? binding}) {
  if (binding != null) {
    return GetPageRoute(
      settings: RouteSettings(name: child.runtimeType.toString()),
      page: () => child,
      binding: binding,
      transition: Transition.fade,
      maintainState: false,
      // Disable animation
    );

  } else {
    return GetPageRoute(
      settings: RouteSettings(name: child.runtimeType.toString()),
      page: () => child,
      transition: Transition.fade, // Disable animation
      maintainState: false
    );
  }
}
