import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  final width;
  final height;
  ShimmerList({this.width, this.height});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: SizedBox(
          height: height,
          width: width,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
          )
        )
      );
  }
}


class FullScreenLoaderExample extends StatefulWidget {
  @override
  _FullScreenLoaderExampleState createState() => _FullScreenLoaderExampleState();
}

class _FullScreenLoaderExampleState extends State<FullScreenLoaderExample> {
  bool isLoading = false;

  void startCalculation() async {
    setState(() {
      isLoading = true; // Show loader
    });

    // Simulate a calculation
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      isLoading = false; // Hide loader
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Full Screen Loader")),
      body: Stack(
        children: [
          // Main content
          Center(
            child: ElevatedButton(
              onPressed: startCalculation,
              child: Text("Start Calculation"),
            ),
          ),

          // Full-screen loader
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
