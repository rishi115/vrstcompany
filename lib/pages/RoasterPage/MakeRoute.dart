// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vrsstranslinkcompany/pages/RoasterPage/RoasterController/RoasterController.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:multi_dropdown/multiselect_dropdown.dart';
// import 'package:http/http.dart' as http;
// import '../../constants/controllers.dart';
// import '../../constants/responsiveness.dart';
// import 'package:get/get.dart';
// import '../../constants/style.dart';
// import '../../widgets/Button.dart';
// import '../../widgets/custom_text.dart';
//
// class MakeRoute extends StatefulWidget{
//   const MakeRoute({super.key});
//
//   @override
//   State<MakeRoute> createState() => _MakeRouteState();
// }
//
// class _MakeRouteState extends State<MakeRoute> {
//   final controller = Get.put(RoasterController());
//   GoogleMapController? _mapController;
//   Set<Marker> _markers = {};
//   Set<Polyline> _polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   final TextEditingController _timeController = TextEditingController();
//   LatLng _origin = LatLng(19.132296753365175, 73.00226250708334); // Example origin (San Francisco)
//   // Example destination (Los Angeles)
//   bool isloading=false;
//   LatLng? lastDestination;
//   RoasterController roasterController = Get.put(RoasterController());
//   List<int> TimeTaken=[];
//   int? time;
//
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         _timeController.text = picked.format(context);
//       });
//     }
//   }
//   final String _selectedItem = 'Login';
//   Future<void> _drawRoute(
//       String originLatitude, String originLongitude,
//       String destinationLatitude, String destinationLongitude
//       ) async {
//     var headers = {
//       'Content-Type': 'application/json'
//     };
//     var request = http.Request('POST', Uri.parse('https://vr-safetrips.onrender.com/api/direction/get'));
//
//     request.body = json.encode({
//       "origin": {
//         "lat": originLatitude,
//         "lng": originLongitude
//       },
//       "destination": {
//         "lat": destinationLatitude,
//         "lng": destinationLongitude
//       }
//     });
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       final data = json.decode(await response.stream.bytesToString());
//       final points = data["data"]['routes'][0]['overview_polyline']['points'];
//       roasterController.timeTaken.value = data["data"]['routes'][0]['legs'][0]['duration']['value'];
//       double distanceDouble = double.parse(data["data"]['routes'][0]['legs'][0]['distance']['text'].replaceAll(' km', ''));
//       roasterController.totalDistance.value += distanceDouble.round();
//       roasterController.timeInHour.value= roasterController.formatDuration(controller.timeTaken);
//       roasterController.timeDeparture.add((roasterController.timeTaken.value / 60).round());
//       try {
//         List<PointLatLng> decodedPoints = PolylinePoints().decodePolyline(points);
//         decodedPoints.forEach((PointLatLng point) {
//           polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//         });
//         setState(() {
//           isloading = true;
//           _polylines.add(
//             Polyline(
//               polylineId: PolylineId('route'),
//               color: Colors.blue,
//               points: polylineCoordinates,
//               width: 5,
//             ),
//           );
//           isloading = false;
//         });
//       } catch (e) {
//         print("error is here");
//       }
//
//       // Move the camera to fit the route
//       final bounds = _getLatLngBounds( LatLng(19.132296753365175, 73.00226250708334), LatLng(double.parse(destinationLatitude), double.parse(destinationLongitude)));
//       _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
//     } else {
//       throw Exception('Failed to load directions');
//     }
//   }
//
//
//
//   LatLngBounds _getLatLngBounds(LatLng origin, LatLng destination) {
//     double latMin = origin.latitude < destination.latitude ? origin.latitude : destination.latitude;
//     double latMax = origin.latitude > destination.latitude ? origin.latitude : destination.latitude;
//     double lngMin = origin.longitude < destination.longitude ? origin.longitude : destination.longitude;
//     double lngMax = origin.longitude > destination.longitude ? origin.longitude : destination.longitude;
//
//     return LatLngBounds(
//       southwest: LatLng(latMin, lngMin),
//       northeast: LatLng(latMax, lngMax),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return ResponsiveWidget(largeScreen: Column(
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
//                   )),
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
//                       const CustomText(
//                         text: "Date*",
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       InkWell(
//                         onTap: (){
//                           controller.SelectDate(context,controller.selectedDate);
//                         },
//                         child: Container(
//                             constraints: const BoxConstraints(
//                               maxWidth: 200,
//                             ),
//                             child: Container(
//                               height: 65.h,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(15.r),
//                                 border: Border.all(
//                                   color: Colors.grey.withOpacity(0.5),
//                                 ),
//                               ),
//                               child:  Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 10.w,
//                                   ),
//                                   Container(
//                                     height: 70.h,
//                                     constraints: BoxConstraints(
//                                       minWidth: 170.w,
//                                     ),
//                                     decoration: const BoxDecoration(
//                                       color: Colors.white,
//                                     ),
//                                     child: Padding(
//                                       padding:  EdgeInsets.all(8.h),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           SizedBox(
//                                             width: 5.w,
//                                           ),
//                                           Obx(()=> CustomText(
//                                             text :controller.selectedDate.value.isNotEmpty ? controller.selectedDate.value.toString().split(' ')[0] : 'Select',
//                                             size: ResponsiveWidget.isLargeScreen(context)?15.sp:ResponsiveWidget.isSmallScreen(context)?15.sp *4:15.sp *1.4,
//                                           ),
//                                           ),
//                                           const Icon(Icons.date_range),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
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
//                       const CustomText(
//                         text: "Trip Type*",
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Container(
//                         constraints: const BoxConstraints(
//                           maxWidth: 170,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(15.r),
//                           border: Border.all(
//                             color: Colors.grey.withOpacity(0.5),
//                           ),
//                         ),
//                         height: 50,
//                         child: Padding(
//                           padding: EdgeInsets.only(left:8.w),
//                           child: DropdownButton<String>(
//                             underline: Container(),
//                             hint: const Text('Select an option'),
//                             value: _selectedItem,
//                             items: ['Login', 'Logout'].map((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(value),
//                               );
//                             }).toList(),
//                             onChanged: (String? newValue) {
//                               if (newValue == 'Login') {
//                                 // Handle login action
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text('Login selected')),
//                                 );
//                               } else if (newValue == 'Logout') {
//                                 // Handle logout action
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text('Logout selected')),
//                                 );
//                               }
//                             },
//                           ),
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
//                       const CustomText(
//                         text: "Shift*",
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Container(
//                         constraints: const BoxConstraints(
//                           maxWidth: 150,
//                         ),
//                         height: 50,
//                         child: MultiSelectDropDown(
//                           dropdownHeight: 200.h,
//                           onOptionSelected: (options) {},
//                           options: [
//                             const ValueItem(label: "9:15", value: "1"),
//                             const ValueItem(label: "10:15", value: "2"),
//                             const ValueItem(label: "11:15", value: "3"),
//                             const ValueItem(label: "12:15", value: "4"),
//                           ],
//                           selectedOptions: [
//                             const ValueItem(label: "9:15", value: "1")
//                           ],
//                           selectionType: SelectionType.single,
//                           selectedOptionTextColor: Colors.black,
//
//                           singleSelectItemStyle: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.black,
//                           ),
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
//                       const CustomText(
//                         text: "Office*",
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Container(
//                         constraints: const BoxConstraints(
//                           maxWidth: 250,
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
//                             List<ValueItem> list = [];
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
//                 const Spacer(),
//                 Padding(
//                   padding:  EdgeInsets.only(top:40.h),
//                   child: InkWell(
//                     onTap: (){
//                       // controller.getRoaster();
//                     },
//                     child: Button(
//                         'Submit',
//                         150,
//                         15,
//                         60
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 Padding(
//                   padding:  EdgeInsets.only(top:40.h),
//                   child: GestureDetector(
//                     onTap: (){
//                     },
//                     child: Button(
//                         'Reset',
//                         150,
//                         15,
//                         60
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20.w,
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child:Obx(()=> Container(
//                   height: 700.h,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                   ),
//                   child: controller.loading.value? CircularProgressIndicator():  GoogleMap(
//                     initialCameraPosition: CameraPosition(
//                       target: controller.origin.value,
//                       zoom: 14.0,
//                     ),
//                     // markers: controller.markers,
//                     polylines: _polylines,
//                     onMapCreated: (Controller) {
//                       controller.mapController.value = Controller;
//                     },
//                   ),
//                 ),)
//               ),
//               SizedBox(
//                 width: 20.w,
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   height:700.h,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color :light,
//                   ),
//                   child: Padding(
//                     padding:  EdgeInsets.all(18.h),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Padding(
//                               padding:  EdgeInsets.only(left:12.h,bottom: 10.h,right:12.h),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CustomText(
//                                     text: "Vehicle*",
//                                     size: 14,
//                                   ),
//                                   SizedBox(
//                                     height: 10.h,
//                                   ),
//                                   Container(
//                                     constraints: BoxConstraints(
//                                       maxWidth: 150,
//                                     ),
//                                     height: 50,
//                                     child: MultiSelectDropDown(
//                                       onOptionSelected: (options) {
//                                         controller.selectedVehicle.value = SelectedVehicle(
//                                           vehicleId: options[0].value.toString(),
//                                           vehicleModel: options[0].label,
//                                           vendorName: controller.vehicleList.firstWhere((element) => element.id == options[0].value).vendorName,
//                                           vendorId: controller.vehicleList.firstWhere((element) => element.id == options[0].value).vendor,
//                                           vehicleCapacity: controller.vehicleList.firstWhere((element) => element.id == options[0].value).vehicleCapacity.toString(),
//                                         );
//                                       },
//                                       options: controller.vehicleList.map((e) => ValueItem(label: e.vehicleModel!, value: e.id)).toList(),
//                                       selectedOptions: [
//                                         controller.vehicleList.isNotEmpty?ValueItem(label: controller.vehicleList[0].vehicleModel!, value: controller.vehicleList[0].id):ValueItem(label: 'Select', value: 1),
//                                       ],
//                                       selectionType: SelectionType.single,
//                                       selectedOptionTextColor: Colors.black,
//
//                                       singleSelectItemStyle: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(left:12.h),
//                               child: CustomText(
//                                 text: "Same color indicate same nodal point",
//                                 size: 13,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 50.w,
//                             ),
//                             CustomText(
//                               text: "Capacity",
//                               size: 13,
//                             ),
//                             SizedBox(
//                               width: 10.w,
//                             ),
//                            Obx(() => CustomText(
//                              text: "${controller.selectedVehicle.value.vehicleCapacity ?? "0"}/0",
//                              size: 13,
//                            ))
//
//                             ,
//
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         Row(
//                           children: [
//
//                             CustomText(
//                               text: "Employee Name",
//                               size: 14,
//                               weight: FontWeight.bold,
//                             ),
//                             SizedBox(
//                               width: 70.w,
//                             ),
//                             CustomText(
//                               text: "Nodel Point",
//                               size: 14,
//                               weight: FontWeight.bold,
//                             ),
//                             SizedBox(
//                               width: 100.w,
//                             ),
//                             CustomText(
//                               text: "Distance",
//                               size: 14,
//                               weight: FontWeight.bold,
//                             ),
//                             SizedBox(
//                               width: 40.w,
//                             ),
//                             CustomText(
//                               text: "Pickup Time",
//                               size: 14,
//                               weight: FontWeight.bold,
//                             ),
//
//                           ],
//                         ),
//                         Divider(),
//                         SizedBox(
//                             height: 350.h,
//                             child:SingleChildScrollView(
//                                 scrollDirection: Axis.vertical,
//                                 child: Obx(()=>Column(
//                                   children: List.generate(
//                                     controller.Rxroasters.length,
//                                         (index) => Padding(
//                                       padding:  EdgeInsets.symmetric(vertical: 5.h),
//                                       child: GestureDetector(
//                                         onTap: (){
//                                             // Draw the route from the origin to the current nodal point
//                                             _drawRoute(
//                                                 controller.origin.value.latitude.toString(),
//                                                 controller.origin.value.longitude.toString(),
//                                                 controller.Rxroasters[index].nodalPoint!.latitude.toString(),
//                                                 controller.Rxroasters[index].nodalPoint!.longitude.toString()
//                                             );
//
//                                             // Update the origin to the current nodal point
//                                             controller.origin.value = LatLng(
//                                                 controller.Rxroasters[index].nodalPoint!.latitude!,
//                                                 controller.Rxroasters[index].nodalPoint!.longitude!
//                                             );
//                                             controller.startPointName.value = controller.Rxroasters[index].nodalPoint!.nodalPointName!;
//                                             // Add the employee location to routeList
//                                             employeeLocations current = employeeLocations(
//                                               employeeId: controller.Rxroasters[index].employee!.id,
//                                               nodalId: controller.Rxroasters[index].nodalPoint!.id,
//                                             );
//                                             controller.routeList.add(current);
//
//                                             // Create a new locationList object for the current nodal point
//                                             locationList currentLocation = locationList(
//                                                 lat: controller.Rxroasters[index].nodalPoint!.latitude!.toString(),
//                                                 long: controller.Rxroasters[index].nodalPoint!.longitude!.toString(),
//                                                 employeeCount: 1
//                                             );
//
//                                             // Check if the last location in locaList has the same lat/long as the current location
//                                             if (controller.locaList.isNotEmpty &&
//                                                 controller.locaList.last.lat == currentLocation.lat &&
//                                                 controller.locaList.last.long == currentLocation.long) {
//
//                                               // If the lat/long are the same, increment the employeeCount
//                                               controller.locaList.last.employeeCount = controller.locaList.last.employeeCount! + 1;
//
//                                             } else {
//                                               // If the lat/long are different, add the new currentLocation to locaList
//                                               controller.locaList.add(currentLocation);
//                                             }
//
//
//                                         },
//                                         child: Container(
//                                           height: 60.h,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(25.r),
//                                             border: Border.all(
//                                               color: Colors.grey.withOpacity(0.5),
//                                             ),
//                                           ),
//                                           child: Padding(
//                                             padding: EdgeInsets.all(8.h),
//                                             child: Row(
//                                               children: [
//                                                 SizedBox(
//                                                   width:110.w,
//                                                   child: Center(
//                                                     child: CustomText(
//                                                       text: '${controller.Rxroasters[index].employee!.firstName!} ${controller.Rxroasters[index].employee!.lastName!}',
//                                                       size:14,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   width:20.w,
//                                                 ),
//                                                 SizedBox(
//                                                   width:160.w,
//                                                   child: Center(
//                                                     child: CustomText(
//                                                       text: controller.Rxroasters[index].nodalPoint!.nodalPointName!,
//                                                       size:14,
//                                                       color: Colors.green,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   width:40.w,
//                                                 ),
//                                                 SizedBox(
//                                                   width:60.w,
//                                                   child: Center(
//                                                     child: CustomText(
//                                                         text: '12 Km',
//                                                         size:14
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   width:50.w,
//                                                   child: Center(
//                                                     child: InkWell(
//                                                       onTap: (){
//
//                                                       },
//                                                         child: Image.asset('assets/Cancel.png',scale: 1.5)),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   width:20.w,
//                                                 ),
//                                                 SizedBox(
//                                                   width:50.w,
//                                                   child: Center(
//                                                     child: CustomText(
//                                                         text: '-\\-',
//                                                         size:14
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),),
//                                 ),)
//
//                             )
//                         ),
//                         SizedBox(
//                           height: 5.h,
//                         ),
//                         Row(
//                           children: [
//                             CustomText(text: "Duration",size: 14,weight: FontWeight.bold,),
//                             SizedBox(
//                               width: 10.w,
//                             ),
//                             Obx(()=>
//                             CustomText(text: controller.timeInHour.value,size: 14,color: active,),),
//                           ],
//                         ),
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children:[
//                               InkWell(
//                                 onTap: (){},
//                                child: Button(
//                                    'Make Route',
//                                    150,
//                                    15,
//                                    50
//                                ),
//                               ),
//                               InkWell(
//                                 onTap: (){
//                                   _polylines.clear();
//                                   },
//                                 child: Button(
//                                     'Reset',
//                                     150,
//                                     15,
//                                     50
//                                 ),
//                               )
//
//                             ]
//                         )
//
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           )
//         ]
//     )
//     );
//   }
// }
// void _showMyDialog(BuildContext context,
//     RouteModel routeModel) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         contentPadding: EdgeInsets.only(top: 20.h),
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         title: const Text('Trip Route Details'),
//         content: Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 10.w, right: 10.w),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
//                 child: SizedBox(
//                   height: 0.5.sh, // Adjust the height of the map
//                   width: 0.25.sw, // Adjust the width of the map
//                   child: Obx(() => controller.mapLoader.value
//                       ? Center(child: CircularProgressIndicator())
//                       : GoogleMap(
//                     initialCameraPosition: CameraPosition(
//                       target:  controller.officeLocation.value,
//                       zoom: 14.0,
//                     ),
//                     markers:controller.Routemarkers,
//                     polylines: Set<Polyline>.of(controller.locationPolylines),
//                     onMapCreated: (GoogleMapController mapController) {
//                       controller.MapController.value.complete(mapController);
//                     },
//                   )),
//                 ),
//               ),
//             ),
//             SizedBox(
//                 height: 0.5.sh, // Adjust the height of the map
//                 width: 0.2.sw, // Adjust the width of the map
//                 child: Column(
//                   children: [
//                     Divider(),
//                     CustomText(text: "Employee Details"),
//                     SizedBox(
//                       child: Divider(),
//                       height: 10.h,
//                     ),
//                     SizedBox(
//                       child: SingleChildScrollView(
//                           child: Padding(
//                             padding:  EdgeInsets.all(5.w),
//                             child:Column(
//                               children: List.generate(routeModel.assignedEmployees!.length, (index) {
//                                 var current = routeModel.assignedEmployees![index];
//                                 return  Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         Checkbox(
//                                             value: true,
//                                             onChanged:
//                                                 (bool? value) {
//                                               // controller.toggleCheckbox(value);
//                                             }
//                                         ),
//                                         SizedBox(
//                                           width: 5.w,
//                                         ),
//                                         CustomText(text: (index+1).toString()
//                                           ,size: 14,
//                                         ),
//                                         SizedBox(
//                                           width: 5.w,
//                                         ),
//                                         CustomText(
//                                           text: "${current.employee!.firstName} ${current.employee!.lastName}",
//                                           size:14,
//                                         ),
//
//                                         Spacer(),
//                                         Tooltip(
//                                           message: 'Convert to Home',
//                                           child: IconButton(
//                                               onPressed: (){
//
//                                               },
//                                               icon: const Icon(
//                                                 Icons.home,
//                                                 size: 15,
//                                               )
//                                           ),
//                                         ),
//                                         Tooltip(
//                                           message: 'Copy',
//                                           child: IconButton(
//                                               onPressed: (){
//
//                                               },
//                                               icon: const Icon(
//                                                 Icons.copy,
//                                                 size: 15,
//                                               )
//                                           ),
//                                         ),
//                                         Tooltip(
//                                           message: 'Delete',
//                                           child: IconButton(
//                                               onPressed: (){
//
//                                               }, icon: const Icon(Icons.delete,
//                                             size: 15,
//                                           )
//                                           ),
//                                         ),
//
//
//                                       ],
//                                     ),
//                                     Divider(),
//                                   ],
//                                 );
//                               }),
//                             ),
//                           )
//                       ),
//                     ),
//                   ],
//                 )
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               controller.locationPolylines.clear();
//               controller.polylineCoordinates.clear();
//               Navigator.of(context).pop();
//             },
//             child: const Text('Close'),
//           ),
//         ],
//       );
//     },
//   );
// }