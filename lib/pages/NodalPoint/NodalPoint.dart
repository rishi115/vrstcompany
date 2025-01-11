import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vrsstranslinkcompany/pages/NodalPoint/AddBulkNodal.dart';
import 'package:vrsstranslinkcompany/pages/NodalPoint/NodalPointController/NodalPointController.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../Model/NodalPointModel.dart';
import '../../constants/controllers.dart';
import '../../constants/responsiveness.dart';
import '../../constants/style.dart';
import '../../widgets/Button.dart';
import '../../widgets/custom_text.dart';
import 'AddNodalPoint.dart';

class NodalPoint extends GetView<NodalPointController> {
  const NodalPoint({super.key});

  @override
  Widget build(BuildContext context) {
    void _showMyDialog(BuildContext context,String nodalId) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text('Assign Employee'),
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
                  for(int i=0;i<controller.employeeDetails.length;i++)
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
                            text: controller.employeeDetails[i].firstName! + controller.employeeDetails[i].lastName!,
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
                              text: controller.employeeDetails[i].gender!,
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
                              text: controller.employeeDetails[i].address!,
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
                          controller.selectedEmployeeId(controller.employeeDetails[i].id!);
                        },
                          child: controller.selectedId.contains(controller.employeeDetails[i].id)?
                          Image.asset('assets/Cancel.png',width: 50.w,height: 50.h,)
                          :Image.asset('assets/Add.png',width: 50.w,height: 50.h,)),
                      )],
                  )

                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Confrim'),
                onPressed: () async {
                  await controller.assignEmployeeToNodal(nodalId);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    void _showMap(BuildContext context,double latitude,double longitude) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text('Map'),
            content: SizedBox(
              width: 0.3.sw,
              height:0.6.sh,
              child:   GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                markers: {
                  Marker(
                    markerId: MarkerId('1'),
                    position: LatLng(latitude, longitude),
                  ),},
                initialCameraPosition: CameraPosition(
                  target: LatLng(latitude, longitude),
                  zoom: 14.0, // Zoom level
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  // Perform some action
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    void _showNodalPoint(
        BuildContext context,
        List<ListOfEmployees> employeeDetails,
        String nodalId
        ){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text('Assign Employee'),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:
              ListBody(
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
                  const Divider(),
                  for(int i=0;i<employeeDetails.length;i++)
                    Row(
                      children: [
                        SizedBox(
                          width:40.w,
                          child: const Center(
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
                              text: employeeDetails[i].firstName! + employeeDetails[i].lastName!,
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
                                text: employeeDetails[i].gender!,
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
                                text: employeeDetails[i].address!,
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
                            InkWell(
                                onTap: () async {
                                 await controller.unAssignEmployee(nodalId,employeeDetails[i].id!);
                                 Navigator.of(context).pop();
                                },
                                child:Image.asset('assets/Cancel.png',width: 50.w,height: 50.h,)

                        )],
                    )

                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Confrim'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
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
                  color: light,
                )),
          ],
        ),
        ),
        Container(
          height:100.h,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20.h),
          decoration: BoxDecoration(
            color :light,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              Padding(
                padding:  EdgeInsets.all(10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Total Nodal",
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(()=>
                        Container(
                            child: CustomText(
                              text: controller.nodalList.length.toString(),
                              weight: FontWeight.bold,
                            )
                        )
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: 10.w,
              ),
              Padding(
                padding:  EdgeInsets.all(10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Unassigned Employees",
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(()=>
                        Container(
                            child: CustomText(
                              text: controller.employeeDetails.length.toString(),
                              weight: FontWeight.bold,
                            )
                        )
                    ),
                  ],
                ),
              ),

              Spacer(),
          Obx(()=>
          InkWell(
                  onTap:controller.islandLoading.value
                      ?null
                      : (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddNodalPoint()
                    ));
                  },
                  child: Button(
                      'Add Nodal Point',
                      150,
                      15,
                      60
                  ),
              ),
            
          ),
              
              SizedBox(
                width: 20.w,
              ),
              const AddNodalButton(),
              SizedBox(
                width: 20.w,
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          height:700.h,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20.h),
          decoration: BoxDecoration(
            color :light,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding:  EdgeInsets.all(15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Nodal Points",
                  weight: FontWeight.bold,
                ),
                Obx(()=>
                    CustomText(
                      text: "Total Nodal Points: ${controller.nodalList.length} ",
                      size:14,
                      weight: FontWeight.w400,
                    ),),
                SizedBox(
                  height: 15.h,
                ),
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
                      text: "Address",
                      size: 15,
                      weight: FontWeight.w100,
                    ),
                    SizedBox(
                      width: 200.w,
                    ),
                    CustomText(
                      text: "Latitude",
                      size: 15,
                      weight: FontWeight.w100,
                    ),
                    SizedBox(
                      width: 100.w,
                    ),
                    CustomText(
                      text: "Longitude",
                      size: 15,
                      weight: FontWeight.w100,
                    ),
                    SizedBox(
                      width: 100.w,
                    ),
                    CustomText(
                      text: "Employee",
                      size: 15,
                      weight: FontWeight.w100,
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child:Obx(()=>Column(
                      children: List.generate(controller.nodalList.length, (index) => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:40.w,
                                child: Center(
                                  child: CustomText(
                                      text: (index+1).toString(),
                                      size:15
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50.w,
                              ),
                              SizedBox(
                                width:200.w,
                                child: CustomText(
                                    text: controller.nodalList[index].address,
                                    size:15
                                ),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              SizedBox(
                                width:100.w,
                                child: Center(
                                  child: CustomText(
                                      text: controller.nodalList[index].latitude.toString(),
                                      size:15
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 60.w,
                              ),
                              SizedBox(
                                width:100.w,
                                child: Center(
                                  child: CustomText(
                                      text: controller.nodalList[index].longitude.toString(),
                                      size:15
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50.w,
                              ),
                              SizedBox(
                                width:100.w,
                                child: Center(
                                  child: InkWell(
                                    onTap: (){
                                      _showNodalPoint(context,controller.nodalList[index].listOfEmployees.toList(),controller.nodalList[index].id);
                                    },
                                    child: CustomText(
                                        text: controller.nodalList[index].employeeCount.toString(),
                                        size:15,
                                      color: active,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              SizedBox(
                                width:100.w,
                                child: InkWell(
                                  onTap: (){
                                    _showMap(context,controller.nodalList[index].latitude,controller.nodalList[index].longitude);
                                  },
                                  child: Center(
                                    child: Image.asset('assets/Maps.png',width: 40,height: 40,),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              InkWell(
                                onTap: (){
                                  _showMyDialog(context,controller.nodalList[index].id);
                                },
                                child: Button(
                                    'Assign Employee',
                                    150,
                                    15,
                                    50
                                ),
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              Image.asset('assets/Cancel.png',width: 50.w,height: 50.h,),
                            ],
                          ),
                          const Divider()
                        ],
                      )),
                    ))
                    ,
                  ),
                )
              ],
            ),
          ),
        ),


      ],
    ),
    );
  }
}
