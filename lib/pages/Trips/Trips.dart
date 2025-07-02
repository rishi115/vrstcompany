import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vrsstranslinkcompany/constants/controllers.dart';
import 'package:vrsstranslinkcompany/constants/style.dart';
import 'package:vrsstranslinkcompany/pages/Trips/DetailedTrip.dart';
import 'package:vrsstranslinkcompany/pages/Trips/TripController/TripController.dart';
import 'package:vrsstranslinkcompany/widgets/Button.dart';
import 'package:vrsstranslinkcompany/widgets/custom_text.dart';
import 'package:get/get.dart';
import '../../constants/responsiveness.dart';

class TripsScreen extends GetView<TripController> {
  TripsScreen({Key? key}) : super(key: key);
  Widget tripRow({
    required String driver,
    required String vehicleModel,
    required String startTime,
    required String endTime,
    required String profile,
    required String status,
    required String employee,
  }) {
    final bool isActive = status.toLowerCase() == 'active';
    final Color statusColor = isActive ? Colors.green : Colors.grey;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Driver Column with avatar
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue[50],
                ),
                child: Center(
                  child: Text(
                    driver.isNotEmpty ? driver[0].toUpperCase() : 'D',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: dark,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Driver',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),

          Spacer(),

          // Vehicle Info
          _infoColumn(
            title: 'Vehicle',
            value: vehicleModel,
            icon: Icons.directions_car,
          ),

          Spacer(),

          // Employee Info
          _infoColumn(
            title: 'Employee',
            value: employee,
            icon: Icons.person,
          ),

          Spacer(),

          // Time Range
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.access_time, size: 14.sp, color: Colors.grey[600]),
                  SizedBox(width: 4.w),
                  Text(
                    'Time',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                '$startTime - $endTime',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: dark,
                ),
              ),
            ],
          ),

          Spacer(),

          // Passengers
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.people_outline, size: 18.sp, color: Colors.grey[600]),
              SizedBox(height: 4.h),
              Text(
                profile,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: dark,
                ),
              ),
            ],
          ),

          Spacer(),

          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.w),
                SizedBox(
                  width: 70.w,
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoColumn({
    required String title,
    required String value,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) Icon(icon, size: 14.sp, color: Colors.grey[600]),
            if (icon != null) SizedBox(width: 4.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: dark,
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top : ResponsiveWidget.isSmallScreen(context) ? 56 : 13),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                    color: dark,
                  )
              )
            ],
          )
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            children: [
              SizedBox(
                width: 435,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Driver name',
                    hintStyle: const TextStyle(color: lightGrey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.only(right:10.0),
                        child: Image.asset('assets/SearchIcon.png',width: 27,height: 27,),
                      ),
                      onPressed: () {
                        // Add any functionality you want when the icon is pressed
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(icon: Image.asset('assets/Refresh.png',width: 36,height: 36,), onPressed: () {
                controller.getTripByCompanyId();
              },),
              Padding(
                padding:  EdgeInsets.all(18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        controller.selectDate(context);
                      },
                      child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 200,
                          ),
                          child: Container(
                            height: 65.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child:  Row(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  height: 70.h,
                                  constraints: BoxConstraints(
                                    minWidth: 170.w,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(8.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Obx(()=>
                                            CustomText(
                                              text :controller.selectedDate.value !=null ? controller.selectedDate.value.toString().split(' ')[0] : 'Select',
                                              size: ResponsiveWidget.isLargeScreen(context)?15.sp:ResponsiveWidget.isSmallScreen(context)?15.sp *4:15.sp *1.4,
                                            ),
                                        ),
                                        const Icon(Icons.date_range),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            //height: 820.h,
            decoration: BoxDecoration(
              color: light,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "All trips",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,

                          ),
                        ),

                        InkWell(
                          onTap: () {
                            controller.getTripData();
                          },
                          child: SizedBox(
                            width: 207.w,
                            height: 55.h,
                            child: Button("EXPORT AS CSV", 207, 14, 40),
                          ),
                        )
                      ],
                    ),
                  ),
                  Obx(() => controller.loading.value
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                    width: double.infinity,
                    height: 700.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 8.h),
                      itemCount: controller.tripList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () async {
                               await  controller.routeFromCompany(
                                    controller.tripList[index].providedRoute!,
                                    controller.tripList[index].office!.latitude!,
                                 controller.tripList[index].office!.longitude!,
                                );
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => detailedTrip(
                                      trip: controller.tripList[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: tripRow(
                                  driver: '${controller.tripList[index].driverName}',
                                  vehicleModel: controller.tripList[index].vehicleNumber ?? "",
                                  startTime: controller.tripList[index].approxStartTime ?? "",
                                  endTime: controller.tripList[index].approxEndTime ?? "",
                                  profile: controller.tripList[index].listOfEmployees!.length.toString(),
                                  status: controller.tripList[index].status ?? "",
                                  employee: controller.tripList[index].listOfEmployees!.isNotEmpty
                                      ? controller.tripList[index].listOfEmployees!.first.employeeName ?? ""
                                      : "No Employee",
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  )

                ]
            ),
          ),

        ],
      ),
    );
  }
}