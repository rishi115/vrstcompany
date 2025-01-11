import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/pages/RoasterPage/RoasterController/RoasterController.dart';

import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';


class RoastersWidget extends GetView<RoasterController> {
  const RoastersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomText(text: "Roasters",
                size: 14,
                weight: FontWeight.w400,
                color: active,
              ),
              VerticalDivider(),
              Obx(()=>
                  InkWell(
                     onTap: controller.hasRoute.value
                      ? (){Navigator.pushNamed(context, '/routes');
                      }:null,
                    child: CustomText(
                      text: controller.hasRoute.value ? "Has Routes":"",
                      size: 14,
                      weight: FontWeight.w400,
                      color: controller.hasRoute.value
                          ? Colors.red:Colors.black,
                    ),
                  ),
              ),
              Spacer(),

            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 35.w,
              ),
              const CustomText(
                text: "Employee Id",
                size: 14,
                weight: FontWeight.bold,
              ),
              SizedBox(
                width: 80.w,
              ),
              const CustomText(
                text: "Employee Name",
                size: 14,
                weight: FontWeight.bold,
              ),
              SizedBox(
                width: 80.w,
              ),
              const CustomText(
                text: "Gender",
                size: 14,
                weight: FontWeight.bold,
              ),
              SizedBox(
                width: 100.w,
              ),
              const CustomText(
                text: "Contact",
                size: 16,
                weight: FontWeight.bold,
              ),
              SizedBox(
                width: 150.w,
              ),
              const CustomText(
                text: "Nodal Point",
                size: 16,
                weight: FontWeight.bold,
              ),
              SizedBox(
                width: 210.w,
              ),
            ],
          ),
          const Divider(),
          Obx(() => controller.loading.value
              ? const Center(child: CircularProgressIndicator(),)
              : SizedBox(
            height: 550.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(controller.Rxroasters.value.rosters?.length ?? 0, (index) {
                  var current = controller.Rxroasters.value.rosters?[index];
                  return Column(
                    children: [
                      Row(
                        children: [
                          // Checkbox(
                          //     value: controller.selectedRoaster.contains(current),
                          //     onChanged: (value){
                          //       if(value == true){
                          //         controller.selectedRoaster.add(current);
                          //       }else{
                          //         controller.selectedRoaster.remove(current);
                          //       }
                          //     }
                          // ),
                          SizedBox(
                            width: 100.w,
                            child:  Center(
                              child: CustomText(
                                text:current?.employee?.substring(
                                    current.employee!.length - 4,
                                    current.employee!.length
                                ) ?? 'Employee Id',
                                size: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          SizedBox(
                            width: 170.w,
                            child:  Center(
                              child: CustomText(
                                  text: current?.employeeName ?? 'Employee Name',
                                  size: 14
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 140.w,
                            child:  Center(
                              child: CustomText(
                                  text: current?.employeeGender ?? 'Employee Name',
                                  size: 14
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          SizedBox(
                            width: 170.w,
                            child: CustomText(
                                text: current?.employeeContactNumber ?? 'Nodal Point',
                                size: 14
                            ),
                          ),
                          SizedBox(
                            width: 220.w,
                            child:  Center(
                              child: CustomText(
                                  text: current?.nodalPointName ?? 'Address',
                                  size: 14
                              ),
                            ),
                          ),
                          Spacer(),
                          if(current?.disability == "no")
                          Image.asset("assets/DisabilityIcon.png",width: 30.w,height: 30.h,) ,
                        Tooltip(
                            message: 'Delete',
                            child: IconButton(
                                onPressed: (){
                                  controller.deleteRoaster(current!.id!);
                                  }, icon: const Icon(Icons.delete,
                              color: Colors.red,
                              size: 17,
                            )
                            ),
                          ),

                        ],
                      )
                      ,
                      const Divider(),
                    ],
                  );}
                ),
              ),
            ),
          )),
          Row(
            children: [
              Spacer(),
              Center(
                child: InkWell(
                  onTap: () async {
                    Navigator.pushNamed(context, '/loading');
                    await controller.routeNow();
                    await controller.getRoaster();

                    if (controller.hasRoute.value) {
                      Navigator.pushNamed(context, "/routes");
                    } else {
                      Get.snackbar("Error", "Issue in making routes. Please try again.");
                      Navigator.pop(context); // Close the loader only if there's an error.
                    }

                  },
                  child: Container(
                    decoration: BoxDecoration(color: active,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    constraints:  const BoxConstraints(
                      maxWidth:250,
                    ),
                    height: 50,
                    child:  const CustomText(
                      text: "Make Routes",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 20.w,
              ),
            ],
          )

        ],
      ),
    );
  }
}
