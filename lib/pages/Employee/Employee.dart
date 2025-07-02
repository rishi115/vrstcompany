import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vrsstranslinkcompany/pages/Employee/EmployeeController/EmployeeController.dart';
import 'package:get/get.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../constants/responsiveness.dart';
import '../../widgets/InputField.dart';
import '../../widgets/custom_text.dart';
import 'Widget/EmployeeDetails/EmployeeDetailesPage.dart';

class EmployeePage extends GetView<EmployeeController> {
  const EmployeePage({super.key});

  @override
  Widget build(BuildContext context) {

    return ResponsiveWidget(largeScreen: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
              () => Row(
                children: [
                Container(
                  margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 13),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                    color: dark,
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        Row(
          children: [
            SizedBox(
              width: 630,
              height: 50,
              child: TextField(
                onChanged: (value){
                  controller.listFilter(value);
                },
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
            const SizedBox(
              width: 20,
            ),

            IconButton(icon: Image.asset('assets/FilterImage.png',width: 36,height: 36,), onPressed: () {  },),
            const SizedBox(
              width: 10,
            ),
            IconButton(icon: Image.asset('assets/Refresh.png',width: 36,height: 36,), onPressed: () {
              controller.getAllEmployee();
            },),

            const SizedBox(
              width: 20,
            ),
            Expanded(
              child:Obx(()=>
              InkWell(
                onTap: controller.loading.value ? null :
                    (){
                  controller.addemployee(context);
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

          ],
        ),
        const SizedBox(
          height: 20,
        ),
        // Row(
        //   children:[
        //     Obx(()=>Padding(
        //       padding:  EdgeInsets.all(18.h),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           const CustomText(
        //             text: "Office",
        //           ),
        //           SizedBox(
        //             height: 10.h,
        //           ),
        //
        //           Container(
        //             constraints: const BoxConstraints(
        //               maxWidth: 270,
        //             ),
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(15.r),
        //               border: Border.all(
        //                 color: Colors.grey.withOpacity(0.5),
        //               ),
        //             ),
        //             height: 50,
        //             child: SingleChildScrollView(
        //               scrollDirection: Axis.horizontal,
        //               child: SizedBox(
        //                 width: 250.w,
        //                 child:DropDown(
        //                   fontsize: 15,
        //                   context: context,
        //                   title: "Select Office",
        //                   items: controller.statusFilterList as List<String>,
        //                   onChanged: (value) {
        //                   },
        //                   selectedItem: controller.selectedStatus.value==''?'Select Office':controller.selectedStatus.value,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),),
        //   ]
        // ),
        SizedBox(
          height: 20.h,
        ),
        const Expanded(child: EmployeeDetails()),

      ],
    ),
    smallScreen: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
              () => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 13),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                    color: dark,
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        InkWell(
          onTap: (){
            controller.addemployee(context);
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
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 300,
              height: 50,
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
            IconButton(icon: Image.asset('assets/Refresh.png',width: 36,height: 36,), onPressed: () {  },),
            IconButton(icon: Image.asset('assets/FilterImage.png',width: 36,height: 36,), onPressed: () {  },),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Expanded(child: EmployeeDetails()),

      ],
    ),
    );
  }
}