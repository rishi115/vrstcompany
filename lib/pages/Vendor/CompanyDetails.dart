import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/style.dart';
import '../../widgets/custom_text.dart';

class CompanyDetails extends StatelessWidget {
  const CompanyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children:
        List.generate(10, (index) => Container(
          margin:  EdgeInsets.only(bottom: 20.h),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: light,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.all(12.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text:  "Company Name",
                      size: 18,
                      weight: FontWeight.bold,
                    ),
                    Spacer(),
                    IconButton(
                      padding:  EdgeInsets.only(top: 10.w),
                      iconSize: 30, // Adjust the size of the icon
                      icon: Image.asset('assets/EditIcon.png',scale: 1.7,),
                      onPressed: () {},
                    ),
                    SizedBox(width: 20.w),
                    InkWell(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const CompanyCompleteDetails()));
                      },
                      child: Container(
                        decoration: BoxDecoration(color: active,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        height: 70.h,
                        width: 200.w,
                        child:  const CustomText(
                          text: "Login",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 20,),
                  SizedBox(
                      width: 140,
                      child: CustomText(text: "Office",)
                  ),
                  SizedBox(
                      child: CustomText(
                        text:  "Branch",
                        weight: FontWeight.w400,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 20,),
                  SizedBox(
                      width: 140,
                      child: CustomText(text: "Address",)
                  ),
                  SizedBox(
                      child: CustomText(
                        text: "Registered Address",
                        weight: FontWeight.w400,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 20,),
                  SizedBox(
                      width: 140,
                      child: CustomText(text: "Contact No.",)
                  ),
                  SizedBox(
                      child: CustomText(
                        text: "Primary Contact Number",
                        weight: FontWeight.w400,
                      ))
                ],
              ),
              const SizedBox(height: 20,)
            ],
          ),
        )),
      )

        );
      }

    }
