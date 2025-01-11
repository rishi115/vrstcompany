import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vrsstranslinkcompany/constants/responsiveness.dart';

import '../constants/style.dart';
import 'custom_text.dart';

InputField({
  required String title,
  required BuildContext context,
  bool? isMobileScreen=false,
  TextEditingController? controller,
  void Function(String)? onChanged,
  bool islatlag=false,
}){
  var W = MediaQuery.of(context).size.width;
  var H = MediaQuery.of(context).size.height;
  //706
  return Container(
    height: isMobileScreen!?20:H*0.104,
    decoration: BoxDecoration(
      color: light,
      borderRadius: BorderRadius.circular(8),
    ),
    child:  Row(
      children: [
        SizedBox(
          width:  isMobileScreen?20:W*0.01,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height:  isMobileScreen?20:H*0.015,
            ),
            ResponsiveWidget.isSmallScreen(context)?
            Expanded(
              child: Container(
                width: 200,
                child: CustomText(
                  text: title,
                  size: 15,
                  color: dark,
                  weight: FontWeight.bold,
                ),
              ),
            ):CustomText(
              text: title,
              size: 15,
              color: dark,
              weight: FontWeight.bold,
            ),
            SizedBox(
              height:  isMobileScreen?7:H*0.010,
            ),

            Expanded(
              child :Container(
                height: 70,
                constraints: BoxConstraints(
                  maxWidth: islatlag?150:1000,
                ),
                decoration: BoxDecoration(
                  color: light,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: lightGrey,width: 1),
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged:onChanged ,
                    controller: controller,
                      decoration:  const InputDecoration(
                        hintStyle: TextStyle(
                          color: lightGrey,
                        ),
                        border: InputBorder.none,
                      )

                  ),
                ),
              )
            )
          ],
        ),
      ],
    ),
  );
}

DropDown({
  required String title,
  required List<String> items,
  bool? isMobileScreen = false,
  required BuildContext context, required String selectedItem,
  void Function(String?)? onChanged,
  int fontsize=15,
}){
var W = MediaQuery.of(context).size.width;
return Container(
    height: 60.h,
    decoration: BoxDecoration(
      color: light,
      borderRadius: BorderRadius.circular(8.r),
    ),
    child:  Row(
      children: [
        SizedBox(
          width: 10.w,
        ),
        Expanded(
            child :Container(
              height: 80.h,
              decoration: BoxDecoration(
                  color: light
              ),
              child:  Padding(
                padding: EdgeInsets.all(8.w),
                child: DropdownButton<String>(
                  underline: Container(),
                  value: selectedItem,
                  onChanged: onChanged,
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: dark,fontSize:ResponsiveWidget.isLargeScreen(context)?fontsize.sp:ResponsiveWidget.isSmallScreen(context)?fontsize.sp *4:fontsize.sp *1.4,
                      ),),
                    );
                  }).toList(),
                ),
              ),
            )
        ),
      ],
    ),
  );
}

DateFiller(
    {
      required String title,
      required BuildContext context,
      required String value,
      bool? isMobileScreen=false,
      TextEditingController? controller,
      required void Function() onChanged,
      int fontsize=15
    }
    ){
  return  GestureDetector(
    onTap: (){
      onChanged();
    },
    child: Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: light,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child:  Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          Container(
            height: 90.h,
            constraints: BoxConstraints(
              minWidth: 200.w,
            ),
            decoration: BoxDecoration(
              color: light,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: lightGrey,width: 1.w),
            ),
            child: Padding(
              padding:  EdgeInsets.all(8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 5.w,
                  ),
                  CustomText(
                    text :value,
                    size: ResponsiveWidget.isLargeScreen(context)?fontsize.sp:ResponsiveWidget.isSmallScreen(context)?fontsize.sp *4:fontsize.sp *1.4,
                  ),
                  const Icon(Icons.date_range),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
Field(
    BuildContext context,
    String title,
    int height,
    int width,
    String hint,
    TextEditingController controller,
    void Function(String)? onChanged,
    {int fontsize=15}
    )=> Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding:  EdgeInsets.all(8.w),
      child: CustomText(
        text: title,
        size: ResponsiveWidget.isLargeScreen(context)?fontsize.sp:ResponsiveWidget.isSmallScreen(context)?fontsize.sp *4:fontsize.sp *1.4,
        color: dark,
        weight: FontWeight.bold,
      ),
    ),
    SizedBox(
      height: 10.h,
    ),
    Container(
      height:height.h,
      width:width.w,
      child: TextField(
        style: TextStyle(color: Colors.black,
          fontSize: fontsize.sp,),
        controller:controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText:"Enter $hint",
          hintStyle: TextStyle(color: Colors.black,
            fontSize:ResponsiveWidget.isLargeScreen(context)?fontsize.sp:ResponsiveWidget.isSmallScreen(context)?fontsize.sp *4:fontsize.sp *1.4,),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
      ),
    )
  ],
);
