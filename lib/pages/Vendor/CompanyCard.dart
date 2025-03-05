import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/style.dart';
import 'VendorController.dart';


class CompanyCard extends GetView<VendorController> {
  final String name;
  final String id;
  final String address;
  final String contact;
  final String vehicles;

  const CompanyCard({
    Key? key,
    required this.name,
    required this.id,
    required this.address,
    required this.contact,
    required this.vehicles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2.r,
              blurRadius: 5.r,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildInfoRow("id", id),
                _buildInfoRow("address", address),
                _buildInfoRow("contact", contact),
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.navigateToDetailsPage(id, context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: active,
                  ),
                  child: Text(
                    "OPEN",
                    style: TextStyle(color: light),
                  ),
                ),
                SizedBox(height: 70.h),
                Row(
                  children: [
                    Text(
                      "vehicle",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      vehicles,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(width: 8.w),
          SizedBox(
            width: 300.w,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}