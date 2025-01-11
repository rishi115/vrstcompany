import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/pages/NodalPoint/predictionField.dart';
import '../../constants/controllers.dart';
import '../../constants/responsiveness.dart';
import '../../constants/style.dart';
import '../../widgets/InputField.dart';
import '../../widgets/custom_text.dart';
import 'NodalPointController/NodalPointController.dart';


class AddNodalPoint extends StatefulWidget {
  const AddNodalPoint({super.key});

  @override
  State<AddNodalPoint> createState() => _AddNodalPointState();
}

class _AddNodalPointState extends State<AddNodalPoint> {
  final NodalPointController controller = Get.put(NodalPointController());
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  LatLng initialPosition = LatLng(37.4221, -122.0841); // Example coordinates (Googleplex)
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
    print("Map tapped at: ${latLng.latitude}, ${latLng.longitude}"); // Debug line
    if (latLng == null) {
      print("Received null coordinates!"); // Debug line
      return;
    }

    // Proceed with reverse geocoding and adding markers
    try {
      List<Placemark> placemarks = [];
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
      } catch (e) {
        print("Error during placemark: $e");
      }
      if (placemarks.isNotEmpty) {
        print("Placemark found: ${placemarks[0]}"); // Debug line
        Placemark place = placemarks[0];
        String address = "${place.name}, ${place.locality}, ${place.country}";
        print("Address: $address");

        setState(() {
          markers.clear();
          markers.add(Marker(
            markerId: MarkerId(latLng.toString()),
            position: latLng,
            infoWindow: InfoWindow(title: address),
          ));
        });
      } else {
        print("No address found for the tapped location.");
      }
    } catch (e) {
      print("Error during geocoding: $e");
    }
  }


  Widget build(BuildContext context) {
    controller.officeList.forEach((element) {
      officeList.add({element.name, element.id});
    });
    Map<String, String> officeMap = {
      for (var set in officeList) set.first: set.last
    };
    List<String> officeListMap = officeMap.keys.toList();
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
              Stack(
                children: [
                  SizedBox(
                    width: 700.w,
                    height:0.75.sh,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      markers: markers, // Set of markers on the map
                      initialCameraPosition: CameraPosition(
                        target: initialPosition,
                        zoom: 14.0, // Zoom level
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                      },
                      onTap: (LatLng latLng) {
                        print("Tapped on map at: ${latLng.latitude}, ${latLng.longitude}");
                        if (latLng != null) {
                          _onMapTapped(latLng);
                        } else {
                          print("Error: Tapped coordinates are null");
                        }
                      },
                    )

                  ),
                  Positioned(
                    bottom: 20,
                    child: Column(
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

                            ElevatedButton(
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
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    text: "Map",
                                    color: Colors.white,
                                  )
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 450.w,
                    decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h,),
                          CustomText(text: "Selected Nodal Point",
                            color: Colors.black,
                            size: 20.sp,),
                          SizedBox(height: 15.h,),
                          Obx(()=>
                              CustomText(text: "name: ${controller.nodalPointName}"),
                          ),
                          SizedBox(height: 10.h,),
                          Obx(()=>
                              CustomText(text: "address: ${controller.address}"),
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            children: [
                              Obx(()=>
                                  CustomText(text: "lat: ${controller.latitude}"),
                              ),
                              SizedBox(width: 20.w,),
                              Obx(()=>
                                  CustomText(text: "long: ${controller.longitude}"),
                              ),
                            ],
                          ),
                              Obx(()=>
                              Padding(padding: EdgeInsets.only(top: 10.h),
                                child: DropDown(
                                  fontsize: 15,
                                  context: context,
                                  title: "Select Office",
                                  items: officeListMap,
                                  onChanged: (value) {
                                    controller.officeId.value = officeMap[value]!;
                                    controller.officeName.value = value!;
                                  },
                                  selectedItem: controller.officeName.value==''?'Select Office':controller.officeName.value,
                                ),
                              )
                              ),
                          SizedBox(height: 10.h,),
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
              ),],),])
    );
  }
}
