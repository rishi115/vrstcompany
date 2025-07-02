import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../homecontroller/homecontroller.dart';
import '../homepage.dart';

class TripsDashboard extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 470.w,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Text(
              "Trips Overview",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Obx(() => Row(
            children: [
              TripCategoryCard(
                title: "Scheduled",
                count: controller.tripAnalytics.value.overview!.total.toString(),
                color: Colors.grey.shade100,
                textColor: Colors.black,
              ),
              SizedBox(width: 12.w),
              TripCategoryCard(
                title: "Ongoing",
                count: controller.tripAnalytics.value.overview!.ongoing.toString(),
                color: Colors.orange.shade100,
                textColor: Colors.black,
              ),
              SizedBox(width: 12.w),
              TripCategoryCard(
                title: "Completed",
                count: controller.tripAnalytics.value.overview!.completed.toString(),
                color: Colors.teal.shade100,
                textColor: Colors.black,
              ),
            ],
          )),
          SizedBox(height: 32.h),
          // Time Period Selector
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TRIPS 2024",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              Row(
                children: [
                  TimePeriodButton(
                    title: "Monthly",
                    selected: !controller.weeklySelected.value,
                    onTap: () => controller.weeklySelected.value = false,
                  ),
                  SizedBox(width: 8.w),
                  TimePeriodButton(
                    title: "Week",
                    selected: controller.weeklySelected.value,
                    onTap: () => controller.weeklySelected.value = true,
                  ),
                ],
              ),
            ],
          )),
          SizedBox(height: 20.h),
          // Chart Area
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.grey.shade50,
            ),
            child: BarChartSample1(),
          ),
        ],
      ),
    );
  }
  }
  


  class TripCategoryCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;
  final Color textColor;

  const TripCategoryCard({
    required this.title,
    required this.count,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              count,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
           SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class TimePeriodButton extends StatelessWidget {
  final String title;
  final bool selected;

  const TimePeriodButton({
    required this.title,
    required this.selected, required bool Function() onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding:  EdgeInsets.symmetric(vertical: 12.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Colors.teal : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: selected ? Colors.white : Colors.black54,
        ),
      ),
    );
  }
}
