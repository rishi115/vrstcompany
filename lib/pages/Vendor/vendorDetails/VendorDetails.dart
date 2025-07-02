
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';
import '../VendorController.dart';

class Vendordetails extends GetView<VendorController> {
  const Vendordetails({super.key});

  @override
  Widget build(BuildContext context) {

    Widget _buildSectionTitle(String title) {
      return Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget _buildItemRow(String label, String value) {
      return Padding(
        padding: EdgeInsets.only(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$label: ", style: TextStyle(fontWeight: FontWeight.w600)),
            Expanded(child: Text(value, softWrap: true)),
          ],
        ),
      );
    }

    Widget detailtitle(
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

    Widget rowButton(String icon, String title, Function()? onTap) {
      return Container(
        width: 100.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: active,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                width: 30.w,
                height: 30.h,
                "assets/$icon"
            ),

            // SizedBox(
            //   width: 5.w,
            // ),

            Text(
              title,
              style: TextStyle(
                  color: light,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      );
    }
    var current =  controller.vendorDetails.value;
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
                  "Vendor Details",
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: dark,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20.h,
            ),

            Row(
              children: [
                titleContainerCombo("Vendor Name", current.vendorName ?? "--", 360.w),
                SizedBox(
                  width: 20.w,
                )
                ,

                SizedBox(
                  width: 20.w,
                ),

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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: 559.w,
                    height: 290.h,
                    decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        detailtitle("Branch", current.city ?? "--"),
                        SizedBox(height: 10.h),
                        detailtitle("Pin Code", current.pincode.toString() ?? "--"),
                        SizedBox(height: 10.h),
                        detailtitle("City", current.city ?? "--"),
                        SizedBox(height: 10.h),
                        detailtitle("Address", current.address ?? "--")
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 20.w),

                Expanded(
                  child: Container(
                    width: 559.w,
                    height: 290.h,
                    decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        detailtitle("Company Size",current.vehicleCount.toString() ?? "--"),
                        SizedBox(height: 20.h),
                        detailtitle("GSTIN No.", current.gstin ?? "--"),
                        SizedBox(height: 20.h),
                        detailtitle("PAN No.", current.panCardNumber ?? "--"),
                        SizedBox(height: 20.h),
                        detailtitle("Type of Business", "Transport"),
                        SizedBox(height: 20.h),
                        detailtitle("email", current.primaryEmail ?? "--")
                      ],
                    ),
                  ),
                )
              ],
            ),

            SizedBox(
              height: 20.h,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 320.w,
                  height: 190.h,
                  decoration: BoxDecoration(
                    color: light,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      detailtitle2("Primary Contact", current.primaryName ?? "--"),
                      SizedBox(height: 10.h),
                      detailtitle2("Number", current.primaryContact ?? "--"),
                      SizedBox(height: 10.h),
                      detailtitle2("Email", current.primaryEmail ?? "--"),
                      SizedBox(height: 10.h),
                      detailtitle2("Designation", "Admin"),
                    ],
                  ),
                ),

                SizedBox(width: 20.w),

                Container(
                  width: 320.w,
                  height: 190.h,
                  decoration: BoxDecoration(
                    color: light,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      detailtitle2("Secondary Contact", current.secondaryName ?? "--"),
                      SizedBox(height: 10.h),
                      detailtitle2("Number", current.secondaryContact ?? "--"),
                      SizedBox(height: 10.h),
                      detailtitle2("Email", current.secondaryEmail ?? "--"),
                      SizedBox(height: 10.h),
                      detailtitle2("Designation", "Admin"),
                    ],
                  ),
                ),

                SizedBox(width: 20.w),

                Container(
                  width: 320.w,
                  height: 190.h,
                  decoration: BoxDecoration(
                    color: light,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        detailtitle2("Trips", current.listOfTrips?.length.toString() ?? "--"),
                        SizedBox(height: 10.h),
                        detailtitle2("Vehicle", current.vehicleCount.toString() ?? "--"),
                        SizedBox(height: 10.h),
                        detailtitle2("Drivers", current.driverCount.toString() ?? "--"),
                      ],
                    ),
                  ),
                ),

              ],
            ),

            SizedBox(
              height: 20.h,
            ),

            // Vendorsexpansionpanel(),

            SizedBox(
              height: 20.h,
            ),

            Row(
              children: [
                rowButton("Vehicle_outline.png", "Vehicles", () {}),
                SizedBox(width: 20.w),
                rowButton("Employee_outline.png", "Drivers", () {}),
                SizedBox(width: 20.w),
              ],
            ),

            SizedBox(
              height: 20.h,
            ),
            Obx(()=>
            controller.listOfVehicleAndDriver.isEmpty
                ? const SizedBox()
                : SizedBox(
              height: 650.h,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: List.generate(controller.listOfVehicleAndDriver.length, (index) {
                  var curr = controller.listOfVehicleAndDriver[index];
                  return Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Column 1 - Driver Basic Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSectionTitle("Vehicle Info"),
                                  _buildItemRow("id",curr.id ?? ""),
                                  _buildItemRow("Model",curr.vehicleModel ?? " "),
                                  _buildItemRow("Number",curr.vehicleNumber ?? " "),

                                ],
                              ),
                            ),

                            // Column 4 - Vehicle Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSectionTitle("Vehicle Details"),
                                  _buildItemRow("Type", curr.vehicleType?.toUpperCase() ?? ""),
                                  _buildItemRow("Capacity", curr.vehicleCapacity.toString() ?? " "),
                                  _buildItemRow("Driver", "${curr.driver!.firstName} ${curr.driver!.lastName} ")
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSectionTitle("Driver Info"),
                                  _buildItemRow("Name","${curr.driver!.firstName} ${curr.driver!.lastName} " ),
                                  _buildItemRow("Contact", curr.driver?.contactNumber.toString() ?? " "),
                                  _buildItemRow("Gender",curr.driver?.gender ?? " "),
                                ],
                              ),
                            ),

                            // Column 2 - Driver Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSectionTitle("Driver Details"),
                                  _buildItemRow("LicenseNo.", curr.driver?.licenseNo ?? " "),
                                  _buildItemRow("License Type", curr.driver?.licenseType ?? " "),
                                  _buildItemRow("Status", curr.driver?.status ?? ""),
                                ],
                              ),
                            ),

                            // Column 3 - Vehicle Info

                          ],
                        ),
                      )
                  );
                }
                )),
              ),
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "PAST RECOEDS",
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
        )
    );
  }
}