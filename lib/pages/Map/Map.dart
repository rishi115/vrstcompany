import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/pages/Map/MapController.dart';
import 'package:vrsstranslinkcompany/pages/NodalPoint/NodalPointController/NodalPointController.dart';
import '../../constants/controllers.dart';
import '../../constants/responsiveness.dart';
import '../../constants/style.dart';
import '../../widgets/custom_text.dart';

class MapsScreen extends GetView<MapController> {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = Set();

    return ResponsiveWidget(largeScreen: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 13),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                    color: dark,
                  )),
            ],
          ),
          ),
          Expanded(
              child: Padding(
                padding:  EdgeInsets.all(18.h),
                child: Container(
                  decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 6),
                            color: lightGrey.withOpacity(.1),
                            blurRadius: 12)
                      ]),
                  foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(color: lightGrey, width: .5)),
                  child:Obx(()=> GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    markers: controller.markers.toSet(), // Set of markers on the map
                    initialCameraPosition: CameraPosition(
                      target: controller.initialPosition.value,
                      zoom: 10,
                    ),
                    onMapCreated: (GoogleMapController Controller) {
                      controller.googleMapController.value = Controller;
                    },
                  ),
                ),
    )
              ),
          )

          ,]));
  }
}
