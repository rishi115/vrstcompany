import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vrsstranslinkcompany/Model/EmployeeListModel.dart';
import 'package:get/get.dart';
import '../../../../constants/style.dart';
import '../../../../widgets/custom_text.dart';
import '../../AddEmployeeContainer/DetailsField.dart';
import '../../EmployeeController/EmployeeController.dart';


class EmployeeDetails extends GetView<EmployeeController> {
  const EmployeeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
    controller.loading.value
        ? const Center(child: CircularProgressIndicator(),)
        : controller.filterEmployeeList.isEmpty
        ? Center(child: Image.asset("assets/empty.png",height: 400.h,width: 400.w,))
        : CustomScrollView(
            slivers: [
                SliverPadding(
                padding: EdgeInsets.all(10.h),
                    sliver: SliverGrid(
                    gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 440.0,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      childAspectRatio: 3.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        EmployeeListModel employee = controller.filterEmployeeList[index];
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>EmployeeDetailField(
                            employee: employee,
                          ) ));
                        },
                     child: Container(
                      width: 400.w,
                      decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.only(left: 20.w),
                      child : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Id :",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: dark
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                employee.id.toString(),
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                "Name :",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: dark
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "${employee.firstName} ${employee.lastName!}",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Gender :",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: dark
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                employee.gender!,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Status :",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: dark
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                employee.status ?? "Not Assigned",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Locality :",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: dark
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                width: 200.w,
                                height: 30.h,
                                child: Text(
                                  employee.locality ?? "Not Assigned",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      )
                  ),
                );
              },
              childCount: controller.filterEmployeeList.length, // Change this according to your need
            ),
          ),
        ),
      ],
    ));

  }
}
