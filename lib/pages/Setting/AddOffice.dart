import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/pages/Setting/SettingController/SettingController.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get.dart';
import '../../constants/controllers.dart';
import '../../constants/responsiveness.dart';
import '../../constants/style.dart';
import '../../widgets/InputField.dart';
import '../../widgets/custom_text.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class AddOffice extends StatefulWidget {
  const AddOffice({super.key});

  @override
  State<AddOffice> createState() => _AddOfficeState();
}

class _AddOfficeState extends State<AddOffice> {
  final controller = Get.put(SettingController());
  void _showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text('Assign Supervisor'),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListBody(
              children: <Widget>[
                Container(
                  width: 700,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Employee name, Id',
                      hintStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: Padding(
                          padding: const EdgeInsets.only(right:18.0),
                          child: Image.asset('assets/SearchIcon.png',width: 27,height: 27,),
                        ),
                        onPressed: () {
                          // Add any functionality you want when the icon is pressed
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(),
                Row(
                  children: [
                    CustomText(
                      text: "Sr No.",
                      size: 15,
                      weight: FontWeight.w100,
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                    CustomText(
                      text: "Employee Name",
                      size: 15,
                      weight: FontWeight.w100,
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                    CustomText(
                      text: "Gender",
                      size: 15,
                      weight: FontWeight.w100,
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                    CustomText(
                      text: "Address",
                      size: 15,
                      weight: FontWeight.w100,
                    ),
                    SizedBox(
                      width: 150.w,
                    ),
                  ],
                ),
                Divider(),
                for(int i=0;i<controller.employeeListModel.length;i++)
                  Row(
                      children: [
                        SizedBox(
                          width:40.w,
                          child: Center(
                            child: CustomText(
                                text: '12',
                                size:15
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50.w,
                        ),
                        SizedBox(
                          width:100.w,
                          child: CustomText(
                              text: controller.employeeListModel[i].firstName! + controller.employeeListModel[i].lastName!,
                              size:15
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        SizedBox(
                          width:100.w,
                          child: Center(
                            child: CustomText(
                                text: controller.employeeListModel[i].gender!,
                                size:15
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        SizedBox(
                          width:180.w,
                          child: Center(
                            child: CustomText(
                                text: controller.employeeListModel[i].address!,
                                size:15
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                          width:100.w,
                          child: Center(
                            child: Image.asset('assets/Maps.png',width: 40,height: 40,),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Obx(()=>
                            InkWell(
                                onTap: (){
                                  controller.office.value.supervisorId =  controller.employeeListModel[i].id!;
                                  controller.selectedSupervisorId = true;
                                  Navigator.pop(context);
                                },
                                child: controller.office.value.supervisorId == controller.employeeListModel[i].id?
                                Image.asset('assets/Cancel.png',width: 50.w,height: 50.h,)
                                    :Image.asset('assets/Add.png',width: 50.w,height: 50.h,)),
                        )
                      ]
                  )

              ],
            ),
          ),
        );
      },
    );
  }
  Set<Marker> markers = {};
  LatLng initialPosition = LatLng(19.206924751547263, 72.97582665488119); // Example coordinates (Googleplex)
  late GoogleMapController mapController;

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
              controller.office.value.address = location;
              controller.office.value.latitude = latLng.latitude;
              controller.office.value.longitude = latLng.longitude;

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
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(largeScreen: SingleChildScrollView(
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
            ],),),
          const SizedBox(
            height: 35,
          ),
          const CustomText(
            text: 'OFFICE REGISTRATION FORM',color: dark,size: 24,),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Container(
              decoration: const BoxDecoration(
                color: light,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height:20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Field(
                              context,
                              'Office Name',
                              90,
                              300,
                              'Office Name',
                              TextEditingController(text: controller.office.value.name),
                                  (value) => controller.office..update((val) => val!.name = value),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:20.h,
                        ),
                        Row(
                          children: [
                            InkWell(
                               onTap:(){
                                 _showMyDialog(context);
                                 },
                                child: Container(
                                  height:80.h,
                                  width: 300.w,
                                  decoration: BoxDecoration(
                                    color: active,
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(color: dark),
                                  ),
                                    child:
                                     const Center(
                                      child: CustomText(
                                          text: 'Assign Supervisor',
                                      ),

                                    ),
                                )

                            ),
                            SizedBox(
                              width: 60.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height:20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Field(
                              context,
                              'Address',
                              90,
                              300,
                              'Address',
                              TextEditingController(text: controller.office.value.address),
                                  (value) => controller.office.update((val) => val!.address = value),
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            Field(
                              context,
                              'Latitude',
                              90,
                              150,
                              'Latitude',
                              TextEditingController(text:controller.office.value.latitude.toString()),
                                  (value) => controller.office.update((val) => val!.latitude =  double.parse(value)),
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            Field(
                              context,
                              'longitude',
                              90,
                              150,
                              'longitude',
                              TextEditingController(text: controller.office.value.longitude.toString()),
                                  (value) => controller.office.update((val) => val!.longitude =  double.parse(value)),
                            ),
                          ],
                        ),
                        SizedBox(
                            width: 400.w,
                            height:400.h,
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
                                mapController=controller;
                              },
                              onTap: (LatLng latLng) {
                                _onMapTapped(latLng);
                              },
                            )
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () async {
                      // if(controller.selectedSupervisorId == false){
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: CustomText(
                      //           text: 'Please select Supervisor',
                      //           color: Colors.white,
                      //         ),
                      //         backgroundColor: Colors.red,
                      //       ));
                      //   return;
                      // }
                      if(controller.office.value.name == null || controller.office.value.name == ""){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: CustomText(
                                text: 'Please enter Office Name',
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.red,
                            ));
                        return;
                      }
                      if(controller.office.value.address == null || controller.office.value.address == ""){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(

                              content: CustomText(
                                text: 'Please enter Address',
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.red,
                            ));
                        return;
                      }
                      await controller.addOffice(
                          context
                      );
                      controller.getAllOffice();
                    },
                    child: Container(
                      decoration: BoxDecoration(color: active,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      constraints:  const BoxConstraints(
                        maxWidth:430,
                      ),
                      height: 50,
                      child:  const CustomText(
                        text: "+ Register New Office",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      constraints:  const BoxConstraints(
                        maxWidth:430,
                      ),
                      height: 50,
                      child:  const CustomText(
                        text: "Cancel",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                ],
              ),

            ),
          )
        ],
      ),
    ),
    );
  }
}