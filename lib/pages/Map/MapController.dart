import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/Model/NodalPointModel.dart';
import 'package:vrsstranslinkcompany/Model/RouteListModel.dart';
import 'package:vrsstranslinkcompany/Services/NodalService.dart';


class MapController extends GetxController {
  final NodalService nodalService = NodalService();
  var nodalList = <NodalPointModel>[].obs;
  var markers = <Marker>[].obs;
  var nodalLatLng = {}.obs;
  var initialPosition = const LatLng(6.5244, 3.3792).obs;
  var googleMapController = Rxn<GoogleMapController>();
  getNodes() async {
    nodalList.value = await nodalService.getAllNodalPoint();
    for (var element in nodalList) {
      nodalLatLng[element.nodalPointName] = LatLng(element.latitude!, element.longitude!);
      markers.add(
        Marker(
          markerId: MarkerId(element.nodalPointName!),
          position: LatLng(element.latitude!, element.longitude!),
          infoWindow: InfoWindow(title: element.nodalPointName!),
        ),
      );
    }
    moveCamera(LatLng(nodalList[0].latitude!, nodalList[0].longitude!));
  }
  void moveCamera(LatLng target) {
    googleMapController.value?.animateCamera(
      CameraUpdate.newLatLng(target),
    );
  }

  @override
  void onInit() {
    getNodes();
    super.onInit();
  }
}