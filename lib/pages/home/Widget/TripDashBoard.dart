import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_text.dart';
import '../homecontroller/homecontroller.dart';
import '../homepage.dart';

class TripsDashboard extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 470.w,
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
        padding:  EdgeInsets.only(top:18.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
             SizedBox(height: 16.h),
            Obx(()=>
            SizedBox(
              width: 400.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Scheduled
                  TripCategoryCard(
                    title: "Scheduled",
                    count: controller.tripAnalytics.value.overview!.total.toString(),
                    color: Colors.grey.shade200,
                    textColor: Colors.black,
                  ),

                  // Ongoing
                  TripCategoryCard(
                    title: "Ongoing",
                    count: controller.tripAnalytics.value.overview!.ongoing.toString(),
                    color: Colors.orange.shade100,
                    textColor: Colors.black,
                  ),

                  // Completed
                  TripCategoryCard(
                    title: "Completed",
                    count: controller.tripAnalytics.value.overview!.completed.toString(),
                    color: Colors.teal.shade100,
                    textColor: Colors.black,
                  ),
                ],
              ),
            )),
            const SizedBox(height: 32),
            // Time Period Selection
            Obx(()=>
            SizedBox(
              width: 400.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "TRIPS  2024",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                  width: 16.w,
                  ),
                  InkWell(
                    onTap: () {
                      controller.weeklySelected.value = false;
                      },
                    child: TimePeriodButton(
                      title: "Monthly",
                      selected: !controller.weeklySelected.value,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.weeklySelected.value = true;
                    },
                    child: TimePeriodButton(
                      title: "Week",
                      selected: controller.weeklySelected.value,
                    ),
                  ),
                ],
              ),
            )),
          Obx(()=>
            Row(
              children: [
                SizedBox(
                    width:20.w
                ),
               if(controller.weeklySelected.value)
                WeeklyBarChart()
                else
                  BarChartSample1(),
              ],
            ),
          )
          ],
        ),
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
    required this.selected,
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
