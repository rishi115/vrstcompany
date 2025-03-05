
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/pages/Trips/TripController/TripController.dart';

import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';
import '../../Model/TripData.dart';

class detailedTrip extends GetView<TripController> {
  final TripByDate trip;
  detailedTrip({required this.trip});

  @override
  Widget build(BuildContext context) {

    Widget detailtitle(
        String firsttitle,
        String secondtitle,
        ) {
      return Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            flex: 2,
            child: Text(
              firsttitle,
              textAlign: TextAlign.start, // Centering the text within the half
              style: TextStyle(
                fontSize: 14.sp,
                color: dark,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              secondtitle,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      );


    }

    Widget detailtitle2(
        String firsttitle,
        String secondtitle,
        ) {
      return Row(
        children: [
          SizedBox(
            width: 30.w,
          ),
          Expanded(
            flex: 1,
            child: Text(
              '$firsttitle',
              textAlign: TextAlign.start, // Centering the text within the half
              style: TextStyle(
                fontSize: 12.sp,
                color: dark,
              ),
            ),
          ),

          SizedBox(
            width: 10.w,
          ),

          Expanded(
            flex: 2,
            child: Text(
              '$secondtitle',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      );


    }

    Widget titleContainerCombo(String title, String value, double width) {
      return Container(
        width: width,
        height: 90.h,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                    title,
                    style: TextStyle(
                      color: lightGrey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    )
                )
              ],
            ),

            SizedBox(
              height: 5.h,
            ),

            Container(
              width: width,
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: light,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12.sp,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
    var current = trip;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Trip Details",
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: dark,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),

            Row(
              children: [
                titleContainerCombo("Trip Id", current.id ?? "--", 230.w),
                SizedBox(
                  width: 20.w,
                ),
                titleContainerCombo(
                    "Date",
                    current.date != null
                        ? current.date.toString().split('T')[0]
                        : "--",
                    200.w
                ),
                titleContainerCombo("Shift", current.shift?.loginTime ?? "--", 120.w),
                titleContainerCombo("Trip Type", current.tripType ?? "--", 150.w),
                Column(
                  children: [
                    SizedBox(
                      height: 26.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 100.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: light,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            "BACK",
                            style: TextStyle(
                                color: active,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),

            SizedBox(
              height: 20.h,
            ),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: 340.w,
                    height: 220.h,
                    decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        detailtitle("Driver Name", current.driverName ?? "--"),
                        SizedBox(height: 10.h),
                        detailtitle("Contact", current.driver?.contactNumber.toString() ?? "--"),
                        SizedBox(height: 10.h),
                        detailtitle("Gender", current.driver!.gender ?? "--"),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 20.w),

                Expanded(
                  child: Container(
                    width: 340.w,
                    height: 220.h,
                    decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        detailtitle("Vehicle No.", current.vehicleNumber ?? "--"),
                        SizedBox(height: 10.h),
                        detailtitle("Vehicle Model", current.vehicle?.vehicleModel.toString() ?? "--"),
                        SizedBox(height: 10.h),
                        detailtitle("Vehicle Type", current.vehicle?.vehicleType ?? "--"),
                        SizedBox(height: 10.h),
                        detailtitle("Capacity", current.listOfEmployees!.length.toString() ?? "--"),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20.w),

                Expanded(
                  child: Container(
                    width: 340.w,
                    height: 230.h,
                    decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        detailtitle("Start Time", current.approxStartTime ?? "--"),
                        SizedBox(height: 10.h),
                        detailtitle("End Time", current.approxEndTime ?? "--"),
                        SizedBox(height: 10.h),


                      ],
                    ),
                  ),
                ),SizedBox(width: 20.w),

                Expanded(
                  child: Container(
                    width: 340.w,
                    height: 220.h,
                    decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        detailtitle("Guard", current.guard ?? "--"),
                        SizedBox(height: 10.h),
                        detailtitle("Trip Type", current.tripType ?? "--"),
                        SizedBox(height: 10.h),
                        detailtitle("Trip Status", current.status ?? "--"),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20.h,
            ),


            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "EMPLOYEE DETAILS",
                          style: TextStyle(
                            color: lightGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          )
                      ),

                      Container(
                        width: 120.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: active,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                              "EXPORT",
                              style: TextStyle(
                                color: light,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              )
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 10.h,
                  ),

                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height:  0.5.sh,
                    decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataTextStyle: TextStyle(
                          color: dark,
                          fontSize: 13.sp,
                        ),
                        headingTextStyle: TextStyle(
                          color: dark,
                          fontSize: 13.sp,
                        ),
                        columns: const [
                          DataColumn(label: Text("Name"),),
                          DataColumn(label: Text("Nodal Point")),
                          DataColumn(label: Text("Attendance")),
                          DataColumn(label: Text("Pick Up Time")),
                        ],
                        rows: trip.listOfEmployees!.map<DataRow>((employee) {
                          return DataRow(cells: [
                            DataCell(Row(
                              children: [
                                Text(employee.employeeName ?? "--"),
                              ],
                            )),
                            DataCell(Text(employee.nodalName ?? "--")),
                            DataCell(
                              Text(
                                employee.status ?? "--" ,
                                style: TextStyle(
                                  color: employee.status == "present"
                                      ? Colors.teal
                                      : Colors.red,
                                ),
                              ),
                            ),
                            DataCell(Text(employee.pickupTime ?? "--")),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height:  0.5.sh,
                    decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child:Obx(()=>
                    GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        if (!this.controller.mapController.value.isCompleted) {
                          this.controller.mapController.value.complete(controller);
                        }
                      },
                      markers: Set<Marker>.of(controller.Dialogmarkers),
                      polylines: Set<Polyline>.of(controller.locationPolylines),
                      initialCameraPosition: CameraPosition(
                        target: LatLng( trip.listOfEmployees![0].nodalLat ?? 0, trip.listOfEmployees![0].nodalLng ?? 0),
                        zoom: 14.0, // Zoom level
                      ),
                    ),
                    )
                ),
                ),
              ],
            ),

          ],
        )
    );
  }
}