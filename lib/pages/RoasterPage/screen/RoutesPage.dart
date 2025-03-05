import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/Model/RouteModel.dart';
import 'package:vrsstranslinkcompany/pages/RoasterPage/RoasterController/RoasterController.dart';
import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';


class RoutesWidget extends GetView<RoasterController> {
  const RoutesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/roaster');
                },
                child: CustomText(text: "Roasters",
                  size: 14,
                  weight: FontWeight.w400,
                ),
              ),
              VerticalDivider(),
              CustomText(text: "Routes",
                size: 14,
                weight: FontWeight.w400,
                color: active,
              ),
              Spacer(),
              VerticalDivider(),
              Image.asset("assets/SplitIcon.png",
                height: 40.h,
                width: 40.w,
              ),
              VerticalDivider(),
              InkWell(
                onTap: () async {
                  Navigator.pushNamed(context,'/loading');
                  await controller.getRoaster();
                  Navigator.pop(context);
                },
                child: Image.asset("assets/RefreshButton.png",fit: BoxFit.fill,
                  height: 40.h,
                  width: 90.w,
                ),
              ),
              VerticalDivider(),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 550.h,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: List.generate(controller.Rxroasters.value.routes!.length, (index) {
                    return Padding(
                      padding:  EdgeInsets.only(bottom:15.h),
                      child: Container(
                        decoration: BoxDecoration(
                          color:   controller.routes[index].visibleToVendor! ? Colors.blue[100] : Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: routeList(index),
                        ),
                      ),
                    );
                  }
                  ),
                )
            ),
          ),
          Obx(()=>
              Row(
                children: [
                  controller.modifiedRoutes.isNotEmpty
                      ? InkWell(
                    onTap: () async {
                    await controller.saveModifiedRoutes();
                    },
                    child: Container(
                      decoration: BoxDecoration(color: dark,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      constraints:  const BoxConstraints(
                        maxWidth:250,
                      ),
                      height: 40,
                      child:  const CustomText(
                        text: "Confirm Changes",
                        color: Colors.white,
                      ),
                    ),
                  )
                      : SizedBox.shrink(), // Render an empty space when the button is hidden
                  const Spacer(),
                  Center(
                    child: InkWell(
                      onTap:!controller.isApproveVendor.value ? () async {
                        if(
                        controller.ApproveVendor.length == 0
                        ){
                          Get.snackbar("Error", "Please select a route to assign vendor");
                          return;
                        }
                        Navigator.pushNamed(context, "/loading");
                        await controller.approveVendor();
                        controller.isApproveVendor.value = true;
                        controller.ApproveVendor.clear();

                        Navigator.pop(context);
                      }
                          : null,
                      child: Container(
                        decoration: BoxDecoration(color: active,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        constraints:  const BoxConstraints(
                          maxWidth:250,
                        ),
                        height: 40,
                        child:  const CustomText(
                          text: "Assign Vendor",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Center(
                    child: InkWell(
                      onTap: controller.isApproveVendor.value ?(){

                        controller.publishRoute();
                      }: null,
                      child: Container(
                        decoration: BoxDecoration(color: active,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        constraints:  const BoxConstraints(
                          maxWidth:250,
                        ),
                        height: 40,
                        child:  const CustomText(
                          text: "Confirm Route",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Center(
                    child: InkWell(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, '/roaster');
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        constraints:  const BoxConstraints(
                          maxWidth:250,
                        ),
                        height: 40,
                        child:  const CustomText(
                          text: "Cancel",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}



class routeList extends StatefulWidget {
  int Routeindex;
  routeList(this.Routeindex);

  @override
  State<routeList> createState() => _routeListState();
}

class _routeListState extends State<routeList> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RoasterController>();
    var routes = controller.routes[widget.Routeindex];
    void showMap(BuildContext context,double latitude,double longitude){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Obx(()=>
              AlertDialog(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                title: Text('Trip Route'),
                content: SizedBox(
                  width: 0.3.sw,
                  height:0.6.sh,
                  child:   GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    polylines: controller.locationPolylines.toSet(),
                    onMapCreated: (GoogleMapController Controller) {
                      controller.MapController.value.complete(Controller);
                    },
                    markers: {
                      Marker(
                        markerId: MarkerId('1'),
                        position: LatLng(latitude, longitude),
                      ),
                      ...controller.Dialogmarkers,
                    },
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
              ));
        },
      );
    }
    void addVendor(BuildContext context){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text('Assign Vendor'),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListBody(
                children: <Widget>[
                  Container(
                    width: 500.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Vendor name, Id',
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
                        text: "Vendor Id",
                        size: 15,
                        weight: FontWeight.w100,
                      ),
                      SizedBox(
                        width: 120.w,
                      ),
                      CustomText(
                        text: "Vendor Name",
                        size: 15,
                        weight: FontWeight.w100,
                      ),
                      SizedBox(
                        width: 80.w,
                      ),
                      const CustomText(
                        text: "Vehicle Assigned",
                        size: 15,
                        weight: FontWeight.w100,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                  Divider(),
                  controller.vendorList.isEmpty ? Center(child: CustomText(text: "No Employee Found",size: 15,weight: FontWeight.w100,)) :
                  Obx(()=>
                      Column(
                        children: List.generate(controller.vendorList.length, (index) =>
                            Padding(
                              padding:  EdgeInsets.all(10.w),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        title: const Text('Add New Supervisor'),
                                        content: const Text(
                                            'Are you sure you want to assign this Vendor to Route?'),
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
                                              controller.updateVendor(controller.vendorList[index].id!, controller.vendorList[index].vendorName!, routes.id!);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],


                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 50.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color : background,
                                    borderRadius: BorderRadius.circular(23.r),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:100.w,
                                        child: CustomText(
                                            text: controller.vendorList[index].id??" ".substring(controller.vendorList[index].id!.length - 8),
                                            size:15
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                      SizedBox(
                                        width:200.w,
                                        child: Center(
                                          child: CustomText(
                                              text: controller.vendorList[index].vendorName ?? "Contact",
                                              size:15
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60.w,
                                      ),
                                      SizedBox(
                                        width:50.w,
                                        child: CustomText(
                                            text: controller.vendorList[index].vehicleCount.toString() ,
                                            size:15
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      )),
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
    return Column(
      children: [
        // Dropdown button container
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: [
              Obx(()=>
                  SizedBox(
                    width: 50.w,
                    height: 50.h,
                    child: Checkbox(
                      value: controller.ApproveVendor.contains(routes.id),
                      onChanged: controller.canSelectRoute(routes.vehicleAssignedByVendor!)
                          ? (value) {
                        if (value == true) {
                          controller.ApproveVendor.add(routes.id!);
                        } else {
                          controller.ApproveVendor.remove(routes.id);
                        }
                      }
                          : null,
                      activeColor: routes.vehicleAssignedByVendor! ? Colors.blue : Colors.black,
                    ),
                  ),
              ),
              SizedBox(
                width: 120.w,
                child:  Column(
                  children: [
                    Center(
                      child: CustomText(
                        text:"RouteId",
                        size: 13,
                        color: lightGrey,
                      ),
                    ),
                    Center(
                      child: CustomText(
                        text: routes.id!.substring(routes.id!.length - 8),
                        size: 13,
                      ),
                    ),

                  ],
                ),
              ),
              InkWell(
                onTap: routes.visibleToVendor==false ?
                    () async {
                  await controller.getVendor();
                  addVendor(context);
                }
                    :null
                ,
                child: SizedBox(
                    width: 160.w,
                    child:  Column(
                      children: [
                        Center(
                          child: CustomText(
                            text:"Vendor name",
                            size: 13,
                            color: lightGrey,
                          ),
                        ),
                        Center(
                          child: CustomText(
                            text: routes.vendorName?? 'Not Assigned',
                            size: 13,
                          ),
                        ),

                      ],
                    )
                ),
              ),
              SizedBox(
                width: 140.w,
                child:  Column(
                  children: [
                    Center(
                      child: CustomText(
                        text:"Vehicle Assigned",
                        size: 13,
                        color: lightGrey,
                      ),
                    ),
                    Center(
                      child: CustomText(
                        text: routes.vehicleAssignedByVendor?? false ? routes.vehicleNumber??"" : 'Not Assigned',
                        size: 13,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                width: 100.w,
                child:  Column(
                  children: [
                    Center(
                      child: CustomText(
                        text:"Start Time",
                        size: 13,
                        color: lightGrey,
                      ),
                    ),
                    Center(
                      child: CustomText(
                        text: (routes.employeeCount == 0 || routes.employees == null || routes.employees!.isEmpty)
                            ? "-" // No employees or employee list is empty, show "-"
                            : routes.employees!.first.pickupTime ?? "-", // If first employee exists, show pickupTime, else show "-"
                        size: 13,
                      ),
                    )


                  ],
                ),
              ),
              SizedBox(
                width: 190.w,
                child:  Column(
                  children: [
                    Center(
                      child: CustomText(
                        text:"Start Point",
                        size: 13,
                        color: lightGrey,
                      ),
                    ),
                    Center(
                      child: CustomText(
                        text: routes.startPoint?? "-",
                        size: 13,
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(
                width: 70.w,
                child:  Column(
                  children: [
                    Center(
                      child: CustomText(
                        text:"Duration",
                        size: 13,
                        color: lightGrey,
                      ),
                    ),
                    Center(
                      child: CustomText(
                        text: "${(routes.estimatedDuration)} min",
                        size: 13,
                      ),
                    ),

                  ],
                ),
              ),
              VerticalDivider(),
              SizedBox(
                width: 90.w,
                child: Row(
                  children: [
                    Image.asset("assets/ProfileIcon.png",
                      height: 40.h,
                      width: 40.w,
                    ),
                    Center(
                      child: CustomText(
                        text: "${routes.employees!.length}/${routes.vehicleCapacity}",
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () async {
                  await controller.pasteEmployeeToRoute(
                      widget.Routeindex,
                      0
                  );
                  setState(() {
                  });
                },
                child: Image.asset("assets/PasteIcon.png",
                  height: 30.h,
                  width: 30.w,
                ),
              ),

              InkWell(
                onTap: (){
                  controller.routeDraw(
                      routes
                  );
                  showMap(context, routes.employees!.first.nodalLat!, routes.employees!.first.nodalLng!);
                },
                child: Image.asset("assets/Maps.png",
                  height: 45.h,
                  width: 45.w,
                ),
              ),

              VerticalDivider(),
              InkWell(
                onTap: (){
                  controller.expandedList.contains(widget.Routeindex) ? controller.expandedList.remove(widget.Routeindex) :
                  controller.expandedList.add(widget.Routeindex);
                },
                child: Image.asset("assets/DownIcon.png",
                  height: 40.h,
                  width: 40.w,
                ),
              ),
              VerticalDivider()

            ],
          ),
        ),
        Obx(()=> controller.expandedList.contains(widget.Routeindex) ?
        SizedBox(
            height: 300.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:  EdgeInsets.only(top :8.w),
                child: Column(
                  children: List.generate(routes.employees!.length, (index) {
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 18.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Checkbox(
                              //   value: controller.selectedRoute.contains(routes.id),
                              //   onChanged: (value){
                              //     if(value == true){
                              //       controller.selectedRoute.add(
                              //           routes.id!
                              //       );
                              //     }else{
                              //       controller.selectedRoaster.remove(routes.id);
                              //     }
                              //
                              //   }
                              // ),
                              SizedBox(
                                width: 100.w,
                                child:  Center(
                                  child: CustomText(
                                    // text:"${current.employee?.employeeId}"
                                    text: routes.employees![index].employeeId!.substring(routes.employees![index].employeeId!.length - 8),
                                    size: 13,
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: VerticalDivider(
                                  color: lightGrey,
                                ),
                                height: 30,
                                width: 20,
                              ),
                              SizedBox(
                                width: 170.w,
                                child:  Center(
                                  child: CustomText(
                                    // text: current.employee?.firstName ?? 'Employee Name',
                                      text: routes.employees![index].employeeName!,
                                      size: 13
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: VerticalDivider(
                                  color: lightGrey,
                                ),
                                height: 30,
                                width: 20,
                              ),
                              SizedBox(
                                width: 100.w,
                                child:  Center(
                                  child: CustomText(
                                      text: routes.employees![index].phoneNumber!,
                                      size: 13
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: VerticalDivider(
                                  color: lightGrey,
                                ),
                                height: 30,
                                width: 50,
                              ),
                              SizedBox(
                                width: 190.w,
                                child: CustomText(
                                  // text: current.employee?.contactNumber ?? 'Nodal Point',
                                    text: routes.employees![index].nodalName!,
                                    size: 14

                                ),
                              ),
                              SizedBox(
                                child: VerticalDivider(
                                  color: lightGrey,
                                ),
                                height: 30,
                              ),
                              SizedBox(
                                width: 80.w,
                                child:  Center(
                                  child: CustomText(
                                    // text: current.nodalPoint?.address ?? 'Address',
                                      text: routes.employees![index].pickupTime!,
                                      size: 13
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: VerticalDivider(
                                  color: lightGrey,
                                ),
                                height: 30,
                              ),
                              const Spacer(),

                              // Image.asset("assets/DisabilityIcon.png",width: 30.w,height: 30.h,),
                              InkWell(
                                  onTap: () async {
                                    await controller.cutEmployeeFromRoute(widget.Routeindex, index);
                                    setState(() {

                                    });
                                  },
                                  child: Image.asset("assets/CutIcon.png",width: 30.w,height: 30.h,)),
                              InkWell(
                                  onTap: () async {
                                    await controller.moveEmployeeDown(widget.Routeindex, index);
                                    setState(() {

                                    });
                                  },
                                  child: Image.asset("assets/DropDwonIcon.png",width: 30.w,height: 30.h,)
                              ),
                              InkWell(
                                  onTap: () async {
                                    await controller.moveEmployeeUp(widget.Routeindex, index);
                                    setState(() {

                                    });
                                  },
                                  child: Image.asset("assets/SwipeUpIcon.png",width: 30.w,height: 30.h,)
                              ),
                              Tooltip(
                                message: 'Delete',
                                child: IconButton(
                                    onPressed: (){
                                      controller.deleteEmployeeFromRoute(widget.Routeindex, index);
                                      setState(() {

                                      });
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
                      ),
                    );
                  }
                  ),
                ),
              ),
            )
        )
            : const SizedBox(),
        )

      ],
    );
  }
}
