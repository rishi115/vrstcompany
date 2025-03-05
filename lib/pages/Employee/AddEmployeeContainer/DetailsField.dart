import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constants/style.dart';
import '../../../../constants/responsiveness.dart';
import '../../../../widgets/custom_text.dart';
import '../../../Model/EmployeeListModel.dart';
import '../../../constants/controllers.dart';
import '../../../widgets/InputField.dart';
import '../EmployeeController/EmployeeController.dart';
import 'AddEmployeeLargeScreen.dart';

class EmployeeDetailField extends GetView<EmployeeController> {
  EmployeeListModel employee;
  EmployeeDetailField({required this.employee});

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
          height: 15,
        ),
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: SizedBox(
            width: 100.w,
            height: 40.h,
            child: Center(
              child: CustomText(
                  text:"Back",
                size: 14.sp,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ResponsiveWidget.isLargeScreen(context)?Row(
          children: [
            CustomText(
                text: 'EMPLOYEE DETAIL FORM',
                color: dark,size:ResponsiveWidget.isSmallScreen(context) ?80.sp:24.sp),
            const Spacer(),
          ],
        )
            :ResponsiveWidget.isMediumScreen(context)?Row(
          children: [
            CustomText(
                text: 'EMPLOYEE DETAIL FORM',
                color: light,size:ResponsiveWidget.isSmallScreen(context) ?80.sp:24.sp),
          ],
        ):
        Column(
          children: [ CustomText(
              text: 'EMPLOYEE DETAIL FORM',
              color: light,size:ResponsiveWidget.isSmallScreen(context) ?80.sp:24.sp),
          ],
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
                      child:  Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 20.w,),
                              Field(
                                context,
                                'First Name',
                                90,
                                250,
                                'First Name',
                                TextEditingController(text: employee.firstName),
                                    (value){},
                              ),
                              SizedBox(width: 20.w,),

                              Field(
                                context,
                                'Middle Name',
                                90,
                                250,
                                'Middle Name',
                                TextEditingController(text: employee.middleName),
                                    (value) => {},
                              ),
                              SizedBox(width: 20.w,),

                              Field(
                                context,
                                'Last Name',
                                90,
                                250,
                                'Last Name',
                                TextEditingController(text: employee.lastName),
                                    (value){},
                              ),


                              SizedBox(width: 30,),
                              Container(
                                width:200.w,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      Padding(
                                        padding:  EdgeInsets.all(8.w),
                                        child: CustomText(
                                          text: 'Gender',
                                          size: 15.sp,
                                          color: dark,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                      // Obx(() =>
                                      //     DropDown(
                                      //       context: context,
                                      //       title: "Gender",
                                      //       items: gender,
                                      //       onChanged: (value) {
                                      //         employee.update((val) => val?.gender = value);
                                      //       },
                                      //       selectedItem:  employee.gender==null?
                                      //       'Male':employee.gender!,
                                      //     ),),
                                    ]
                                ),

                              ),


                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20.w,),
                              Field(
                                context,
                                'Primary Contact',
                                90,
                                250,
                                'Primary Contact',
                                TextEditingController(text: employee.contactNumber),
                                    (value) {},
                              ),

                              SizedBox(width: 20.w,),

                              Field(
                                context,
                                'Secondary Contact',
                                90,
                                250,
                                'Secondary Contact',
                                TextEditingController(text: employee.secondaryContactNumber),
                                    (value){},
                              ),
                              SizedBox(width: 20.w,),

                              Field(
                                context,
                                'Email',
                                90,
                                250,
                                'Email',
                                TextEditingController(text: employee.email),
                                    (value){},
                              ),
                              SizedBox(width: 20.w,),

                              Field(
                                context,
                                'Age',
                                90,
                                250,
                                'Age',
                                TextEditingController(text: employee.age.toString()),
                                    (value) => {},
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 20.w,),
                              Field(
                                context,
                                'Supervisor Name',
                                90,
                                250,
                                'Supervisor Name',
                                TextEditingController(text: employee.supervisorName),
                                    (value) => {},
                              ),
                              SizedBox(width: 40,),

                              // Container(
                              //   width:200.w,
                              //   child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children:[
                              //         Padding(
                              //           padding:  EdgeInsets.all(8.w),
                              //           child: CustomText(
                              //             text: 'Category',
                              //             size: 15.sp,
                              //             color: dark,
                              //             weight: FontWeight.bold,
                              //           ),
                              //         ),
                              //         Obx(() =>
                              //             DropDown(
                              //               context: context,
                              //               title: "Category",
                              //               items: categories,
                              //               onChanged: (value) {
                              //                 employee.update((val) => val!.category = [value]);
                              //               },
                              //               selectedItem: employee.category==null ? 'Driver' : employee.category![0]!,
                              //             ),),
                              //       ]
                              //   ),
                              //
                              // ),
                              SizedBox(width: 5,),
                              // Container(
                              //   width:250.w,
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Padding(
                              //         padding:  EdgeInsets.all(8.w),
                              //         child: CustomText(
                              //           text: 'Transport Inactive Date',
                              //           size: 15.sp,
                              //           color: dark,
                              //           weight: FontWeight.bold,
                              //         ),
                              //       ),
                              //       Obx(() =>  DateFiller(
                              //         title: "Transport Inactive Date",
                              //         context: context,
                              //         value: TransportInactiveday.value.isNotEmpty ? TransportInactiveday.value.toString().split(' ')[0] : 'Select', onChanged: () {
                              //         SelectDate(context, TransportInactiveday);
                              //       },
                              //       ),),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(width: 30,),

                              // Container(
                              //   width:200.w,
                              //   child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children:[
                              //         Padding(
                              //           padding:  EdgeInsets.all(8.w),
                              //           child: CustomText(
                              //             text: 'isSupervisor',
                              //             size: 15.sp,
                              //             color: dark,
                              //             weight: FontWeight.bold,
                              //           ),
                              //         ),
                              //         Obx(() =>
                              //             DropDown(
                              //               context: context,
                              //               title: "isSupervisor",
                              //               items: isSupervisorlist,
                              //               onChanged: (value) {
                              //                 if(value == 'Yes'){
                              //                   employee.isSupervisor = true;
                              //                 }else{
                              //                   employee.isSupervisor = false;
                              //                 }
                              //               },
                              //               selectedItem:  employee.isSupervisor == true ? 'Yes' : 'No',
                              //             ),),
                              //       ]
                              //   ),
                              //
                              // ),

                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 40,),
                              // Container(
                              //   width:200.w,
                              //   child: Column(
                              //       crossAxisAlignment: CrossAxisAignment.start,
                              //       children:[
                              //         Padding(
                              //           padding:  EdgeInsets.all(8.w),
                              //           child: CustomText(
                              //             text: 'Employment Type',
                              //             size: 15.sp,
                              //             color: dark,
                              //             weight: FontWeight.bold,
                              //           ),
                              //         ),
                              //         Obx(() =>
                              //             DropDown(
                              //               context: context,
                              //               title: "Employment Type",
                              //               items: employmentType,
                              //               onChanged: (value) {
                              //                 employee.update((val) => val!.employmentType = value);
                              //               },
                              //               selectedItem:  employee.employmentType==null ? 'Permanent' : employee.employmentType!,
                              //             ),),
                              //       ]
                              //   ),
                              //
                              // ),
                              Field(
                                context,
                                'Employee ID',
                                90,
                                250,
                                'Employee ID',
                                TextEditingController(text: employee.employeeId),
                                    (value){},
                              ),

                              SizedBox(width: 20.w,),
                              Field(
                                context,
                                'Secondary Id',
                                90,
                                250,
                                'Secondary Id',
                                TextEditingController(text: employee.secondaryId),
                                    (value) {},
                              ),
                              SizedBox(width: 20.w,),
                              Field(
                                context,
                                'RFID',
                                90,
                                250,
                                'RFID',
                                TextEditingController(text: employee.rfid),
                                    (value) {},
                              ),

                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              // SizedBox(width: 20.w,),
                              // Container(
                              //   width:250.w,
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Padding(
                              //         padding:  EdgeInsets.all(8.w),
                              //         child: CustomText(
                              //           text: 'Date of Birth',
                              //           size: 15.sp,
                              //           color: dark,
                              //           weight: FontWeight.bold,
                              //         ),
                              //       ),
                              //       Obx(() =>  DateFiller(
                              //         title: "Date of Birth",
                              //         context: context,
                              //         value: DateofBirth.value.isNotEmpty ? DateofBirth.value.toString().split(' ')[0] : 'Select', onChanged: () {
                              //         SelectDate(context, DateofBirth);
                              //       },
                              //       ),),
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(width: 20.w,),
                              // Container(
                              //   width: 250.w,
                              //   child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children:[
                              //         Padding(
                              //           padding:  EdgeInsets.all(8.w),
                              //           child: CustomText(
                              //             text: 'Joining Date',
                              //             size: 15.sp,
                              //             color: dark,
                              //             weight: FontWeight.bold,
                              //           ),
                              //         ),
                              //         Obx(() =>
                              //             DateFiller(
                              //               title: "Joining Date",
                              //               context: context,
                              //               value: DateofJoining.value.isNotEmpty ? DateofJoining.value.toString().split(' ')[0] : 'Select', onChanged: () {
                              //               SelectDate(context,DateofJoining);
                              //             },
                              //             ),),
                              //       ]
                              //   ),
                              // ),
                              SizedBox(width: 30,),
                              // Container(
                              //   width:200.w,
                              //   child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children:[
                              //         Padding(
                              //           padding:  EdgeInsets.all(8.w),
                              //           child: CustomText(
                              //             text: 'Languages Known',
                              //             size: 15.sp,
                              //             color: dark,
                              //             weight: FontWeight.bold,
                              //           ),
                              //         ),
                              //         Obx(() =>
                              //             DropDown(
                              //               context: context,
                              //               title: "Launguage Known",
                              //               items: languages,
                              //               onChanged: (value) {
                              //                 employee.update((val) => val!.languagesKnown = [value]);
                              //               },
                              //               selectedItem: employee.languagesKnown==null?
                              //               'English':employee.languagesKnown![0]!,
                              //             ),),
                              //       ]
                              //   ),
                              //
                              // ),
                              SizedBox(width: 20.w,),
                              Field(
                                context,
                                'Disability',
                                90,
                                250,
                                'Disability',
                                TextEditingController(text: employee.disability),
                                    (value) {},
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              SizedBox(width: 20.w,),
                              Field(
                                context,
                                'Address',
                                90,
                                250,
                                'Address',
                                TextEditingController(text: employee.address),
                                    (value) {},
                              ),

                              SizedBox(width: 20.w,),
                              Field(
                                context,
                                'City',
                                90,
                                250,
                                'City',
                                TextEditingController(text: employee.locality),
                                    (value) {},
                              ),
                              SizedBox(width: 20.w,),
                              Field(
                                context,
                                'Latitude',
                                90,
                                150,
                                'Latitude',
                                TextEditingController(text: employee.latitude.toString()),
                                    (value) {},
                              ),
                              SizedBox(width: 20.w,),
                              Field(
                                context,
                                'Longitude',
                                90,
                                150,
                                'Longitude',
                                TextEditingController(text: employee.longitude.toString()),
                                    (value) {},
                              ),
                              SizedBox(width: 20.w,),
                              Padding(
                                padding: const EdgeInsets.only(top :25.0),
                                child: InkWell(
                                  onTap: (){
                                    // gotolocation(context);
                                  },
                                  child: Container(
                                    width:200.w,
                                    decoration: BoxDecoration(color: active,
                                        borderRadius: BorderRadius.circular(10)),
                                    alignment: Alignment.center,
                                    constraints:  const BoxConstraints(
                                      maxWidth:150,
                                    ),
                                    height: 40,
                                    child:  const CustomText(
                                      text: "Map",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              SizedBox(width: 40,),
                              // Container(
                              //   width:250.w,
                              //   child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children:[
                              //         Padding(
                              //           padding:  EdgeInsets.all(8.w),
                              //           child: CustomText(
                              //             text: 'Pickup Reimbursement Zone',
                              //             size: 15.sp,
                              //             color: dark,
                              //             weight: FontWeight.bold,
                              //           ),
                              //         ),
                              //         Obx(() =>
                              //             DropDown(
                              //               context: context,
                              //               title: "Pickup Reimbursement Zone",
                              //               items: PickupList,
                              //               onChanged: (value) {
                              //                 employee.update((val) => val!.pickupReimbursementZone = [value]);
                              //               },
                              //               selectedItem: employee.pickupReimbursementZone==null ? 'Select' : employee.pickupReimbursementZone![0]!,
                              //             ),),
                              //       ]
                              //   ),
                              //
                              // ),
                              SizedBox(width: 40,),
                              // Container(
                              //   width:250.w,
                              //   child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children:[
                              //         Padding(
                              //           padding:  EdgeInsets.all(8.w),
                              //           child: CustomText(
                              //             text: 'Pickup Reimbursement Zone',
                              //             size: 15.sp,
                              //             color: dark,
                              //             weight: FontWeight.bold,
                              //           ),
                              //         ),
                              //         Obx(() =>
                              //             DropDown(
                              //               context: context,
                              //               title: "Drop Reimbursement Zone",
                              //               items: DropList,
                              //               onChanged: (value) {
                              //                 employee.update((val) => val!.dropReimbursementZone = [value]);
                              //                 String? selectedId =  DropMap[value];
                              //                 print("Selected ID: $selectedId");
                              //               },
                              //               selectedItem:   employee.dropReimbursementZone==null ? 'Select' : employee.dropReimbursementZone![0]!,
                              //             ),),
                              //       ]
                              //   ),
                              //
                              // ),
                              SizedBox(width: 40,),
                              // Container(
                              //   width:250.w,
                              //
                              //   child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children:[
                              //         Padding(
                              //           padding:  EdgeInsets.all(8.w),
                              //           child: CustomText(
                              //             text: 'Office',
                              //             size: 15.sp,
                              //             color: dark,
                              //             weight: FontWeight.bold,
                              //           ),
                              //         ),
                              //         Obx(()=>
                              //             Padding(padding: EdgeInsets.only(top: 10.h),
                              //               child: DropDown(
                              //                 fontsize: 15,
                              //                 context: context,
                              //                 title: "Select Office",
                              //                 items: officeListMap,
                              //                 onChanged: (value) {
                              //                   employee.office = officeMap[value]!;
                              //                   officeName.value = value!;
                              //                 },
                              //                 selectedItem: officeName.value==''?'Select':officeName.value,
                              //               ),
                              //             )
                              //         ),
                              //       ]
                              //   ),
                              //
                              // ),


                            ],)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
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