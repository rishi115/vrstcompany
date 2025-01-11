import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;

  const CustomText({Key? key,required this.text, this.size, this.color, this.weight}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text(
      text ,style: TextStyle(fontSize: size ?? 16.sp, color: color ?? Colors.black, fontWeight: weight ?? FontWeight.normal),
    );
  }
}
