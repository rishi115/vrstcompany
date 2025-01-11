import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vrsstranslinkcompany/Model/OfficeModel.dart';
import 'package:vrsstranslinkcompany/pages/LoadingScreen/loadingScreen.dart';
import 'package:vrsstranslinkcompany/pages/RoasterPage/RoasterController/RoasterController.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:vrsstranslinkcompany/pages/RoasterPage/screen/RoutesPage.dart';
import '../../../constants/controllers.dart';
import '../../../constants/responsiveness.dart';
import '../../../constants/style.dart';
import '../../../widgets/Button.dart';
import '../../../widgets/InputField.dart';
import '../../../widgets/custom_text.dart';
import 'RaostersWidget.dart';

class RoasterPage extends GetView<RoasterController> {
  const RoasterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return ResponsiveWidget(largeScreen: Column(
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
          ],
        ),
        ),
        Obx(()=>Container(
          child: controller.officeLoading.value
              ? Center(child: Container(),)
              : Container(
                  height:150.h,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20.h),
                  decoration: BoxDecoration(
                    color :light,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(18.h),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: "Date*",
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          InkWell(
                            onTap: (){
                              controller.SelectDate(context,controller.selectedDate);
                            },
                        child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 200,
                            ),
                            child: Container(
                              height: 65.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              child:  Row(
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Container(
                                    height: 70.h,
                                    constraints: BoxConstraints(
                                      minWidth: 170.w,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding:  EdgeInsets.all(8.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Obx(()=> CustomText(
                                            text :controller.selectedDate.value.isNotEmpty ? controller.selectedDate.value.toString().split(' ')[0] : 'Select',
                                            size: ResponsiveWidget.isLargeScreen(context)?15.sp:ResponsiveWidget.isSmallScreen(context)?15.sp *4:15.sp *1.4,
                                          ),
                                          ),
                                          const Icon(Icons.date_range),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),

                Obx(()=>Padding(
                  padding:  EdgeInsets.all(18.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Trip Type*",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        constraints: const BoxConstraints(
                          maxWidth: 170,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        height: 50,
                        child: Padding(
                          padding: EdgeInsets.only(left:8.w),
                          child: DropdownButton<String>(
                            underline: Container(),
                            hint: const Text('Select an option'),
                            value: controller.selectedType.value,
                            items: ['Select','login', 'logout'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              controller.selectedType.value = newValue!;
                              // Filter shifts based on the selected type
                              controller.selectedShift.value = null;
                              controller.filterShiftsByType(newValue);

                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),),

                Padding(
                  padding: EdgeInsets.all(18.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(text: "Shift*"),
                      SizedBox(height: 10.h),
                      ValueListenableBuilder<List<ValueItem>>(
                        valueListenable: controller.filteredShiftOptions,
                        builder: (context, options, child) {
                          return Container(
                            constraints: const BoxConstraints(
                              minWidth: 130,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                            height: 50,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              // Nesting ValueListenableBuilder for selectedShift
                              child: ValueListenableBuilder<ValueItem?>(
                                valueListenable: controller.selectedShift,
                                builder: (context, selectedShift, child) {
                                  return DropdownButton<ValueItem>(
                                    underline: Container(),
                                    value: selectedShift,
                                    onChanged: (ValueItem? newValue) {
                                      if (newValue != null) {
                                        controller.selectedShift.value = newValue;
                                        controller.shiftId.value = newValue.value;
                                      }
                                    },
                                    items: options.map((ValueItem item) {
                                      return DropdownMenuItem<ValueItem>(
                                        value: item,
                                        child: Text(item.label),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Obx(()=>Padding(
                  padding:  EdgeInsets.all(18.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Office",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      Container(
                        constraints: const BoxConstraints(
                          maxWidth: 270,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        height: 50,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: 250.w,
                            child:DropDown(
                              fontsize: 15,
                              context: context,
                              title: "Select Office",
                              items: controller.officeListMap as List<String>,
                              onChanged: (value) {
                                controller.officeId.value = controller.map[value]!;
                                controller.officeName.value = value!;
                                OfficeModel office = controller.officeList.firstWhere((element) =>element.id==controller.officeId.value);
                                controller.officeLocation.value = LatLng(office.latitude!, office.longitude!);
                              },
                              selectedItem: controller.officeName.value==''?'Select Office':controller.officeName.value,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),),
                const Spacer(),
                Padding(
                  padding:  EdgeInsets.only(top:40.h),
                  child: IconButton(icon: Image.asset('assets/Refresh.png',width: 36,height: 36,), onPressed: () {
                    controller.getVehicle();
                  },),
                ),
                Padding(
                  padding:  EdgeInsets.only(top:40.h),
                  child: InkWell(
                    onTap: () async {
                      if(controller.selectedDate.value.isNotEmpty && controller.selectedType.value.isNotEmpty && controller.selectedShift.value!.label.isNotEmpty ) {
                       await controller.getRoaster();
                       if(controller.hasRoute.value) {
                         navigatorKey.currentState!.pushNamed('/routes');
                       }
                      }else{
                        Get.snackbar('Error', 'Please fill all the fields');}
                    },
                    child: Button(
                        'Submit',
                        130,
                        15,
                        60
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Padding(
                  padding:  EdgeInsets.only(top:40.h),
                  child: GestureDetector(
                    onTap: (){
                      controller.reset();
                    },
                    child: Button(
                        'Reset',
                        130,
                        15,
                        60
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                )
              ],
            ),
          ),
        ),
        ),

        Container(
          height:750.h,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20.h),
          decoration: BoxDecoration(
            color :light,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Navigator(
            key: navigatorKey,
            initialRoute: '/roaster',  // Set the initial route to '/roaster'
            onGenerateRoute: (settings) {
              if (settings.name == '/roaster') {
                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (context, animation, secondaryAnimation) => RoastersWidget(),
                  transitionDuration: Duration(milliseconds: 0), // Instantly shows the new page
                  reverseTransitionDuration: Duration(milliseconds: 0),
                );
              }
              if(settings.name =='/loading'){
                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (context, animation, secondaryAnimation) => LoadingScreen(),
                  transitionDuration: Duration(milliseconds: 0), // Instantly shows the new page
                  reverseTransitionDuration: Duration(milliseconds: 0),
                );
              }
              if(settings.name == '/routes'){
                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (context, animation, secondaryAnimation) => RoutesWidget(),
                  transitionDuration: Duration(milliseconds: 0), // Instantly shows the new page
                  reverseTransitionDuration: Duration(milliseconds: 0),
                );
              }
              // if(settings.name == '/viewroutes'){
              //   return PageRouteBuilder(
              //     settings: settings,
              //     pageBuilder: (context, animation, secondaryAnimation) => RoutesWidget(),
              //     transitionDuration: Duration(milliseconds: 0), // Instantly shows the new page
              //     reverseTransitionDuration: Duration(milliseconds: 0),
              //   );
              // }
              return null; // You can handle other routes here if needed
            },
          ),
        ),
      ],
    ),
    );
  }
}
