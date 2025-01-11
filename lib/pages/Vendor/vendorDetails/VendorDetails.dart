
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

        Container(
            child: Column(
              children: [
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

                // Container(
                //   // height: 360.h,
                //   width: double.infinity.w,
                //   padding: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     color: light,
                //     borderRadius: BorderRadius.circular(10.r),
                //   ),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           Expanded(
                //             child: CustomText(
                //               text: "Sr No.",
                //               color: lightGrey,
                //               weight: FontWeight.bold,
                //               size: 12.sp
                //             ),
                //           ),
                //
                //           Expanded(
                //             child: CustomText(
                //               text: "Date",
                //               color: lightGrey,
                //               weight: FontWeight.bold,
                //               size: 12.sp
                //             ),
                //           ),
                //
                //           Expanded(
                //             child: CustomText(
                //               text: "shift",
                //               color: lightGrey,
                //               weight: FontWeight.bold,
                //               size: 12.sp
                //             ),
                //           ),
                //
                //           Expanded(
                //             child: CustomText(
                //               text: "trip id",
                //               color: lightGrey,
                //               weight: FontWeight.bold,
                //               size: 12.sp
                //             ),
                //           ),
                //
                //           Expanded(
                //             child: CustomText(
                //               text: "company",
                //               color: lightGrey,
                //               weight: FontWeight.bold,
                //               size: 12.sp
                //             ),
                //           ),
                //
                //           Expanded(
                //             child: CustomText(
                //               text: "route id",
                //               color: lightGrey,
                //               weight: FontWeight.bold,
                //               size: 12.sp
                //             ),
                //           ),
                //
                //           Expanded(
                //             child: CustomText(
                //               text: "start time",
                //               color: lightGrey,
                //               weight: FontWeight.bold,
                //               size: 12.sp
                //             ),
                //           ),
                //
                //           Expanded(
                //             child: CustomText(
                //               text: "target time",
                //               color: lightGrey,
                //               weight: FontWeight.bold,
                //               size: 12.sp
                //             ),
                //           ),
                //
                //           Expanded(
                //             child: CustomText(
                //               text: "actual end time",
                //               color: lightGrey,
                //               weight: FontWeight.bold,
                //               size: 12.sp
                //             ),
                //           ),
                //
                //           SizedBox(width: 30.w),
                //
                //           Expanded(
                //             child: CustomText(
                //                 text: "trip delay",
                //                 color: lightGrey,
                //                 weight: FontWeight.bold,
                //                 size: 12.sp
                //               ),
                //           ),
                //         ],
                //       ),
                //
                //       SizedBox(height: 5.h,),
                //
                //       const Divider(color: lightGrey,),
                //
                //       Container(
                //         height: 600.h,
                //         decoration: BoxDecoration(
                //           color: light,
                //           borderRadius: BorderRadius.circular(10.r),
                //         ),
                //         padding: EdgeInsets.all(20),
                //         child: SingleChildScrollView(
                //           scrollDirection: Axis.vertical,
                //           child: Column(
                //             children: List.generate(10, (index) =>
                //             Container(
                //               height: 80.h,
                //               // padding: EdgeInsets.only(right: 20.w),
                //               child: Column(
                //                 children: [
                //                   Row(
                //                     children: [
                //                         CustomText(
                //                               text: "1",
                //                               color: active,
                //                               weight: FontWeight.bold,
                //                               size: 14.sp
                //                             ),
                //
                //                         SizedBox(width: 50.w),
                //
                //                         CustomText(
                //                           text: "July 22, 2023",
                //                           color: lightGrey,
                //                           weight: FontWeight.bold,
                //                           size: 12.sp
                //                         ),
                //
                //                         SizedBox(width: 45.w),
                //
                //                         Expanded(
                //                           child: CustomText(
                //                             text: "11 : 00 AM",
                //                             color: lightGrey,
                //                             weight: FontWeight.bold,
                //                             size: 12.sp
                //                           ),
                //                         ),
                //
                //                         SizedBox(width: 20.w),
                //
                //                         Expanded(
                //                           child: CustomText(
                //                             text: "12345",
                //                             color: active, // according to the status
                //                             weight: FontWeight.bold,
                //                             size: 12.sp
                //                           ),
                //                         ),
                //
                //                         Expanded(
                //                           child: CustomText(
                //                             text: "egale Itd",
                //                             color: lightGrey,
                //                             weight: FontWeight.bold,
                //                             size: 12.sp
                //                           ),
                //                         ),
                //
                //                         Expanded(
                //                           child: CustomText(
                //                             text: "12345",
                //                             color: active,
                //                             weight: FontWeight.bold,
                //                             size: 12.sp
                //                           ),
                //                         ),
                //
                //                         Expanded(
                //                           flex: 1,
                //                           child: CustomText(
                //                             text: "11 : 00 AM",
                //                             color: lightGrey,
                //                             weight: FontWeight.bold,
                //                             size: 12.sp
                //                           ),
                //                         ),
                //
                //                         Expanded(
                //                           flex: 1,
                //                           child: CustomText(
                //                             text: "11 : 00 AM",
                //                             color: lightGrey,
                //                             weight: FontWeight.bold,
                //                             size: 12.sp
                //                           ),
                //                         ),
                //
                //                         Expanded(
                //                           flex: 1,
                //                           child: CustomText(
                //                             text: "11 : 00 AM",
                //                             color: lightGrey,
                //                             weight: FontWeight.bold,
                //                             size: 12.sp
                //                           ),
                //                         ),
                //
                //                         CustomText(
                //                           text: "00 h, 00 m, 00 s",
                //                           color: lightGrey,
                //                           weight: FontWeight.bold,
                //                           size: 12.sp
                //                         ),
                //                       ],
                //                     ),
                //
                //                     const Divider(color: lightGrey,)
                //                   ],
                //               ),
                //             )
                //             ),
                //           ),
                //         ),
                //       )
                //     ],
                //   )
                // ),
              ],
            ),
          )

        ],
      )
    );
  }
}