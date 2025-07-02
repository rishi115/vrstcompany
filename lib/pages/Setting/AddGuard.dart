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
import '../NodalPoint/predictionField.dart';

class AddGuard extends GetView<SettingController> {
  const AddGuard({super.key});

  @override
  Widget build(BuildContext context) {
    List officesList = [{'Select','87687'}];
    List agencyList = [{'Select','87687'}];
    List<String> gender = ['male', 'female', 'other'];
    for (var element in controller.officesList) {
      officesList.add({element.name, element.id});
    }
    for (var element in controller.agencyList) {
      agencyList.add({element.name, element.id});
    }
    Map<String, String> officeMap = {
      for (var set in officesList) set.first: set.last
    };
    Map<String, String> agencyMap = {
      for (var set in agencyList) set.first: set.last
    };
    List<String> officeListMap = officeMap.keys.toList();
    List<String> agencyListMap = agencyMap.keys.toList();
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
            text: 'GUARD REGISTRATION FORM',color: dark,size: 24,),
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
                              'First Name',
                              90,
                              300,
                              'First Name',
                              TextEditingController(text: controller.guard.value.firstName),
                                  (value) => controller.guard..update((val) => val!.firstName = value),
                            ),
                            Field(
                              context,
                              'Middle Name',
                              90,
                              300,
                              'Middle Name',
                              TextEditingController(text: controller.guard.value.middleName),
                                  (value) => controller.guard..update((val) => val!.middleName = value),
                            ),
                            Field(
                              context,
                              'Last Name',
                              90,
                              300,
                              'Last Name',
                              TextEditingController(text: controller.guard.value.lastName),
                                  (value) => controller.guard..update((val) => val!.lastName = value),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                    Obx(() =>
                                        DropDown(
                                          context: context,
                                          title: "Gender",
                                          items: gender,
                                          onChanged: (value) {
                                            controller.guard.update((val) => val?.gender = value);
                                          },
                                          selectedItem:  controller.guard.value.gender==null?
                                          'male':controller.guard.value.gender!,
                                        ),),
                                  ]
                              ),

                            ),
                            Field(
                              context,
                              'Age',
                              90,
                              300,
                              'Age',
                              TextEditingController(text: controller.guard.value.age),
                                  (value) => controller.guard..update((val) => val!.age = value),
                            ),
                            Field(
                              context,
                              'Contact No.',
                              90,
                              300,
                              'Contact No.',
                              TextEditingController(text: controller.guard.value.contactNumber),
                                  (value) => controller.guard..update((val) => val!.contactNumber = value),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width:200.w,

                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Padding(
                                      padding:  EdgeInsets.all(8.w),
                                      child: CustomText(
                                        text: 'Select Office',
                                        size: 15.sp,
                                        color: dark,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                    Obx(()=>
                                        Padding(padding: EdgeInsets.only(top: 10.h),
                                          child: DropDown(
                                            fontsize: 15,
                                            context: context,
                                            title: "Select Office",
                                            items: officeListMap,
                                            onChanged: (value) {
                                              controller.guard.value.office = officeMap[value]!;
                                              controller.offices.value = value!;
                                            },
                                            selectedItem: controller.offices.value==''?'Select':controller.offices.value,
                                          ),
                                          ),
                                        )
                                  ]
                              ),

                            ),
                            SizedBox(
                              width:200.w,

                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Padding(
                                      padding:  EdgeInsets.all(8.w),
                                      child: CustomText(
                                        text: 'Select Agency',
                                        size: 15.sp,
                                        color: dark,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                    Obx(()=>
                                        Padding(padding: EdgeInsets.only(top: 10.h),
                                          child: DropDown(
                                            fontsize: 15,
                                            context: context,
                                            title: "Select Agency",
                                            items: agencyListMap,
                                            onChanged: (value) {
                                              controller.guard.value.agency = agencyMap[value]!;
                                              controller.agencyId.value = value!;
                                            },
                                            selectedItem: controller.agencyId.value==''?'Select':controller.agencyId.value,
                                          ),
                                        ),
                                    )
                                  ]
                              ),

                            ),
                            Field(
                              context,
                              'UID',
                              90,
                              300,
                              'UID',
                              TextEditingController(text: controller.guard.value.uid),
                                  (value) => controller.guard..update((val) => val!.uid = value),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 250.w,
                              child: AddressField(
                                controller: TextEditingController(text: controller.guard.value.address),
                                onChanged: (value) {
                                  controller.guard.value.address = value;
                                },
                              ),
                            ),

                            Field(
                              context,
                              'City',
                              90,
                              300,
                              'City',
                              TextEditingController(text: controller.guard.value.locality),
                                  (value) => controller.guard.update((val) => val!.locality = value),
                            ),
                            Field(
                              context,
                              'Latitude',
                              90,
                              150,
                              'Latitude',
                              TextEditingController(text: controller.guard.value.latitude),
                                  (value) => controller.guard.update((val) => val!.latitude = value),
                            ),
                            Field(
                              context,
                              'longitude',
                              90,
                              150,
                              'longitude',
                              TextEditingController(text: controller.guard.value.longitude),
                                  (value) => controller.guard.update((val) => val!.longitude = value),
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
                        SizedBox(
                          height:20.h,
                        ),
                        Padding(
                          padding:  EdgeInsets.all(8.w),
                          child: CustomText(
                            text: 'Image',
                            size: 15.sp,
                            color: dark,
                            weight: FontWeight.bold,
                          ),
                        ),
                        Obx(()=>
                        InkWell(
                          onTap: () async {
                             controller.image.value=  await controller.chooseFileUsingFilePicker();
                          },
                          child: Row(
                            children: [
                              Container(
                                  height: 60.h,
                                  width: 300.w,
                                  decoration:BoxDecoration(
                                    color: controller.image.value==""? light:active,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(color: lightGrey,width: 1.w),
                                  ),
                                  child:Center(
                                    child:  CustomText(
                                      text :"+ Add Image",
                                      size: ResponsiveWidget.isLargeScreen(context)?15.sp:ResponsiveWidget.isSmallScreen(context)?15.sp *4:15.sp *1.4,
                                    ),
                                  )
                              ),
                            ],
                          ),
                        )),
                        SizedBox(
                          height:20.h,
                        ),
                        Padding(
                          padding:  EdgeInsets.all(8.w),
                          child: CustomText(
                            text: 'Aadhar Card',
                            size: 15.sp,
                            color: dark,
                            weight: FontWeight.bold,
                          ),
                        ),
                        Obx(()=>
                        InkWell(
                          onTap: () async {
                            controller.adharCard.value=  await controller.chooseFileUsingFilePicker();
                          },
                          child: Row(
                            children: [
                              Container(
                                  height: 60.h,
                                  width: 300.w,
                                  decoration:BoxDecoration(
                                    color: controller.adharCard.value==""? light:active,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(color: lightGrey,width: 1.w),
                                  ),
                                  child:Center(
                                    child:  CustomText(
                                      text :"+ Add Aadhar",
                                      size: ResponsiveWidget.isLargeScreen(context)?15.sp:ResponsiveWidget.isSmallScreen(context)?15.sp *4:15.sp *1.4,
                                    ),
                                  )
                              ),
                            ],
                          ),
                        )),

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: (){
                    controller.addGuard(context);
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
                        text: "+ Register New Guard",
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


void showGuardAgencyDialog(
    BuildContext context,
    SettingController controller
    ) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Guard Agency Add",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Name Field
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Name*",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12.0),
                      // Address Field
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: "Address*",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the address";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12.0),
                      Row(
                        children: [
                          // Contact Field
                          Expanded(
                            child: TextFormField(
                              controller: contactController,
                              decoration: InputDecoration(
                                labelText: "Contact*",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter the contact";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 12.0),
                          // Email Field
                          Expanded(
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Email*",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter the email";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Register Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.addAgency(
                            nameController.text,
                            addressController.text,
                            contactController.text,
                            emailController.text,
                            context,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: active,
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(8.w),
                        child: Text("REGISTER", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    // Cancel Button
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                        controller.clearGuardData();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(8.w),
                        child: Text("CANCEL"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
