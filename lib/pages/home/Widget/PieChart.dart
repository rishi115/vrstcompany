import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vrsstranslinkcompany/widgets/ShimmerEfflect.dart';
import '../../../constants/style.dart';
import 'package:get/get.dart';

import '../homecontroller/homecontroller.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<PieChartSample2> createState() => _PieChartSample2State();
}

class _PieChartSample2State extends State<PieChartSample2> {
  final controller = Get.put(HomeController());
  int touchedIndex = -1;

  /// Builds the indicators shown below the pie chart
  List<Widget> buildIndicators() {
    final distribution = controller.VendorDistribution.value.distribution ?? [];
    if (distribution.isEmpty) {
      return [Text("No data available", style: TextStyle(color: Colors.grey))];
    }

    return List<Widget>.generate(distribution.length, (index) {
      final value = distribution[index];
      return Column(
        children: [
          Indicator(
            color: _getColor(index),
            text: '${value.name} (${value.percentage}%)',
            isSquare: true,
          ),
          const SizedBox(height: 5),
        ],
      );
    });
  }

  /// Generates the sections for the PieChart
  List<PieChartSectionData> showingSections() {
    final distribution = controller.VendorDistribution.value.distribution ?? [];
    if (distribution.isEmpty) {
      return [
        PieChartSectionData(
          color: Colors.grey,
          value: 1,
          title: 'No Data',
          titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          radius: 100,
        ),
      ];
    }

    return List.generate(distribution.length, (index) {
      final value = distribution[index];
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 28.0 : 20.0;
      final radius = isTouched ? 140.0 : 120.0;

      return PieChartSectionData(
        color: _getColor(index),
        value: value.percentage?.toDouble() ?? 0.0,
        title: '${value.percentage}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      );
    });
  }

  /// Returns a color based on the index
  Color _getColor(int index) {
    const colors = [
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.green,
      Colors.orange,
      Colors.red,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => controller.vendorDistributionLoading.value
          ? Center(
        child: ShimmerList(
          width: 350.w,
          height: 500.h,
        ),
      )
          : Column(
        children: [
          Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse?.touchedSection == null) {
                        setState(() {
                          touchedIndex = -1;
                        });
                        return;
                      }
                      setState(() {
                        touchedIndex = pieTouchResponse!.touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0, // No space between sections
                  centerSpaceRadius: 0, // Full circle, no center spacing
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildIndicators(),
          ),
        ],
      ),
    );
  }
}

