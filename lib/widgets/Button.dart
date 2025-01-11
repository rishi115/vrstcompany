import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constants/style.dart';
import 'custom_text.dart';


Button(
    String text,
    int maxwidth,
    int fontsize,
    int height,
    ){
  return  Padding(
    padding:  EdgeInsets.all(8.h),
    child: Center(
      child:Container(
          decoration: BoxDecoration(color: active,
              borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          constraints:   BoxConstraints(
            maxWidth:maxwidth.w,
          ),
          height: height.h,
          child:   CustomText(
            text: text,
            color: Colors.white,
            size: fontsize.sp,
          ),
        ),

    ),
  );
}
