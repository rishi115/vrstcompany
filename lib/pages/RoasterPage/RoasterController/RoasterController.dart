import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:vrsstranslinkcompany/Model/CompanyVendorModel.dart';
import 'package:vrsstranslinkcompany/Model/VehicleModel.dart';
import 'package:vrsstranslinkcompany/Services/NodalService.dart';
import 'package:vrsstranslinkcompany/Services/RaosterService.dart';
import 'package:vrsstranslinkcompany/Services/RouteService.dart';
import 'package:vrsstranslinkcompany/Services/SettingsService.dart';
import 'package:vrsstranslinkcompany/Services/TripService.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:vrsstranslinkcompany/Services/VendorService.dart';
import '../../../Model/NodalPointModel.dart';
import '../../../Model/OfficeModel.dart';
import '../../../Model/RoasterModel.dart';
import '../../../Model/RouteModel.dart';
import '../../../Model/ShiftModel.dart';
import '../../../Model/VendorModel.dart';
import '../MakeRoute.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RoasterController extends GetxController{

  RoasterService roasterService = RoasterService();
  // final TripService tripService = TripService();
  var vehicleList = <VehicleCapacity>[].obs;
  final VendorService vendorService = VendorService();
  final SettingsService _settingsService = SettingsService();
  var shiftList = <ShiftModel>[].obs;
  RxString shiftId="".obs;
  RxBool loading = false.obs;
  var Rxroasters = RoasterModel().obs;
  final NodalService nodalService = NodalService();
  RxString timeInHour = "0 sec".obs;
  RxString selectedType = "Select".obs;
  var nodalList = <NodalPointModel>[].obs;
  ValueNotifier<List<ValueItem>> filteredShiftOptions = ValueNotifier([]);
  ValueNotifier<ValueItem?> selectedShift = ValueNotifier(null);
  RxString startPointName = "".obs;
  RxInt totalDistance = 0.obs;
  var companyRoute = <RouteModel>[].obs;
  var polylineCoordinates = <LatLng>[].obs;
  final locationPolylines = <Polyline>[].obs;
  var Dialogmarkers = <Marker>[].obs;
  Rx<LatLng> original = const LatLng(  19.2183, 72.9781).obs;
  RxBool mapLoader = false.obs;
  var MapController = Completer<GoogleMapController>().obs;
  var officeList =[].obs;
  var officeName = "".obs;
  var isCalculating = false.obs;
  var officeId = "".obs;
  var officeLoading   = false.obs;
  var officelist = [{'Select Office', '8768'}].obs;
  var officeListMap = <String>[].obs;
  var routeListModel = <RouteModel>[].obs;
  var map = <String, String>{};
  var selectedRoute = <String>[].obs;
  var selectedRoaster = [].obs;
  RxBool hasRoute = false.obs;
  var selectedDate = "".obs;
  var expandedList = [].obs;
  int? lastCutIndex;
  var cutEmployees = [].obs;
  var shiftTime = <String>[].obs;
  var ApproveVendor = <String>[].obs;
  RxBool isApproveVendor = false.obs;
  RxList<Routes> routes = <Routes>[].obs;
  var vendorList = <VendorModelById>[].obs;
  var cutEmployee = Rxn<Employees>(); // Rxn allows nullable reactive variables
  RxList<Routes> modifiedRoutes = <Routes>[].obs;
  var officeLocation = Rx<LatLng>(const LatLng(19.2183, 72.9781)); // Default office location
  var isSelectedVehicle = <String>[].obs;
  var selectedVehicleCapacity = 0.obs;
  var roasterTotal = 0.obs;
  var isSplitRoute = false.obs;
  var employeeSplit = <Employees>[].obs;
  var employeeSplitId = <String>[].obs;
  var routeSplit = Rxn<Routes>();

  bool canSelectRoute(bool isAssignedRoute)  {
    return ApproveVendor.isEmpty ||
        ApproveVendor.every((id) =>
        Rxroasters.value.routes
            ?.firstWhere((r) => r.id == id)
            .vehicleAssignedByVendor == isAssignedRoute);
  }
  Future<void> cutEmployeeFromRoute(int routeIndex, int employeeIndex) async {
    if(isSplitRoute.value == true) {
      Get.snackbar(
        'Split Route',
        'Please complete the split route operation first'
      );
      return; // Prevent cutting an employee if in split route mode
    }
    if (cutEmployee.value != null) {
      Get.snackbar(
        'Employee already cut',
        'Please paste the employee'
      );
      return; // Prevent cutting another employee
    }


    var employees = routes[routeIndex].employees!;
    if (employeeIndex >= 0 && employeeIndex < employees.length) {
      cutEmployee.value = employees.removeAt(employeeIndex);
      await calculatePickupTimes(employees);

      if (!modifiedRoutes.contains(routes[routeIndex])) {
        modifiedRoutes.add(routes[routeIndex]); // Add source route
      }

      print("Employee cut: ${cutEmployee.value?.employeeName}");
    } else {
      print("Invalid employee index for cut operation");
    }
  }
  Future<void> deleteEmployeeFromRoute(int routeIndex, int employeeIndex) async {
    if(isSplitRoute.value == true) {
      Get.snackbar(
          'Split Route',
          'Please complete the split route operation first'
      );
      return; // Prevent cutting an employee if in split route mode
    }
    var employees = routes[routeIndex].employees!;
    if (employeeIndex >= 0 && employeeIndex < employees.length) {
      employees.removeAt(employeeIndex);
      await calculatePickupTimes(employees);

      if (!modifiedRoutes.contains(routes[routeIndex])) {
        modifiedRoutes.add(routes[routeIndex]); // Add source route
      }
    } else {
      print("Invalid employee index for cut operation");
    }
  }
  void resetCutEmployee() {
    if(isSplitRoute.value == true) {
      Get.snackbar(
          'Split Route',
          'Please complete the split route operation first'
      );
      return; // Prevent cutting an employee if in split route mode
    }
    if (cutEmployee.value != null) {
      Get.snackbar(" Employee Reset", "Employee has been reset");
      cutEmployee.value = null; // Clear the cut employee
    } else {
      print("No cut employee to reset.");
    }
  }

  Future<void> saveModifiedRoutes() async {
    for (var route in modifiedRoutes) {
      await roasterService.updateRoute(
          route.employees!,
        route.id!,
      ); // Send each modified route
    }
    modifiedRoutes.clear(); // Clear the list after saving
  }


  Future<void> pasteEmployeeToRoute(int routeIndex, int position) async {
    if(isSplitRoute.value == true) {
      Get.snackbar(
          'Split Route',
          'Please complete the split route operation first'
      );
      return; // Prevent cutting an employee if in split route mode
    }
    if (cutEmployee.value != null) {
      var employees = routes[routeIndex].employees!;
      if (position >= 0 && position <= employees.length) {
        print("Cut employee: ${cutEmployee.value?.nodalId}, Position: $position");
        employees.insert(position, cutEmployee.value!); // Use reactive variable's value
        cutEmployee.value = null; // Clear the cutEmployee after pasting
        await calculatePickupTimes(employees); // Recalculate pickup times for the updated route
        if (!modifiedRoutes.contains(routes[routeIndex])) {
          modifiedRoutes.add(routes[routeIndex]); // Add destination route
        }
      } else {
        print("Invalid position for paste operation");
      }
    } else {
      print("No employee available to paste");
    }
  }
  Future<void> moveEmployeeUp(int routeIndex, int employeeIndex) async {
     if(isSplitRoute.value == true) {
      Get.snackbar(
          'Split Route',
          'Please complete the split route operation first'
      );
      return; // Prevent cutting an employee if in split route mode
    }
    if (cutEmployee.value != null) {
      Get.snackbar(
          'Employee already cut',
          'Please paste the employee'
      );      return;
    }
    if (employeeIndex > 0) {
      var employees = routes[routeIndex].employees!;
      employees.insert(employeeIndex - 1, employees.removeAt(employeeIndex));
      await calculatePickupTimes(employees);
      if (!modifiedRoutes.contains(routes[routeIndex])) {
        modifiedRoutes.add(routes[routeIndex]); // Add route to the list
      }    }
  }
  Future<void> moveEmployeeDown(int routeIndex, int employeeIndex) async {
    if(isSplitRoute.value == true) {
      Get.snackbar(
          'Split Route',
          'Please complete the split route operation first'
      );
      return; // Prevent cutting an employee if in split route mode
    }
    if (cutEmployee.value != null) {
      Get.snackbar(
          'Employee already cut',
          'Please paste the employee'
      );      return;
    }
    var employees = routes[routeIndex].employees!;
    if (employeeIndex < employees.length - 1) {
      employees.insert(employeeIndex + 1, employees.removeAt(employeeIndex));
      await calculatePickupTimes(employees);
      if (!modifiedRoutes.contains(routes[routeIndex])) {
        modifiedRoutes.add(routes[routeIndex]); // Add route to the list
      }
    }
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    try {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
    } catch (e) {
      print('Error loading image: $e');
      rethrow;
    }
  }
  Future<void> addMarker(LatLng latLng, String markerId,String path) async {
    try {
      final Uint8List markerIcon = await getBytesFromAsset(path, 50);

      final Marker marker = Marker(
        markerId: MarkerId(markerId),
        position: latLng,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        infoWindow: const InfoWindow(title: 'Searched Location'),
      );
      Dialogmarkers.add(marker);
    } catch (e) {
      print('Error adding marker: $e');
    }
  }

  addNormalMarker(
      LatLng latLng,
      bool isOffice
      )
  async {
    final Uint8List markerIcon = await getBytesFromAsset("assets/home.png", 30);
    final Uint8List markerIconOffice = await getBytesFromAsset("assets/company.png", 50);

    final Marker marker = Marker(
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      icon: isOffice? BitmapDescriptor.fromBytes(markerIconOffice):
      BitmapDescriptor.fromBytes(markerIcon),
      infoWindow: const InfoWindow(title: 'Searched Location'),
    );

    Dialogmarkers.add(marker);
  }
  Future<void> deleteRoaster(String roasterId) async {
    await roasterService.deleteRoaster(
      roasterId
    );
    getRoaster();
  }

  Future<void> switchBetweenNodalAndHome(
      String roasterId
      ) async {
    await roasterService.switchBetweenNodalAndHome(
        roasterId
    );
  }
  Future<void> _drawRoute(
      String originLatitude, String originLongitude,
      String destinationLatitude, String destinationLongitude,
      bool isOffice) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://vr-safetrips.onrender.com/api/direction/get'));
    request.body = json.encode({
      "origin": {
        "lat": originLatitude,
        "lng": originLongitude
      },
      "destination": {
        "lat": destinationLatitude,
        "lng": destinationLongitude
      }
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("response is here");
      if (isOffice == true) {
        addNormalMarker(
            LatLng(double.parse(originLatitude),
                double.parse(originLongitude)),
                true
        );
      }else {
        addNormalMarker(
            LatLng(double.parse(originLatitude),
                double.parse(originLongitude)), false
        );
      }
      final data = json.decode(await response.stream.bytesToString());
      final points = data["data"]['routes'][0]['overview_polyline']['points'];

      try {
        List<PointLatLng> decodedPoints = PolylinePoints().decodePolyline(points);
        for (var point in decodedPoints) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
        locationPolylines.add(
          Polyline(
            polylineId: PolylineId('route'),
            color: Colors.blue,
            points: polylineCoordinates,
            width: 2,
          ),
        );

      } catch (e) {
        print("error is here");
      }

    } else {
      throw Exception('Failed to load directions');
    }
  }
  Future<void> calculatePickupTimes(
      List<Employees> employees
      ) async {
    isCalculating.value = true;
    // Parse the shift start time into a DateTime object
    DateFormat timeFormat = DateFormat("h:mm a");
    DateTime currentArrivalTime = timeFormat.parse(selectedShift.value!.label);

    // Start from the company to the last employee
    for (int i = employees.length - 1; i >= 0; i--) {
      final Employees current = employees[i];

      // Construct the Distance Matrix API URL
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('https://vr-safetrips.onrender.com/api/direction/get'));
      request.body = json.encode({
        "origin": {
          "lat": original.value.latitude,
          "lng": original.value.longitude
        },
        "destination": {
          "lat": current.pickupLocation!.latitude!,
          "lng": current.pickupLocation!.longitude!
        }
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final data = json.decode(await response.stream.bytesToString());
        int travelTimeInSeconds = 0;
        try {
          final durationValue = data['data']['routes'][0]['legs'][0]['duration']['value'];

          // Check if the value is already an integer
          if (durationValue is int) {
             travelTimeInSeconds = durationValue;
          } else {
            throw Exception("Unexpected type for duration value: ${durationValue.runtimeType}");
          }

          print("Travel time: $travelTimeInSeconds seconds");

          // Calculate the required pickup time for the current employee
          DateTime pickupTime = currentArrivalTime
              .subtract(Duration(seconds: travelTimeInSeconds))
              .add(const Duration(minutes: 5)); // Add 5 minutes buffer

          current.pickupTime = timeFormat.format(pickupTime); // Convert to 12-hour AM/PM format

          // Update the company location to this employee's location for the next calculation
          original.value = LatLng(current.pickupLocation!.latitude!, current.pickupLocation!.longitude!);
          currentArrivalTime = pickupTime;
          isCalculating.value = false;
        } catch (e) {
          print("Error parsing travel time: $e");
        }

      } else {
        throw Exception('Failed to fetch travel time: ${response.statusCode}');
      }
    }
  }
  Future<void> animateCameraToBounds(LatLngBounds bounds, {double padding = 50.0}) async {
    // Ensure the controller is available
    if (MapController.value.isCompleted) {
      await Future.delayed(Duration(milliseconds: 200));
      final GoogleMapController controller = await MapController.value.future;

      try {
        // Animate the camera
        await controller.animateCamera(
          CameraUpdate.newLatLngBounds(bounds, padding),
        );
      } catch (e) {
        print("Error animating camera: $e");
      }
    } else {
      print("MapController is not ready yet!");
    }
  }
  routeDraw(
      Routes routeModel,
      ) async {
    mapLoader.value = true;
    // Clear the previous polylines and markers.
    locationPolylines.clear();
    Dialogmarkers.clear();
    polylineCoordinates.clear();

    // Draw the initial route from the office location to the last employee's nodal point.
    await _drawRoute(
      officeLocation.value.latitude.toString(),
      officeLocation.value.longitude.toString(),
      routeModel.employees!.last.nodalLat!.toString(),
      routeModel.employees!.last.nodalLng!.toString(),
      true,
    );

    // Iterate through the employees and draw routes between their nodal points.
    for (int i = routeModel.employees!.length - 1; i > 0; i--) {
      // Skip duplicate or invalid points.
      if (routeModel.employees![i].nodalLat.toString() == routeModel.employees![i].nodalLng.toString() &&
          routeModel.employees![i - 1].nodalLat.toString() == routeModel.employees![i - 1].nodalLng.toString()) {
        continue;
      }

      // Draw the route between two nodal points.
      await _drawRoute(
        routeModel.employees![i].nodalLat.toString(),
        routeModel.employees![i].nodalLng.toString(),
        routeModel.employees![i - 1].nodalLat.toString(),
        routeModel.employees![i - 1].nodalLng.toString(),
        false
      );

      // Add a marker after drawing the route for the current nodal point.
    }

    LatLngBounds getLatLngBounds(Routes routeModel) {
      final List<LatLng> points = routeModel.employees!.map((employee) {
        return LatLng(
          employee.nodalLat!.toDouble(),
          employee.nodalLng!.toDouble(),
        );
      }).toList();

      LatLng southwest = LatLng(
        points.map((p) => p.latitude).reduce((a, b) => a < b ? a : b),
        points.map((p) => p.longitude).reduce((a, b) => a < b ? a : b),
      );

      LatLng northeast = LatLng(
        points.map((p) => p.latitude).reduce((a, b) => a > b ? a : b),
        points.map((p) => p.longitude).reduce((a, b) => a > b ? a : b),
      );

      return LatLngBounds(southwest: southwest, northeast: northeast);
    }

    final LatLngBounds bounds = getLatLngBounds(routeModel);
    animateCameraToBounds(bounds);

    mapLoader.value = false;
  }

  void filterShiftsByType(String type) {
    var filteredList = <ValueItem>[
      const ValueItem(label: "Select", value: 1)
    ];
  if (type == "login") {
    filteredList = shiftList
        .map((shift) =>
        ValueItem(label:
            shift.loginTime!
        , value: shift.id))
        .toList();
  }else{
    filteredList = shiftList
        .map((shift) =>
        ValueItem(label:
            shift.logoutTime!
        , value: shift.id))
        .toList();
  }

    filteredShiftOptions.value = filteredList.isEmpty
        ? [const ValueItem(label: "Select", value: 1)]
        : filteredList;

    selectedShift.value = filteredShiftOptions.value.isNotEmpty
        ? (selectedShift.value != null && filteredShiftOptions.value.contains(selectedShift.value))
        ? selectedShift.value
        : filteredShiftOptions.value.first
        : null;
  }
  Future<void> SelectDate(BuildContext context,RxString datepicked) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year),
      lastDate: DateTime(currentDate.year + 2),
    );
    if(picked != null && picked != currentDate){
      selectedDate.value = picked.toString();
    }
  }
  getRoaster() async {
    loading.value = true;
    try {
      if (shiftId.value == "") {
        shiftId.value = shiftList[0].id!;
      }

      Rxroasters.value = await roasterService.getRoasterByDate(
        selectedDate.value.substring(0, 10),
        shiftId.value,
        officeId.value,
        1,
        selectedType.value,
        10,
      );

      if (Rxroasters.value.routes != null && Rxroasters.value.routes!.isNotEmpty) {
        routes.value = Rxroasters.value.routes!;
        roasterTotal.value = Rxroasters.value.rosters?.length ?? 0;
        hasRoute.value = true;
      } else {
        hasRoute.value = false;
      }
    } catch (e) {
      // Handle the error here, e.g., log it or show a user-friendly message
      print("Error occurred in getRoaster: $e");
      hasRoute.value = false;
    } finally {
      loading.value = false;
    }
  }


  getVehicle() async {
    loading.value = true;
    officeLoading.value = true;
   await Future.wait([
     _settingsService.getAllShift(),
    nodalService.getAllNodalPoint(),
      _settingsService.getAllOffice(),
    roasterService.getVehicleCapacity(),
    ]).then((value) {
      shiftList.value = value[0] as List<ShiftModel>;
      nodalList.value = value[1] as List<NodalPointModel>;
      officeList.value = value[2] as List<OfficeModel>;
      vehicleList.value = value[3] as List<VehicleCapacity>;
    });
   for (var element in officeList) {
      officelist.add({element.name, element.id});
    }
    map= {
       for (var set in officelist) set.first: set.last
    };
     officeListMap.value = await map.keys.toList();
    officeLoading.value = false;
    loading.value = false;


  }
  // navigateToMakeRoute(context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => MakeRoute()));
  // }

  reset(){
    selectedDate.value = "";
    shiftId.value = "";
    officeId.value = "";
  }

  updateVendor(
      String vendorId,
      String vendorName,
      String routeId
      ) async {
   await  roasterService.updateVendor(
      vendorId,vendorName,routeId
    );
   getRoaster();
    Get.snackbar(
      'Route Updated',
      'Route has been updated successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  routeNow() async {
    await roasterService.getRoutes(
        selectedDate.value.substring(0,10),
        shiftId.value,
        officeId.value,
        1,
        10,
        selectedType.value,
        isSelectedVehicle
    );
  }
  approveVendor() async {
    await roasterService.approveVendor(
        ApproveVendor
    );
    Get.snackbar(
      'Vendor Approve',
      'Route has been sent to Vendor successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    await getRoaster();
  }
  getVendor() async {
    vendorList.value = await vendorService.getVendorByCompanyId();
  }
  publishRoute() async {
    // Check if all approved vendors have a vehicle assigned
    final invalidRoutes = ApproveVendor.where((id) {
      final route = Rxroasters.value.routes?.firstWhere(
            (r) => r.id == id,
        orElse: () => null as Routes,
      );
      return route == null || route.vehicleAssignedByVendor != true;
    }).toList();

    if (invalidRoutes.isNotEmpty) {
      Get.snackbar(
        'Error',
        'One or more selected routes do not have vehicles assigned',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Proceed if all validations pass
    await roasterService.publishRoute(ApproveVendor);
    Get.snackbar(
      'Route Published',
      'Route has been published successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
  splitRoute() async {
    await roasterService.splitRoute(
     employeeSplit,
      routeSplit.value!,
    );

  }




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVehicle();
  }


}