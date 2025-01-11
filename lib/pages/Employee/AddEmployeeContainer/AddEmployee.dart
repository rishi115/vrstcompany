import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constants/controllers.dart';
import '../../../../constants/style.dart';
import '../../../../constants/responsiveness.dart';
import '../../../../widgets/custom_text.dart';
import '../EmployeeController/EmployeeController.dart';
import 'AddEmployeeLargeScreen.dart';


class AddEmployeePage extends GetView<EmployeeController> {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
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
                )
            ),
          ],
        ),
        ),
        const SizedBox(
          height: 35,
        ),
        ResponsiveWidget.isLargeScreen(context)?Row(
          children: [
            CustomText(
                text: 'EMPLOYEE REGISTRATION FORM',
                color: dark,size:ResponsiveWidget.isSmallScreen(context) ?80.sp:24.sp),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: InkWell(
                  onTap: (){
                     controller.addEmployeeInbulk(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(color: active,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    constraints:  const BoxConstraints(
                      maxWidth:130,
                    ),
                    height: 50,
                    child:  const CustomText(
                      text: "Add In Excel",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
            :ResponsiveWidget.isMediumScreen(context)?Row(
          children: [
            CustomText(
                text: 'EMPLOYEE REGISTRATION FORM',
                color: light,size:ResponsiveWidget.isSmallScreen(context) ?80.sp:24.sp),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: InkWell(
                  onTap: (){
                    controller.addEmployeeInbulk(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(color: active,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    constraints:  const BoxConstraints(
                      maxWidth:130,
                    ),
                    height: 50,
                    child:  const CustomText(
                      text: "Add In Excel",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ):
            Column(
              children: [ CustomText(
                  text: 'EMPLOYEE REGISTRATION FORM',
                  color: light,size:ResponsiveWidget.isSmallScreen(context) ?80.sp:24.sp),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        controller.addEmployeeInbulk(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(color: active,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        constraints:  const BoxConstraints(
                          maxWidth:130,
                        ),
                        height: 50,
                        child:  const CustomText(
                          text: "Add In Excel",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),],
            )
        ,
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding:  EdgeInsets.all(28.w),
              child: Container(
                decoration: const BoxDecoration(
                  color: light,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(18.h),
                      child: AddEmployeeLarge(),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: InkWell(
                          onTap: (){
                            controller.registerEmployee();
                          },
                          child: Container(
                            decoration: BoxDecoration(color: active,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            constraints:  const BoxConstraints(
                              maxWidth:430,
                            ),
                            height: 50,
                            child:  const CustomText(
                              text: "+ Register New Employee",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            constraints:  const BoxConstraints(
                              maxWidth:430,
                            ),
                            height: 50,
                            child:  const CustomText(
                              text: "Cancel",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),

              ),
            ),
          ),
        )

      ],
    );
  }
}
