import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../constants/controllers.dart';
import '../../../../constants/responsiveness.dart';
import '../../../../constants/style.dart';
import '../../../../widgets/custom_text.dart';
class GlobalLocation extends StatelessWidget {
  final String Latitude;
  final String Longitude;
  const GlobalLocation({Key? key, required this.Latitude, required this.Longitude}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
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
              color: light,
            )
        ),],
    ),
    ),
          Container(
            width: 500,
            height: 500,
            child:   GoogleMap(
              // padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              markers: {
                Marker(
                  markerId: MarkerId('1'),
                  position: LatLng(double.parse(Latitude), double.parse(Longitude)),
                )
              },
              initialCameraPosition:  CameraPosition(
                target: LatLng(double.parse(Latitude), double.parse(Longitude)),
                zoom: 14.4746,
              ),

              onMapCreated: (GoogleMapController controller)
              {
                },
            ),
          )
        ]
  );
  }
}
