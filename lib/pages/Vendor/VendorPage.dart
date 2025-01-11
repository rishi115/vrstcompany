import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vrsstranslinkcompany/pages/Vendor/VendorController.dart';

import '../../constants/responsiveness.dart';
import '../../constants/style.dart';
import 'package:get/get.dart';

import 'CompanyCard.dart';
import 'CompanyDetails.dart';


class CompanyPage extends GetView<VendorController> {
  const CompanyPage({super.key});

  Widget titleContainerCombo(String title, String value) {

    return SizedBox(
      width: 160.w,
      height: 100.h,
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
            width: 160.w,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 13),
              child: Text(
                "Companies",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: light,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          children: [
            Expanded(
                child: Container(
                  // width: 631.w,
                  height: 900.h,
                  decoration: BoxDecoration(
                    color: light,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 400.w,
                            height: 70.h,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'search',
                                hintStyle: const TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.grey, width: 1.0), // Add light grey border
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.grey, width: 1.0), // Light grey border for enabled state
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.grey, width: 1.0), // Light grey border for focused state
                                ),
                                suffixIcon: IconButton(
                                  icon: Image.asset(
                                    'assets/SearchIcon.png',
                                    width: 27,
                                    height: 27,
                                  ),
                                  onPressed: () {
                                    // Add any functionality you want when the icon is pressed
                                  },
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(icon: Image.asset('assets/FilterImage.png',width: 33,height: 33,), onPressed: () {  },),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10.h,
                      ),

                      Divider(
                        color: lightGrey,
                      ),
                      Obx(()=>SizedBox(
                        width: 610.w,
                        height:550.h,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 8.h),
                          itemCount: controller.vendorList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var vendor = controller.vendorList[index];
                            return CompanyCard(
                                name: vendor.vendorName ?? "Company Name",
                                id: vendor.id ?? "id",
                                address: vendor.address ?? "address",
                                contact: vendor.primaryContact ?? "contact",
                                vehicles: vendor.vehicleCount.toString()
                            );
                          },
                        ),
                      ))

                    ],
                  ),
                )
            ),

            SizedBox(
              width: 20.w,
            ),

            Expanded(
                flex:  1,
                child: Container(
                  height: 600.h,
                  decoration: BoxDecoration(
                    color: light,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("Analytics"),
                      )
                    ],
                  ),
                )
            )
          ],
        )
      ],
    );
  }
}

Widget _buildInfoRow(String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Container(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),


      ),
      const Expanded(child: CompanyDetails()),

    ],
  );
}
