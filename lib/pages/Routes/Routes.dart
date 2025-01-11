// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vrsstranslinkcompany/pages/Routes/RouteController.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:multi_dropdown/multiselect_dropdown.dart';
// import '../../../../constants/controllers.dart';
// import '../../../../constants/style.dart';
// import '../../../constants/responsiveness.dart';
// import '../../../../widgets/custom_text.dart';
// import '../../widgets/Button.dart';
//
//
//
// class RoutesScreen extends GetView<RouteController> {
//   const RoutesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(RouteController());
//     void _showMyDialog(BuildContext context) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             surfaceTintColor: Colors.white,
//             title: Text('Trip Route Details'),
//             content: Container(
//               height: 0.5.sh, // Adjust the height of the map
//               width: 0.3.sw, // Adjust the width of the map
//               child: Obx(()=>controller.mapLoader.value?Center(child: CircularProgressIndicator(),)
//                 :GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: controller.origin.value,
//                   zoom: 14.0,
//                 ),
//                 polylines: controller.polylines.toSet(),
//                 markers: controller.markers.toSet(),
//                 // Inside the `onMapCreated` callback of your Google Map
//                 onMapCreated: (GoogleMapController mapController) {
//                   controller.mapController.value.complete(mapController);
//                 },
//
//               ),
//               )
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('Cancel'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   // Perform some action
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//     // void _assignVehicle(BuildContext context,
//     //     ) {
//     //   showDialog(
//     //     context: context,
//     //     builder: (BuildContext context) {
//     //       return AlertDialog(
//     //         backgroundColor: Colors.white,
//     //         surfaceTintColor: Colors.white,
//     //         title: Text('Assign Vehicle'),
//     //         content: SingleChildScrollView(
//     //           scrollDirection: Axis.vertical,
//     //           child: ListBody(
//     //             children: <Widget>[
//     //               Container(
//     //                 width: 300.w,
//     //                 height: 70.h,
//     //                 decoration: BoxDecoration(
//     //                   color: Colors.white,
//     //                   borderRadius: BorderRadius.circular(10),
//     //                   border: Border.all(color: Colors.grey.withOpacity(0.5)),
//     //                 ),
//     //                 child: TextField(
//     //                   decoration: InputDecoration(
//     //                     hintText: 'Search Vehicle name, Id',
//     //                     hintStyle: const TextStyle(color: Colors.black),
//     //                     filled: true,
//     //                     fillColor: Colors.white,
//     //                     border: OutlineInputBorder(
//     //                       borderSide: BorderSide.none,
//     //                       borderRadius: BorderRadius.circular(10),
//     //                     ),
//     //                     suffixIcon: IconButton(
//     //                       icon: Padding(
//     //                         padding: const EdgeInsets.only(right:18.0),
//     //                         child: Image.asset('assets/SearchIcon.png',width: 27,height: 27,),
//     //                       ),
//     //                       onPressed: () {
//     //                         // Add any functionality you want when the icon is pressed
//     //                       },
//     //                     ),
//     //                   ),
//     //                 ),
//     //               ),
//     //               SizedBox(
//     //                 height: 10.h,
//     //               ),
//     //               Divider(),
//     //               Row(
//     //                 children: [
//     //                   CustomText(
//     //                     text: "Sr No.",
//     //                     size: 15,
//     //                     weight: FontWeight.w100,
//     //                   ),
//     //                   SizedBox(
//     //                     width: 50.w,
//     //                   ),
//     //                   CustomText(
//     //                     text: "Driver Name",
//     //                     size: 15,
//     //                     weight: FontWeight.w100,
//     //                   ),
//     //                   SizedBox(
//     //                     width: 50.w,
//     //                   ),
//     //                   CustomText(
//     //                     text: "Vehicle model",
//     //                     size: 15,
//     //                     weight: FontWeight.w100,
//     //                   ),
//     //                   SizedBox(
//     //                     width: 50.w,
//     //                   ),
//     //                   CustomText(
//     //                     text: "Capacity",
//     //                     size: 15,
//     //                     weight: FontWeight.w100,
//     //                   ),
//     //                   SizedBox(
//     //                     width: 50.w,
//     //                   ),
//     //                 ],
//     //               ),
//     //               Divider(),
//     //               SingleChildScrollView(
//     //                   scrollDirection: Axis.vertical,
//     //                   child: SizedBox(
//     //                     height: 400.h,
//     //                     child:controller.driverList.isEmpty?Container():
//     //                     Column(
//     //                       children: List.generate(controller.driverList.length, (index) =>  Column(
//     //                         children: [
//     //                           Row(
//     //                             children: [
//     //                               SizedBox(
//     //                                 width:40.w,
//     //                                 child: Center(
//     //                                   child: CustomText(
//     //                                       text: (index+1).toString(),
//     //                                       size:15
//     //                                   ),
//     //                                 ),
//     //                               ),
//     //                               SizedBox(
//     //                                 width: 40.w,
//     //                               ),
//     //                               SizedBox(
//     //                                 width:100.w,
//     //                                 child: CustomText(
//     //                                     text: "${controller.driverList[index].firstName!} ${controller.driverList[index].lastName!}",
//     //                                     size:17
//     //                                 ),
//     //                               ),
//     //                               SizedBox(
//     //                                 width: 70.w,
//     //                               ),
//     //                               SizedBox(
//     //                                 width:100.w,
//     //                                 child: CustomText(
//     //                                     text: controller.driverList[index].vehicle!.vehicleModel!,
//     //                                     size:17
//     //                                 ),
//     //                               ),
//     //                               SizedBox(
//     //                                 width: 40.w,
//     //                               ),
//     //                               SizedBox(
//     //                                 width:50.w,
//     //                                 child: CustomText(
//     //                                     text: controller.driverList[index].vehicle!.vehicleCapacity.toString(),
//     //                                     size:17
//     //                                 ),
//     //                               ),
//     //                               SizedBox(
//     //                                 width: 10.w,
//     //                               ),
//     //                               InkWell(
//     //                                 onTap: () {
//     //                                   controller.assignVehicleAndDriverToRoute(controller.routeList[index].id!, controller.driverList[index].vehicle!.id!, controller.driverList[index].id!);
//     //                                 },
//     //                                 child: Container(
//     //                                   width: 70.w,
//     //                                   height: 40.h,
//     //                                   decoration: BoxDecoration(
//     //                                     color: active,
//     //                                     borderRadius: BorderRadius.circular(5),
//     //                                   ),
//     //                                   // padding: EdgeInsets.all(5),
//     //                                   child: Center(
//     //                                     child: Text(
//     //                                       "ADD",
//     //                                       style: TextStyle(
//     //                                         color: light,
//     //                                         fontSize: 12.sp,
//     //                                         fontWeight: FontWeight.bold,
//     //                                       ),
//     //                                     ),
//     //                                   ),
//     //                                 ),
//     //                               ),
//     //                               SizedBox(
//     //                                 width: 10.w,
//     //                               ),
//     //
//     //                             ],
//     //                           ),
//     //                           Divider(),
//     //                         ],
//     //                       ),),
//     //                     ),
//     //                   )
//     //
//     //               )
//     //
//     //             ],
//     //           ),
//     //         ),
//     //       );
//     //     },
//     //   );
//     // }
//     return  SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Obx(() => Row(
//             children: [
//               Container(
//                   margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 13),
//                   child: CustomText(
//                     text: menuController.activeItem.value,
//                     size: 24,
//                     weight: FontWeight.bold,
//                     color: light,
//                   )
//               ),
//             ],
//           ),
//           ),
//           Container(
//             height:150.h,
//             width: double.infinity,
//             margin: EdgeInsets.only(top: 20.h),
//             decoration: BoxDecoration(
//               color :light,
//               borderRadius: BorderRadius.circular(16.r),
//             ),
//             child: Row(
//               children: [
//                 Padding(
//                   padding:  EdgeInsets.all(18.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomText(
//                         text: "Company*",
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Container(
//                         constraints: BoxConstraints(
//                           maxWidth: 450,
//                         ),
//                         height: 50,
//                         child: MultiSelectDropDown.network(
//                           onOptionSelected: (options) {},
//                           networkConfig: NetworkConfig(
//                             url: 'https://jsonplaceholder.typicode.com/users',
//                             method: RequestMethod.get,
//                             headers: {
//                               'Content-Type': 'application/json',
//                             },
//                           ),
//                           searchEnabled: true,
//                           chipConfig: const ChipConfig(wrapType: WrapType.wrap),
//                           responseParser: (response) {
//
//                             final list = (response as List<dynamic>).map((e) {
//                               final item = e as Map<String, dynamic>;
//                               return ValueItem(
//                                 label: item['name'],
//                                 value: item['id'].toString(),
//                               );
//                             }).toList();
//
//                             return Future.value(list);
//                           },
//                           responseErrorBuilder: ((context, body) {
//                             return const Padding(
//                               padding: EdgeInsets.all(16.0),
//                               child: Text('Error fetching the data'),
//                             );
//                           }),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding:  EdgeInsets.all(18.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomText(
//                         text: "Date*",
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Container(
//                           constraints: BoxConstraints(
//                             maxWidth: 200,
//                           ),
//                           child: Container(
//                             height: 60.h,
//                             decoration: BoxDecoration(
//                               color: light,
//                               borderRadius: BorderRadius.circular(8.r),
//                             ),
//                             child:  Row(
//                               children: [
//                                 SizedBox(
//                                   width: 10.w,
//                                 ),
//                                 Container(
//                                   height: 60.h,
//                                   constraints: BoxConstraints(
//                                     minWidth: 170.w,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: light,
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     border: Border.all(color: lightGrey,width: 1.w),
//                                   ),
//                                   child: Padding(
//                                     padding:  EdgeInsets.all(8.h),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: <Widget>[
//                                         SizedBox(
//                                           width: 5.w,
//                                         ),
//                                         CustomText(
//                                           text :'Date',
//                                           size: ResponsiveWidget.isLargeScreen(context)?15.sp:ResponsiveWidget.isSmallScreen(context)?15.sp *4:15.sp *1.4,
//                                         ),
//                                         const Icon(Icons.date_range),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding:  EdgeInsets.all(18.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomText(
//                         text: "Shift*",
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Container(
//                         constraints: BoxConstraints(
//                           maxWidth: 150,
//                         ),
//                         height: 50,
//                         child: MultiSelectDropDown.network(
//                           onOptionSelected: (options) {},
//                           networkConfig: NetworkConfig(
//                             url: 'https://jsonplaceholder.typicode.com/users',
//                             method: RequestMethod.get,
//                             headers: {
//                               'Content-Type': 'application/json',
//                             },
//                           ),
//                           searchEnabled: true,
//                           chipConfig: const ChipConfig(wrapType: WrapType.wrap),
//                           responseParser: (response) {
//
//                             final list = (response as List<dynamic>).map((e) {
//                               final item = e as Map<String, dynamic>;
//                               return ValueItem(
//                                 label: item['name'],
//                                 value: item['id'].toString(),
//                               );
//                             }).toList();
//
//                             return Future.value(list);
//                           },
//                           responseErrorBuilder: ((context, body) {
//                             return const Padding(
//                               padding: EdgeInsets.all(16.0),
//                               child: Text('Error fetching the data'),
//                             );
//                           }),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Container(
//             height:400.h,
//             width: double.infinity,
//             margin: EdgeInsets.only(top: 20.h),
//             decoration: BoxDecoration(
//               color :light,
//               borderRadius: BorderRadius.circular(16.r),
//             ),
//             child: Padding(
//               padding:  EdgeInsets.all(15.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomText(
//                     text: "Remaining Routes",
//                     weight: FontWeight.bold,
//                   ),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                   Row(
//                     children: [
//                       CustomText(
//                         text: "Employee Count",
//                         size: 15,
//                         weight: FontWeight.w100,
//                       ),
//                       SizedBox(
//                         width: 50.w,
//                       ),
//                       CustomText(
//                         text: "Start Point",
//                         size: 15,
//                         weight: FontWeight.w100,
//                       ),
//                       SizedBox(
//                         width: 50.w,
//                       ),
//                       CustomText(
//                         text: "Start Time",
//                         size: 15,
//                         weight: FontWeight.w100,
//                       ),
//                       SizedBox(
//                         width: 50.w,
//                       ),
//                       CustomText(
//                         text: "Total Distance",
//                         size: 15,
//                         weight: FontWeight.w100,
//                       ),
//                       SizedBox(
//                         width: 50.w,
//                       ),
//                       CustomText(
//                         text: "Guard Tip",
//                         size: 15,
//                         weight: FontWeight.w100,
//                       ),
//                     ],
//                   ),
//                   Divider(),
//                   // SingleChildScrollView(
//                   //   scrollDirection: Axis.vertical,
//                   //   child:Obx(()=>
//                   //   Column(
//                   //     children: List.generate(controller.routeList.length,
//                   //             (index) {
//                   //               var current = controller.routeList[index];
//                   //               if(current.driver!=null) {
//                   //                 return Container();
//                   //               } else {
//                   //                 return Row(
//                   //                   children: [
//                   //                     SizedBox(
//                   //                       width: 110.w,
//                   //                       child: Center(
//                   //                         child: CustomText(
//                   //                             text: current.listOfEmployees
//                   //                                 ?.length.toString() ?? "0",
//                   //                             size: 15
//                   //                         ),
//                   //                       ),
//                   //                     ),
//                   //                     SizedBox(
//                   //                       width: 30.w,
//                   //                     ),
//                   //                     SizedBox(
//                   //                       width: 100.w,
//                   //                       child: Center(
//                   //                         child: CustomText(
//                   //                             text: current.startPointName
//                   //                                 ?.toString() ?? "--",
//                   //                             size: 15
//                   //                         ),
//                   //                       ),
//                   //                     ),
//                   //                     SizedBox(
//                   //                       width: 30.w,
//                   //                     ),
//                   //                     SizedBox(
//                   //                       width: 100.w,
//                   //                       child: Center(
//                   //                         child: CustomText(
//                   //                             text: "--",
//                   //                             size: 15
//                   //                         ),
//                   //                       ),
//                   //                     ),
//                   //                     SizedBox(
//                   //                       width: 30.w,
//                   //                     ),
//                   //                     SizedBox(
//                   //                       width: 100.w,
//                   //                       child: Center(
//                   //                         child: CustomText(
//                   //                             text: current.totalDistance
//                   //                                 ?.toString() ?? "00",
//                   //                             size: 15
//                   //                         ),
//                   //                       ),
//                   //                     ),
//                   //                     SizedBox(
//                   //                       width: 30.w,
//                   //                     ),
//                   //                     SizedBox(
//                   //                       width: 100.w,
//                   //                       child: Center(
//                   //                         child: CustomText(
//                   //                             text: current.isGuard
//                   //                                 ?.toString() ?? "No",
//                   //                             size: 15
//                   //                         ),
//                   //                       ),
//                   //                     ),
//                   //                     SizedBox(
//                   //                       width: 30.w,
//                   //                     ),
//                   //                     SizedBox(
//                   //                       width: 100.w,
//                   //                       child: Center(
//                   //                         child: InkWell(
//                   //                           onTap: () {
//                   //                             controller.tripDetails(current);
//                   //                             _showMyDialog(context);
//                   //                           },
//                   //                           child: const CustomText(
//                   //                               text: 'Details',
//                   //                               color: active,
//                   //                               size: 15
//                   //                           ),
//                   //                         ),
//                   //                       ),
//                   //                     ),
//                   //                     SizedBox(
//                   //                       width: 30.w,
//                   //                     ),
//                   //                     InkWell(
//                   //                       onTap: () {
//                   //                         _assignVehicle(context);
//                   //                       },
//                   //                       child: Button(
//                   //                           'Assign Driver',
//                   //                           150,
//                   //                           15,
//                   //                           50
//                   //                       ),
//                   //                     ),
//                   //                     SizedBox(
//                   //                       width: 30.w,
//                   //                     ),
//                   //                     Image.asset(
//                   //                       'assets/Cancel.png', width: 50.w,
//                   //                       height: 50.h,),
//                   //                   ],
//                   //                 );
//                   //               }
//                   //             }
//                   //     ),
//                   //   )
//                   //   )
//                   // )
//                 ],
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child:  Container(
//                     height:400.h,
//                     width: double.infinity,
//                     margin: EdgeInsets.only(top: 20.h),
//                     decoration: BoxDecoration(
//                       color :light,
//                       borderRadius: BorderRadius.circular(16.r),
//                     ),
//                     child: SingleChildScrollView(
//                       scrollDirection:  Axis.vertical,
//                       child: Padding(
//                         padding:  EdgeInsets.all(15.h),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomText(
//                               text: "Assigned Routes",
//                               weight: FontWeight.bold,
//                             ),
//                             SizedBox(
//                               height: 15.h,
//                             ),
//                             Row(
//                               children: [
//                                 CustomText(
//                                   text: "Employee Count",
//                                   size: 15,
//                                   weight: FontWeight.w100,
//                                 ),
//                                 SizedBox(
//                                   width: 50.w,
//                                 ),
//                                 CustomText(
//                                   text: "Start Point",
//                                   size: 15,
//                                   weight: FontWeight.w100,
//                                 ),
//                                 SizedBox(
//                                   width: 50.w,
//                                 ),
//                                 CustomText(
//                                   text: "Start Time",
//                                   size: 15,
//                                   weight: FontWeight.w100,
//                                 ),
//                                 SizedBox(
//                                   width: 50.w,
//                                 ),
//                                 CustomText(
//                                   text: "Total Distance",
//                                   size: 15,
//                                   weight: FontWeight.w100,
//                                 ),
//                                 SizedBox(
//                                   width: 30.w,
//                                 ),
//                                 CustomText(
//                                   text: "Guard Tip",
//                                   size: 15,
//                                   weight: FontWeight.w100,
//                                 ),
//                               ],
//                             ),
//                             Divider(),
//                             // SingleChildScrollView(
//                             //     scrollDirection: Axis.vertical,
//                             //     child:Obx(()=>
//                             //         Column(
//                             //           children: List.generate(controller.routeList.length,
//                             //                   (index) {
//                             //                 var current = controller.routeList[index];
//                             //                 if(current.driver==null) {
//                             //                   return Container();
//                             //                 } else {
//                             //                   return Padding(
//                             //                     padding: EdgeInsets.symmetric(
//                             //                         vertical: 9.w),
//                             //                     child: Row(
//                             //                       children: [
//                             //                         SizedBox(
//                             //                           width: 110.w,
//                             //                           child: Center(
//                             //                             child: CustomText(
//                             //                                 text: current
//                             //                                     .listOfEmployees
//                             //                                     ?.length
//                             //                                     .toString() ??
//                             //                                     "0",
//                             //                                 size: 15
//                             //                             ),
//                             //                           ),
//                             //                         ),
//                             //                         SizedBox(
//                             //                           width: 30.w,
//                             //                         ),
//                             //                         SizedBox(
//                             //                           width: 100.w,
//                             //                           child: Center(
//                             //                             child: CustomText(
//                             //                                 text: current
//                             //                                     .startPointName
//                             //                                     ?.toString() ??
//                             //                                     "--",
//                             //                                 size: 15
//                             //                             ),
//                             //                           ),
//                             //                         ),
//                             //                         SizedBox(
//                             //                           width: 30.w,
//                             //                         ),
//                             //                         SizedBox(
//                             //                           width: 100.w,
//                             //                           child: Center(
//                             //                             child: CustomText(
//                             //                                 text: "--",
//                             //                                 size: 15
//                             //                             ),
//                             //                           ),
//                             //                         ),
//                             //                         SizedBox(
//                             //                           width: 30.w,
//                             //                         ),
//                             //                         SizedBox(
//                             //                           width: 100.w,
//                             //                           child: Center(
//                             //                             child: CustomText(
//                             //                                 text: current
//                             //                                     .totalDistance
//                             //                                     ?.toString() ??
//                             //                                     "00",
//                             //                                 size: 15
//                             //                             ),
//                             //                           ),
//                             //                         ),
//                             //                         SizedBox(
//                             //                           width: 30.w,
//                             //                         ),
//                             //                         SizedBox(
//                             //                           width: 70.w,
//                             //                           child: Center(
//                             //                             child: CustomText(
//                             //                                 text: current
//                             //                                     .isGuard
//                             //                                     ?.toString() ??
//                             //                                     "No",
//                             //                                 size: 15
//                             //                             ),
//                             //                           ),
//                             //                         ),
//                             //                         SizedBox(
//                             //                           width: 30.w,
//                             //                         ),
//                             //                         SizedBox(
//                             //                           width: 70.w,
//                             //                           child: Center(
//                             //                             child: InkWell(
//                             //                               onTap: () {
//                             //                                 controller
//                             //                                     .tripDetails(
//                             //                                     current);
//                             //                                 _showMyDialog(
//                             //                                     context);
//                             //                               },
//                             //                               child: const CustomText(
//                             //                                   text: 'Details',
//                             //                                   color: active,
//                             //                                   size: 15
//                             //                               ),
//                             //                             ),
//                             //                           ),
//                             //                         ),
//                             //                         SizedBox(
//                             //                           width: 30.w,
//                             //                         ),
//                             //                       ],
//                             //                     ),
//                             //                   );
//                             //                 }
//                             //               }
//                             //           ),
//                             //         )
//                             //     )
//                             // )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//               ),
//               SizedBox(
//                 width: 10.w,
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   height:300.h,
//                   width: double.infinity,
//                   margin: EdgeInsets.only(top: 20.h),
//                   decoration: BoxDecoration(
//                     color :light,
//                     borderRadius: BorderRadius.circular(16.r),
//
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//           Center(
//             child: InkWell(
//               onTap: (){
//
//
//
//               },
//               child: Container(
//                 decoration: BoxDecoration(color: active,
//                     borderRadius: BorderRadius.circular(10)),
//                 alignment: Alignment.center,
//                 constraints:  const BoxConstraints(
//                   maxWidth:430,
//                 ),
//                 height: 50,
//                 child:  const CustomText(
//                   text: "Confirm",
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Center(
//             child: InkWell(
//               onTap: (){
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 decoration: BoxDecoration(color: Colors.red,
//                     borderRadius: BorderRadius.circular(10)),
//                 alignment: Alignment.center,
//                 constraints:  const BoxConstraints(
//                   maxWidth:430,
//                 ),
//                 height: 50,
//                 child:  const CustomText(
//                   text: "Cancel",
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//
//
//         ],
//       ),
//     );
//   }
// }