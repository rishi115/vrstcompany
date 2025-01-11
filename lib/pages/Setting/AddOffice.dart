import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vrsstranslinkcompany/pages/Setting/SettingController/SettingController.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get.dart';
import '../../constants/controllers.dart';
import '../../constants/responsiveness.dart';
import '../../constants/style.dart';
import '../../widgets/InputField.dart';
import '../../widgets/custom_text.dart';

class AddOffice extends GetView<SettingController> {
  const AddOffice({super.key});

  @override
  Widget build(BuildContext context) {
    void _showMyDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text('Assign Supervisor'),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListBody(
                children: <Widget>[
                  Container(
                    width: 700,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Employee name, Id',
                        hintStyle: const TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Padding(
                            padding: const EdgeInsets.only(right:18.0),
                            child: Image.asset('assets/SearchIcon.png',width: 27,height: 27,),
                          ),
                          onPressed: () {
                            // Add any functionality you want when the icon is pressed
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(),
                  Row(
                    children: [
                      CustomText(
                        text: "Sr No.",
                        size: 15,
                        weight: FontWeight.w100,
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      CustomText(
                        text: "Employee Name",
                        size: 15,
                        weight: FontWeight.w100,
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      CustomText(
                        text: "Gender",
                        size: 15,
                        weight: FontWeight.w100,
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      CustomText(
                        text: "Address",
                        size: 15,
                        weight: FontWeight.w100,
                      ),
                      SizedBox(
                        width: 150.w,
                      ),
                    ],
                  ),
                  Divider(),
                  for(int i=0;i<controller.employeeListModel.length;i++)
                    Row(
                      children: [
                        SizedBox(
                          width:40.w,
                          child: Center(
                            child: CustomText(
                                text: '12',
                                size:15
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50.w,
                        ),
                        SizedBox(
                          width:100.w,
                          child: CustomText(
                              text: controller.employeeListModel[i].firstName! + controller.employeeListModel[i].lastName!,
                              size:15
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        SizedBox(
                          width:100.w,
                          child: Center(
                            child: CustomText(
                                text: controller.employeeListModel[i].gender!,
                                size:15
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        SizedBox(
                          width:180.w,
                          child: Center(
                            child: CustomText(
                                text: controller.employeeListModel[i].address!,
                                size:15
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                          width:100.w,
                          child: Center(
                            child: Image.asset('assets/Maps.png',width: 40,height: 40,),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Obx(()=>
                            InkWell(
                                onTap: (){
                                  controller.office.value.supervisorId =  controller.employeeListModel[i].id!;
                                  controller.selectedSupervisorId = true;
                                  Navigator.pop(context);
                                },
                                child: controller.office.value.supervisorId == controller.employeeListModel[i].id?
                                Image.asset('assets/Cancel.png',width: 50.w,height: 50.h,)
                                    :Image.asset('assets/Add.png',width: 50.w,height: 50.h,)),
                        )
          ]
                    )

                ],
              ),
            ),
          );
        },
      );
    }
    return ResponsiveWidget(largeScreen: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
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
                  )),
            ],),),
          const SizedBox(
            height: 35,
          ),
          const CustomText(
            text: 'OFFICE REGISTRATION FORM',color: dark,size: 24,),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Container(
              decoration: const BoxDecoration(
                color: light,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height:20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Field(
                              context,
                              'Office Name',
                              90,
                              300,
                              'Office Name',
                              TextEditingController(text: controller.office.value.name),
                                  (value) => controller.office..update((val) => val!.name = value),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:20.h,
                        ),
                        Row(
                          children: [
                            InkWell(
                               onTap:(){
                                 _showMyDialog(context);
                                 },
                                child: Container(
                                  height:80.h,
                                  width: 300.w,
                                  decoration: BoxDecoration(
                                    color: active,
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(color: dark),
                                  ),
                                    child: Center(
                                      child: CustomText(
                                          text: 'Assign Supervisor',
                                      ),
                                    )
                                )

                            ),
                            SizedBox(
                              width: 60.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height:20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Field(
                              context,
                              'Address',
                              90,
                              300,
                              'Address',
                              TextEditingController(text: controller.office.value.address),
                                  (value) => controller.office.update((val) => val!.address = value),
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            Field(
                              context,
                              'Latitude',
                              90,
                              150,
                              'Latitude',
                              TextEditingController(text:controller.office.value.latitude.toString()),
                                  (value) => controller.office.update((val) => val!.latitude =  double.parse(value)),
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            Field(
                              context,
                              'longitude',
                              90,
                              150,
                              'longitude',
                              TextEditingController(text: controller.office.value.longitude.toString()),
                                  (value) => controller.office.update((val) => val!.longitude =  double.parse(value)),
                            ),
                          ],
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top :25.0),
                            child: InkWell(
                              onTap: (){
                                // controller.gotolocation(context);
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () async {
                      await controller.addOffice();
                      controller.getAllOffice();
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
                        text: "+ Register New Office",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
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
                  const SizedBox(
                    height: 20,
                  ),

                ],
              ),

            ),
          )
        ],
      ),
    ),
    );
  }
}