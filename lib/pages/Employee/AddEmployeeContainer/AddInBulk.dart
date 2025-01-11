import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Model/FIleDataModel.dart';
import '../../../constants/controllers.dart';
import '../../../constants/responsiveness.dart';
import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';
import 'package:get/get.dart';
import '../DropZoneWidget.dart';
import '../EmployeeController/EmployeeController.dart';
import 'dart:html' as html;

class AddEmployeeInBulk extends StatefulWidget  {
  const AddEmployeeInBulk({super.key});

  @override
  State<AddEmployeeInBulk> createState() => _AddEmployeeInBulkState();
}

class _AddEmployeeInBulkState extends State<AddEmployeeInBulk> {

  final EmployeeController employeeController = Get.put(EmployeeController());
  FileDataModel? file;

  static openNewTab({required String setUrl, required String setTitle}) {
    return html.window.open(
      setUrl,
      setTitle,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    color: light,
                  )
              ),
            ],
          ),
          ),
           SizedBox(
            height: 35.h,
          ),
          ResponsiveWidget.isLargeScreen(context)
              ? Row(
            children: [
              CustomText(
                  text: 'EMPLOYEE REGISTRATION FORM',
                  color: light,size:ResponsiveWidget.isSmallScreen(context) ?80.sp:24),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
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
                        text: "Back",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
              :Column(
            children: [
              CustomText(
                  text: 'EMPLOYEE REGISTRATION FORM',
                  color: light,size:ResponsiveWidget.isSmallScreen(context) ?80.sp:24),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
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
                        text: "Back",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
          ,
          SizedBox(
            height: 35.h,
          ),
          ResponsiveWidget.isLargeScreen(context)
         ?Center(
           child: Container(
             height:0.7.sh,
             width: 0.31.sw,
             decoration: BoxDecoration(
               color: light,
               borderRadius: BorderRadius.circular(8),
             ),
             child:Column(
               mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SizedBox(
                    height: 20.h,
                  ),
                 Text(
                    'Upload Excel File',
                    style: TextStyle(
                      color: dark,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold
                    ),
                 ),
                 SizedBox(
                    height: 20.h,
                  ),
                 Container(
                   height: 0.5.sh,
                   width: 0.25.sw,
                   child: DropZoneWidget(
                     onDroppedFile: (file) => setState(()=> this.file = file) ,
                   ),
                 ),
                  SizedBox(
                      height: 20.h,
                    ),
                 Padding(
                   padding:  EdgeInsets.only(right:20.w),
                   child: Row(
                     children: [
                       Spacer(),
                       CustomText(
                          text: 'Doesnt have the format?',
                          color:dark,
                          size: 20,
                         weight: FontWeight.bold,
                        ),
                       SizedBox(
                         width: 10.w,
                       ),
                       InkWell(
                         onTap: (){
                           openNewTab(setUrl: "https://docs.google.com/spreadsheets/d/1TfBpTE6CMdmYkSid1IlUwLqyfLuWn9g2i0n7Lquc47c/edit?gid=0#gid=0", setTitle: "new");
},
                         child: CustomText(
                           text: 'Get Here',
                           color: active,
                           size: 20,
                           weight: FontWeight.bold,
                         ),
                       ),
                     ],
                   ),
                 )
               ],
             )
           ),
         )
              :Center(
            child: Container(
                height:300.h,
                width: 1000.w,
                decoration: BoxDecoration(
                  color: light,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Upload Excel File',
                      style: TextStyle(
                          color: dark,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.all(8.h),
                          child: Center(
                            child: InkWell(
                              onTap: (){

                              },
                              child: Container(
                                decoration: BoxDecoration(color: active,
                                    borderRadius: BorderRadius.circular(10.r)),
                                alignment: Alignment.center,
                                constraints:   BoxConstraints(
                                  maxWidth:130.w,
                                ),
                                height: 50.h,
                                child:   CustomText(
                                  text: "Upload",
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: InkWell(
                              onTap: () async {



                              },
                              child: Container(
                                decoration: BoxDecoration(color: active,
                                    borderRadius: BorderRadius.circular(10.r)),
                                alignment: Alignment.center,
                                constraints:   BoxConstraints(
                                  maxWidth:130.w,
                                ),
                                height: 50.h,
                                child:  CustomText(
                                  text: "Upload",
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),
          )
    ]
    );
  }
}
