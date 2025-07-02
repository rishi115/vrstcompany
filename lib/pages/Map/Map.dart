import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/pages/Map/MapController.dart';
import '../../Model/TripDriverData.dart';
import '../../constants/controllers.dart';
import '../../constants/responsiveness.dart';
import '../../constants/style.dart';
import '../../widgets/custom_text.dart';

class MapsScreen extends GetView<MapController> {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void showEmployeeDialog(BuildContext context, List<Employees> employees) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Employees on Trip", style: TextStyle(fontWeight: FontWeight.bold)),
          content: SizedBox(
            width: 300,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: employees.length,
              itemBuilder: (_, index) {
                final emp = employees[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.person, size: 20, color: Colors.grey[700]),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(emp.employeeName!, style: TextStyle(fontWeight: FontWeight.w600)),
                            Text("ID: ${emp.employeeId!}", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                            Text("Status: ${emp.status}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
    Widget buildCheckboxItem(String label, bool ticked) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Checkbox(
              activeColor: active, // Your custom active color
              value: ticked,
              onChanged: (value) {
                if (value != null) {
                  controller.toggleFilter(label, value);
                }
              },
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      );
    }


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
          Expanded(child:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
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
                          child: Obx(() {
                            if (controller.initialPosition.value.latitude == 0.0 &&
                                controller.initialPosition.value.longitude == 0.0) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Stack(
                              children: [
                                GoogleMap(
                                  mapType: MapType.normal,
                                  myLocationEnabled: true,
                                  zoomGesturesEnabled: true,
                                  zoomControlsEnabled: true,
                                  markers: controller.markers.toSet(),
                                  initialCameraPosition: CameraPosition(
                                    target: controller.initialPosition.value,
                                    zoom: 10,
                                  ),
                                  onMapCreated: (GoogleMapController mapController) async {
                                    controller.googleMapController.value = mapController;
                                    await Future.delayed(Duration(milliseconds: 300));
                                    if (controller.nodalList.isNotEmpty) {
                                      final firstNode = controller.nodalList[0];
                                      if (firstNode.latitude != null && firstNode.longitude != null) {
                                        controller.moveCamera(LatLng(firstNode.latitude!, firstNode.longitude!));
                                      }
                                    }
                                  },
                                ),
                                Positioned(
                                  top: 16.h,
                                  left: 16.w,
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                    ),
                                    child:
                                    Obx(() => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildCheckboxItem("All", controller.allCheck.value),
                                        buildCheckboxItem("Drivers", controller.driverCheck.value),
                                        buildCheckboxItem("Offices", controller.officeCheck.value),
                                        buildCheckboxItem("Employees", controller.employeeCheck.value),
                                      ],
                                    ))

                                  )

                                ),
                              ],
                            );
                          })


                      )
                    ),
                ),
                Expanded(
                    flex :1,
                    child:  Container(
                      height: 710.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: Offset(0, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(18.w),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                CustomText(
                                  text: "Live Tracking",
                                  weight: FontWeight.bold,
                                  size: 17.sp,
                                ),
                                Divider(),
                                Obx(()=>
                                controller.driverList.isEmpty
                                    ? Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                      children:[
                                        SizedBox(
                                          height: 40.h,
                                        ),
                                        Image.asset("assets/Trips.png",),
                                        CustomText(
                                          text: "No Trips Available",
                                          size: 20.sp,
                                          weight: FontWeight.bold,
                                        )
                                      ]
                                  ),
                                )
                                    :
                                SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child:
                                    Column(
                                      children:List.generate(controller.driverList.length, (index) {
                                        var currentTrip = controller.driverList[index];
                                        return  Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CustomText(
                                                  text: "Trip ID : ${currentTrip.tripId?.substring(
                                                      currentTrip.tripId!.length - 6
                                                      , currentTrip.tripId?.length)}",
                                                  size: 12.sp,
                                                ),
                                                Spacer(),
                                                CustomText(
                                                  text: currentTrip.tripStatus!,
                                                  size: 12.sp,
                                                  color: active,
                                                ),
                                              ],
                                            ),
                                            CustomText(
                                              text: currentTrip.vehicleNumber ?? "Vehicle Number",
                                              size: 15.sp,
                                              weight: FontWeight.w500,
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      text: currentTrip.driverName ?? "Driver Name",
                                                      size: 12.sp,
                                                      weight: FontWeight.w500,
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          text: "Start Time  :",
                                                          size: 12.sp,
                                                          color: lightGrey,
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        CustomText(
                                                          text: currentTrip.startTime ?? "--",
                                                          size: 12.sp,
                                                          color: Colors.black,
                                                          weight: FontWeight.w500,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          text: "End Time  :",
                                                          size: 12.sp,
                                                          color: lightGrey,
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        CustomText(
                                                          text: currentTrip.endTime??"--",
                                                          size: 12.sp,
                                                          color: Colors.black,
                                                          weight: FontWeight.w500,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 40.w,
                                                        ),
                                                        // currentTrip.guard!=null
                                                        //     ?
                                                        Image.asset(
                                                          "assets/Guard.png",
                                                          scale: 1.6,
                                                        ),
                                                        //     :const SizedBox(),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Image.asset(
                                                          "assets/CallIcon.png",
                                                          scale: 2,
                                                        ),
                                                      ],

                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 40.w,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            showEmployeeDialog(context, currentTrip.employees!);
                                                          },
                                                          child: Image.asset(
                                                            "assets/profile.png", // Make sure this asset exists
                                                            scale: 4.0,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        CustomText(
                                                          text:"${currentTrip.employeesPresent}",
                                                          size: 12.sp,
                                                        )
                                                      ],
                                                    )

                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),

                                            Container(
                                              width: 230.w,
                                              height: 25.h,
                                              color: Colors.white,
                                              child: Wrap(
                                                spacing: 8, // space between items horizontally
                                                runSpacing: 8, // space between items vertically
                                                children: List.generate(controller.driverLoc[index].employees!.length, (index) {
                                                  return Column(
                                                    children: [
                                                      Image.asset(
                                                        'assets/tripgender.png', // your image URL
                                                        width: 20,
                                                        height: 20,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ],
                                                  );
                                                }),
                                              ),
                                            )
                                              ,SizedBox(
                                              height: 10.h,
                                            ),
                                            const Divider(),

                                          ],
                                        );
                                      }
                                      ),
                                    ))
                                )

                              ]
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
        ],

    )
    );
  }
}
