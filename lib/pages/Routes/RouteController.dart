// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import '../../Model/DriverListModel.dart';
// import '../../Model/RouteModel.dart';
// import '../../Services/DriverService.dart';
// import '../../Services/RouteService.dart';
//
// class RouteController extends GetxController{
//   var mapController = Completer<GoogleMapController>().obs;
//   final RouteService _routeService = RouteService();
//   final DriverService _driverService = DriverService();
//   var routeList= <RouteModel>[].obs;
//   var routeDetails = RouteModel().obs;
//   var isLoading = true.obs;
//   var polylineCoordinates = <LatLng>[].obs;
//   final polylines = <Polyline>[].obs;
//   final markers = <Marker>[].obs;
//   Rx<LatLng> origin = const LatLng(19.132296753365175, 73.00226250708334).obs;
//   RxBool mapLoader = false.obs;
//   var driverList = <DriverListModel>[].obs;
//
//   getRoutesByVendorId() async {
//     try {
//       isLoading(true);
//       routeList.value = await _routeService.getRoutes();
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> _drawRoute(
//       String originLatitude, String originLongitude,
//       String destinationLatitude, String destinationLongitude
//       ) async {
//     var headers = {
//       'Content-Type': 'application/json'
//     };
//     var request = http.Request('POST', Uri.parse('https://vr-safetrips.onrender.com/api/direction/get'));
//     request.body = json.encode({
//       "origin": {
//         "lat": originLatitude,
//         "lng": originLongitude
//       },
//       "destination": {
//         "lat": destinationLatitude,
//         "lng": destinationLongitude
//       }
//     });
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       final data = json.decode(await response.stream.bytesToString());
//       final points = data["data"]['routes'][0]['overview_polyline']['points'];
//
//       try {
//         List<PointLatLng> decodedPoints = PolylinePoints().decodePolyline(points);
//         for (var point in decodedPoints) {
//           polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//         }
//         polylines.add(
//             Polyline(
//               polylineId: PolylineId('route'),
//               color: Colors.blue,
//               points: polylineCoordinates,
//               width: 5,
//             ),
//           );
//
//       } catch (e) {
//         print("error is here");
//       }
//
//       // Move the camera to fit the route
//       final bounds = _getLatLngBounds( LatLng(19.132296753365175, 73.00226250708334), LatLng(double.parse(destinationLatitude), double.parse(destinationLongitude)));
//
//     } else {
//       throw Exception('Failed to load directions');
//     }
//   }
//
//   LatLngBounds _getLatLngBounds(LatLng origin, LatLng destination) {
//     double latMin = origin.latitude < destination.latitude ? origin.latitude : destination.latitude;
//     double latMax = origin.latitude > destination.latitude ? origin.latitude : destination.latitude;
//     double lngMin = origin.longitude < destination.longitude ? origin.longitude : destination.longitude;
//     double lngMax = origin.longitude > destination.longitude ? origin.longitude : destination.longitude;
//
//     return LatLngBounds(
//       southwest: LatLng(latMin, lngMin),
//       northeast: LatLng(latMax, lngMax),
//     );
//   }
//
//   // tripDetails(
//   //     RouteModel routeModel,
//   //     ) async {
//   //   markers.clear();
//   //   polylines.clear();
//   //   polylineCoordinates.clear();
//   //   mapLoader.value = true;
//   //   origin.value = LatLng(routeModel.startPoint!.latitude!, routeModel.startPoint!.longitude!);
//   //   markers.add(
//   //     Marker(
//   //       markerId: MarkerId('origin'),
//   //       position: LatLng(routeModel.startPoint!.latitude!, routeModel.startPoint!.longitude!),
//   //       infoWindow: InfoWindow(
//   //         title: 'Origin',
//   //         snippet: "start",
//   //       ),
//   //     ),
//   //   );
//   //   await _drawRoute(routeModel.startPoint!.latitude.toString(),routeModel.startPoint!.longitude.toString(),routeModel.locaList![0].latitude.toString(),routeModel.locaList![0].longitude.toString());
//   //   for(int i=0;i<routeModel.locaList!.length-1;i++){
//   //     markers.add(
//   //       Marker(
//   //         markerId: MarkerId('destination$i'),
//   //         position: LatLng(routeModel.locaList![i].latitude!, routeModel.locaList![i].longitude!),
//   //         infoWindow: InfoWindow(
//   //           title: 'Destination $i',
//   //           snippet: "end",
//   //         ),
//   //       ),
//   //     );
//   //     _drawRoute(routeModel.locaList![i].latitude.toString(),routeModel.locaList![i].longitude.toString(),routeModel.locaList![i+1].latitude.toString(),routeModel.locaList![i+1].longitude.toString());
//   //
//   //   }
//   //   markers.add(
//   //     Marker(
//   //       markerId: MarkerId('destination'),
//   //       position: LatLng(routeModel.locaList![routeModel.locaList!.length-1].latitude!, routeModel.locaList![routeModel.locaList!.length-1].longitude!),
//   //       infoWindow: InfoWindow(
//   //         title: 'Destination',
//   //         snippet: "end",
//   //       ),
//   //     ),
//   //   );
//   //   mapController.value.future.then((controller) {
//   //     controller.animateCamera(
//   //       CameraUpdate.newLatLngBounds(
//   //           _getLatLngBounds(
//   //               origin.value,
//   //               LatLng(
//   //                   routeModel.locaList![routeModel.locaList!.length - 1].latitude!,
//   //                   routeModel.locaList![routeModel.locaList!.length - 1].longitude!
//   //               )
//   //           ),
//   //           100.0
//   //       ),
//   //     );
//   //   });
//   //
//   //   mapLoader.value = false;
//   // }
//
//   assignVehicleAndDriverToRoute(String routeId, String vehicleId, String driverId) async {
//     await _routeService.assignVehicleAndDriverToRoute(routeId, vehicleId, driverId);
//   }
//
//   getAllVehicle() async {
//     driverList.value = await _driverService.getAllDriver();
//   }
//
//   @override
//   void onInit() {
//     getRoutesByVendorId();
//     super.onInit();
//     getAllVehicle();
//   }
// }