import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vrsstranslinkcompany/Model/HomeModel.dart';
import 'package:vrsstranslinkcompany/constants/Color_extension.dart';
import 'package:vrsstranslinkcompany/constants/style.dart';
import 'package:vrsstranslinkcompany/constants/responsiveness.dart';
import 'package:vrsstranslinkcompany/constants/controllers.dart';
import 'package:vrsstranslinkcompany/pages/home/homecontroller/homecontroller.dart';
import 'package:vrsstranslinkcompany/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/ShimmerEfflect.dart';
import '../Setting/AddOffice.dart';
import 'Widget/DropDownShift.dart';
import 'Widget/OtaOtdwidget.dart';
import 'Widget/PieChart.dart';
import 'Widget/TripDashBoard.dart';





class BarChartSample1 extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  BarChartSample1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.tripAnalyticsLoading.value) {
        return  ShimmerList(
          width: 0.3.sw,
          height: 0.4.sh,
        );
      }

      final monthsData = controller.tripAnalytics.value.periodCounts?.months
          ?.map((month) => {
        'month': month.month ?? '',
        'count': month.count ?? 0,
      })
          .toList() ??
          [];

      if (monthsData.isEmpty) {
        return const Center(child: Text('No data available.'));
      }

      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 400.h,
          width:400,
          child: AspectRatio(
            aspectRatio: 5 / 3,
            child: BarChart(
              mainBarData(monthsData),
            ),
          ),
        ),
      );
    });
  }

  BarChartData mainBarData(List<Map<String, dynamic>> monthsData) {
    return BarChartData(
      maxY: 16,
      groupsSpace: 20,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String month = monthsData[group.x]['month'].toString().toUpperCase();
            return BarTooltipItem(
              '$month\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: rod.toY.toString(),
                  style: const TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => getTitles(value, meta, monthsData),
            reservedSize: 28,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 4,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text(
                '${value.toInt()}',
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(monthsData),
      gridData: const FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
      ),
    );
  }

  List<BarChartGroupData> showingGroups(List<Map<String, dynamic>> monthsData) {
    return List.generate(monthsData.length, (i) {
      return makeGroupData(i, monthsData[i]['count']?.toDouble() ?? 0.0);
    });
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y > 16 ? 16 : y, // Cap the bar height at 20
          color: active,
          width: 16,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 16, // Match maxY for consistency
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
      ],
    );
  }

  Widget getTitles(double value, TitleMeta meta, List<Map<String, dynamic>> monthsData) {
    const style = TextStyle(
      color: Colors.blueAccent,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    if (value.toInt() < monthsData.length) {
      text = Text(
        monthsData[value.toInt()]['month'].substring(0, 3).toUpperCase(),
        style: style,
      );
    } else {
      text = const Text('', style: style);
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
}

class WeeklyBarChart extends StatefulWidget {
  @override
  _WeeklyBarChartState createState() => _WeeklyBarChartState();
}

class _WeeklyBarChartState extends State<WeeklyBarChart> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:  EdgeInsets.all(20.h),
      child: SizedBox(
    height: 430.h,
    width: 400.w,
    child: AspectRatio(
    aspectRatio: 5/3,
        child: BarChart(
          mainBarData(),
          swapAnimationDuration: animDuration,
        ),
      ),
      )
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: ((group) {
            return Colors.grey;
          }),
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String day;
            switch (group.x) {
              case 0:
                day = 'Monday';
                break;
              case 1:
                day = 'Tuesday';
                break;
              case 2:
                day = 'Wednesday';
                break;
              case 3:
                day = 'Thursday';
                break;
              case 4:
                day = 'Friday';
                break;
              case 5:
                day = 'Saturday';
                break;
              case 6:
                day = 'Sunday';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$day\n',
              TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: rod.toY.toString(),
                  style: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 28,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 50,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text(
                '${value.toInt()}',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(
        show: true, // Keep this true if you want vertical lines
        drawHorizontalLine: true, // Disable horizontal lines
        drawVerticalLine: false, // Optional: Keep vertical lines
      ),    );
  }

  List<BarChartGroupData> showingGroups() {
    return List.generate(7, (i) {
      return makeGroupData(i, (i + 1) * 20.toDouble());
    });
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: active,
          width: 16,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 150,
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
      ],
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blueAccent,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Mon', style: style);
        break;
      case 1:
        text = Text('Tue', style: style);
        break;
      case 2:
        text = Text('Wed', style: style);
        break;
      case 3:
        text = Text('Thu', style: style);
        break;
      case 4:
        text = Text('Fri', style: style);
        break;
      case 5:
        text = Text('Sat', style: style);
        break;
      case 6:
        text = Text('Sun', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
}


class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    counts(
        String name,
        int value,
        String description,
        ){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: name,
            size: 15.sp,
            color: lightGrey,
            weight: FontWeight.bold,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: 80.w,
            height: 70.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  offset: const Offset(0, 1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding:  EdgeInsets.all(18.h),
                child: Row(
                  children: [
                    CustomText(
                      text: value.toString(),
                      size: 13.sp,
                      weight: FontWeight.bold,
                    ),
                    const Spacer(),
                    Tooltip(
                      message: description,
                      child: const Icon(
                        Icons.info,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
    if(controller.officeList.isEmpty){
      Future.delayed(Duration.zero, () {
        Get.dialog(
          Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: const EdgeInsets.all(20),
              width: 400.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.amber,
                    size: 80,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Office Not Added",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "You need to add the office first before creating a trip.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text("Cancel", style: TextStyle(color: Colors
                            .grey[600])),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 30,
                              vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Get.back();
                          // Navigate to Add Office Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddOffice(),
                            ),
                          );
                        },
                        child: const Text("Add Office", style: TextStyle(
                            color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          barrierDismissible: false,
        );
      });
    }
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            SizedBox(
              height: 35.h,
            ),
            Obx(()=>
            controller.isLoading.value
                ? Align(
              alignment: Alignment.center,
              child:  ShimmerList(
                width: 0.9.sw,
                height: 0.9.sh,
              ),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        width: 300.w,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                        child: SimpleDropdown()
                    ),
                    const Spacer(),
                    counts(
                      "Guards",
                      0,
                      "Total trips completed",
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    counts(
                      "Vehicles",
                      0,
                      "Total trips completed",
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    counts(
                      "Employees",
                      0,
                      "Total trips completed",
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            TripsDashboard(),
                            SizedBox(
                              width: 20.w,
                            ),
                            Container(
                              width: 350.w,
                              height: 710.h,
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
                                child: Column(
                                  children: [
                                    Row(
                                      children:[
                                        CustomText(
                                          text:"Vendor Distribution",
                                          size: 17.sp,
                                          weight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        CustomText(
                                          text:"Roasters",
                                          size: 12.sp,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    PieChartSample2(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        // Container(
                        //   width: 840.w,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(18.r),
                        //     color: Colors.white,
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.shade100,
                        //         offset: Offset(0, 1),
                        //         blurRadius: 4,
                        //       ),
                        //     ],
                        //   ),
                        //   child: Padding(
                        //     padding:  EdgeInsets.all(18.w),
                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           children:[
                        //             CustomText(
                        //               text:"OTA & OTD",
                        //               size: 17.sp,
                        //               weight: FontWeight.bold,
                        //             ),
                        //             SizedBox(
                        //               width: 10.w,
                        //             ),
                        //           ],
                        //         ),
                        //         SizedBox(
                        //           height: 20.h,
                        //         ),
                        //         MonthlyBarChart(),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    controller.tripLoading.value
                        ? Align(
                      alignment: Alignment.center,
                      child:  ShimmerList(
                        width:  710.h,
                        height: 300.w,
                      ),
                    )
                        : Container(
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
                                controller.todayTripList.isEmpty
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
                                    : SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child:
                                Column(
                                  children:List.generate(controller.todayTripList.length, (index) {
                                    var currentTrip = controller.todayTripList[index];
                                     return  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CustomText(
                                                text: "Trip ID : ${currentTrip.id?.substring(
                                                currentTrip.id.length - 6
                                                , currentTrip.id.length)}",
                                                size: 12.sp,
                                              ),
                                              Spacer(),
                                              CustomText(
                                                text: currentTrip.status,
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
                                                        text: currentTrip.approxStartTime ?? "--",
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
                                                        text: currentTrip.approxEndTime??"--",
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
                                                      currentTrip.guard!=null
                                                      ?Image.asset(
                                                        "assets/Guard.png",
                                                        scale: 1.6,
                                                      ):const SizedBox(),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Image.asset(
                                                        "assets/CallIcon.png",
                                                        scale: 1.8,
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
                                                      Image.asset("assets/profile.png",
                                                        scale: 4.0,
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      CustomText(
                                                        text:"${currentTrip.listOfEmployees.length}/${currentTrip.capacity}",
                                                        size: 12.sp,
                                                      )

                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Divider(),




                                        ],
                                      );}),
                                ))
                                )

                              ]
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ],
            )
            )
          ]
      ),
    );
  }
}
