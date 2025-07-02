import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/Model/NodalPointModel.dart';
import 'package:vrsstranslinkcompany/Services/NodalService.dart';
import 'dart:ui' as ui;
import '../../Model/DriverLocTripModel.dart';
import '../../Model/TripDriverData.dart';
import '../../Services/WebSocket.dart';
import 'package:flutter/material.dart';

class MapController extends GetxController {
  final NodalService nodalService = NodalService();
  var nodalList = <NodalPointModel>[].obs;
  var markers = <Marker>[].obs;
  var nodalLatLng = {}.obs;
  var initialPosition = const LatLng( 18.516803449568513, 73.95360460523864).obs;
  var googleMapController = Rxn<GoogleMapController>();
  final SocketService socketService = SocketService(
    "67c6c4be60b6c70c7ea5aba0",
  );
  var driverList = <Drivers>[].obs; // 👈 Reactive list to hold driver data
  var driverLoc = <Trips>[].obs; // 👈 Reactive list to hold driver location data
  var allCheck = true.obs;
  var driverCheck = true.obs;
  var officeCheck = true.obs;
  var employeeCheck = true.obs;



  toggleFilter(
      String filterType, bool value) {
      switch (filterType) {
        case 'All':
          allCheck.value = value;
          break;
        case 'Drivers':
          driverCheck.value = value;
          break;
        case 'Offices':
          officeCheck.value = value;
          break;
        case 'Employees':
          employeeCheck.value = value;
          // If you want to handle employeeCheck, you can add logic here
          if (value) {
            _addEmployeeMarkers();
          } else {
            _removeEmployeeMarkers();
          }
          break;
        default:
          print('Unknown filter type: $filterType');
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
  void _removeEmployeeMarkers() {
    markers.removeWhere((marker) => marker.markerId.value.startsWith("employee_"));
    markers.refresh();
  }
  Future<void> _addEmployeeMarkers() async {
    for (var element in nodalList) {
      if (element.latitude != null && element.longitude != null && element.nodalPointName != null) {
        LatLng position = LatLng(element.latitude!, element.longitude!);

        // Add to the latlng map
        nodalLatLng[element.nodalPointName!] = position;
        Uint8List markerIcon;
        markerIcon = await getBytesFromAsset('assets/home.png', 30);
        // Add marker
        markers.add(
          Marker(
            markerId: MarkerId("employee_${element.nodalPointName!}"),
            position: position,
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(title: element.nodalPointName),
          ),
        );
      }
    }
  }

  Future<void> getNodes() async {
    try {
      // Fetch nodal points
      nodalList.value = await nodalService.getAllNodalPoint();

      // Clear existing markers and latlng data
      markers.clear();
      nodalLatLng.clear();

      // Loop through nodal points
      for (var element in nodalList) {
        if (element.latitude != null && element.longitude != null && element.nodalPointName != null) {
          LatLng position = LatLng(element.latitude!, element.longitude!);

          // Add to the latlng map
          nodalLatLng[element.nodalPointName!] = position;
          Uint8List markerIcon;
          markerIcon = await getBytesFromAsset('assets/home.png', 30);
          // Add marker
          markers.add(
            Marker(
              markerId: MarkerId("employee_${element.nodalPointName!}"),
              position: position,
              icon: BitmapDescriptor.fromBytes(markerIcon),
              infoWindow: InfoWindow(title: element.nodalPointName),
            ),
          );
        }
      }

      // Refresh markers if it's an RxSet or RxList
      markers.refresh();

      // Move camera to the first node if available
      if (nodalList.isNotEmpty &&
          nodalList[0].latitude != null &&
          nodalList[0].longitude != null) {
        Future.delayed(Duration(milliseconds: 300), () {
          moveCamera(initialPosition.value);
        });
      }
    } catch (e) {
      print("Error fetching nodes: $e");
    }
  }

  void moveCamera(LatLng target) {
    if (googleMapController.value != null) {
      googleMapController.value!.animateCamera(
        CameraUpdate.newLatLng(target),
      );
    } else {
      print("GoogleMapController is null");
    }
  }

  initService(){
    socketService.init();
  }
  void listenToSocket() {
    socketService.driverStream.listen((drivers) {
      driverList.value = drivers;
      print("🎯 Received driver list with ${drivers.length} entries");
    });
    socketService.driverDataStream.listen((data) {
      driverLoc.value = data;
      print("🎯 Received driver location data with ${data.length} entries");
      addDriverMarkers(data);

    });
  }
  addDriverMarkers(List<Trips> driverList) async {
    Uint8List markerIcon = await getBytesFromAsset('assets/vehicleIcon.png', 30);
    for (var trip in driverList) {
      if (trip.driver?.location?.latitude != null && trip.driver!.location!.longitude != null) {
        LatLng newPosition =  LatLng(
          trip.driver!.location!.latitude!,
          trip.driver!.location!.longitude!,
        );

        // Check if marker already exists at the same position
        final existingMarker = markers.firstWhereOrNull(
              (marker) => marker.markerId.value == trip.driver?.id,
        );

        if (existingMarker != null && existingMarker.position == newPosition) {
          continue; // No change, skip updating
        }

        markers.removeWhere((marker) => marker.markerId.value == trip.driver?.id);

        markers.add(
          Marker(
            markerId: MarkerId(trip.driver!.id!),
            position: newPosition,
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(title: trip.driver!.id),
          ),
        );
      }
    }
    markers.refresh();
  }

  @override
  void onInit() {
    getNodes();
    listenToSocket();
    initService();
    super.onInit();
  }
}