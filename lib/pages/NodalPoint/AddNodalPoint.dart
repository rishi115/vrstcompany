import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/pages/NodalPoint/predictionField.dart';
import '../../constants/controllers.dart';
import '../../constants/responsiveness.dart';
import '../../constants/style.dart';
import '../../widgets/InputField.dart';
import '../../widgets/custom_text.dart';
import 'NodalPointController/NodalPointController.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddNodalPoint extends StatefulWidget {
  const AddNodalPoint({super.key});

  @override
  State<AddNodalPoint> createState() => _AddNodalPointState();
}

class _AddNodalPointState extends State<AddNodalPoint> {
  final NodalPointController controller = Get.put(NodalPointController());
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  LatLng initialPosition = LatLng(18.51940782270114, 73.86571398197692); // Example coordinates (Googleplex)
  List<Set<String>> officeList = [{'Select Office', '8768'}];
  void _addMarker(LatLng position) {
    markers.add(
      Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(
          title: 'Your Location',
          snippet: 'This is your current location',
        ),
        icon: BitmapDescriptor.defaultMarker, // Default red marker icon
      ),
    );
    initialPosition = position;
    setState(() {}); // Update the UI with the new marker
  }
  void _onMapTapped(LatLng latLng) async {
    print("Map tapped at: ${latLng.latitude}, ${latLng.longitude}");

    try {
      var request = http.Request('GET', Uri.parse('https://vr-safetrips.onrender.com/api/direction/geocode?latitude=${latLng.latitude}&longitude=${latLng.longitude}'));
      request.headers.addAll({
        'Content-Type': 'application/json',
      });

      http.StreamedResponse response = await request.send();
        print(response.statusCode);

        if (response.statusCode == 200) {
        String address = await response.stream.bytesToString();
        print("Response: $address");

        if (address.isNotEmpty) {
          Map<String, dynamic> jsonResponse = jsonDecode(address);

          if (jsonResponse["success"] == true && jsonResponse["data"] != null) {
            List<dynamic> data = jsonResponse["data"];

            if (data.isNotEmpty) {
              String location = data[0]["formatted_address"]; // Access formatted_address
              print("Location: $location");
              controller.address.value = location;
              controller.latitude.value = latLng.latitude.toString();
              controller.longitude.value = latLng.longitude.toString();

              setState(() {
                markers.clear();
                markers.add(Marker(
                  markerId: MarkerId(latLng.toString()),
                  position: latLng,
                  infoWindow: InfoWindow(title: location), // Show address on marker
                ));
              });
            } else {
              print("No data found");
            }
          } else {
            print("API Success false or Empty Data");
          }
        } else {
          print("Empty Address Response");
        }
      } else {
        print("Failed with status: ${response.statusCode}");
      }

    } catch (e) {
      print("Geocoding Error: $e");
    }
  }
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          text: "$label : ",
          color: Colors.grey[800]!,
          weight: FontWeight.w500,
          size: 16.sp,
        ),
        Flexible(
          child: CustomText(
            text: value,
            color: Colors.black,
            size: 16.sp,
          ),
        ),
      ],
    );
  }
  Widget build(BuildContext context) {
    controller.officeList.forEach((element) {
      officeList.add({element.name, element.id});
    });
    Map<String, String> officeMap = {
      for (var set in officeList) set.first: set.last
    };
    List<String> officeListMap = officeMap.keys.toList();
    return ResponsiveWidget(
          largeScreen: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
              const SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  CustomText(
                      text: 'Add Nodal Point',
                      color: dark,size:ResponsiveWidget.isSmallScreen(context) ?80.sp:20.sp),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: InkWell(
                        onTap: (){
                         Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(color: active,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          constraints:  const BoxConstraints(
                            maxWidth:130,
                          ),
                          height: 40,
                          child:  const CustomText(
                            text: "Back",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      SizedBox(
                        width: 600.w,
                        height:0.75.sh,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          markers: markers, // Set of markers on the map
                          initialCameraPosition: CameraPosition(
                            target: initialPosition,
                            zoom: 12.0, // Zoom level
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            mapController = controller;
                          },
                          onTap: (LatLng latLng) {
                            _onMapTapped(latLng);
                          },
                        )
                      ),
                      Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(width: 20.w,),
                              Field(
                                context,
                                'Nodal Point Name',
                                90,
                                250,
                                'Nodal Point Name',
                                TextEditingController(text: controller.nodalPointName.value),
                                    (value) => controller.nodalPointName.value = value,
                              ),

                              SizedBox(width: 20.w,),
                              SizedBox(
                                width: 250.w,
                                child: AddressField(
                                  controller: TextEditingController(text: controller.address.value),
                                  onChanged: (value) {
                                    print("Address changed: $value");
                                    controller.address.value = value;
                                  },
                                ),
                              ),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Field(
                                context,
                                'Latitude',
                                90,
                                150,
                                'Latitude',
                                TextEditingController(text: controller.latitude.value),
                                    (value) => controller.latitude.value = value,
                              ),
                              SizedBox(width: 30.w,),
                              Field(
                                context,
                                'Longitude',
                                90,
                                150,
                                'Longitude',
                                TextEditingController(text: controller.longitude.value),
                                    (value) => controller.longitude.value = value,

                              ),
                              SizedBox(width: 30.w,),

                              Padding(
                                padding:  EdgeInsets.only(top:50.h),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await controller.getLatLngFromAddress(controller.address.value);
                                    _addMarker(LatLng(double.parse(controller.latitude.value), double.parse(controller.longitude.value)));
                                    mapController.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: LatLng(double.parse(controller.latitude.value), double.parse(controller.longitude.value)),
                                          zoom: 14.0,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(active),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomText(
                                        text: "Add Markers",
                                        color: Colors.white,
                                      )
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 500.w,
                        decoration: BoxDecoration(
                          color: light,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Selected Nodal Point",
                                color: Colors.black,
                                size: 22.sp,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(height: 18.h),

                              Obx(() => _buildDetailRow("Name", controller.nodalPointName.value)),
                              SizedBox(height: 8.h),

                              Obx(() => _buildDetailRow("Address", controller.address.value)),
                              SizedBox(height: 8.h),

                              Row(
                                children: [
                                  Obx(() => _buildDetailRow("Lat", controller.latitude.value)),
                                  SizedBox(width: 20.w),
                                  Obx(() => _buildDetailRow("Long", controller.longitude.value)),
                                ],
                              ),

                              SizedBox(height: 18.h),
                              Obx(() => DropDown(
                                fontsize: 15,
                                context: context,
                                title: "Select Office",
                                items: officeListMap,
                                onChanged: (value) {
                                  controller.officeId.value = officeMap[value]!;
                                  controller.officeName.value = value!;
                                },
                                selectedItem: controller.officeName.value.isEmpty ? 'Select Office' : controller.officeName.value,
                              )),

                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: InkWell(
                                  onTap: ()  {
                                    controller.createNodal();
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(color: active,
                                        borderRadius: BorderRadius.circular(10)),
                                    alignment: Alignment.center,
                                    constraints:  const BoxConstraints(
                                      maxWidth:130,
                                    ),
                                    height: 35,
                                    child:  const CustomText(
                                      text: "Confirm",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),

                    ],
                  ),
                ],
              )
            ]
        ),
    )
    );
  }
}
