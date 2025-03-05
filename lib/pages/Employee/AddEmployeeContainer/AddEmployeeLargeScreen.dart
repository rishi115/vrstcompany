import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/pages/Employee/EmployeeController/EmployeeController.dart';
import '../../../../constants/responsiveness.dart';
import '../../../../constants/style.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../widgets/custom_text.dart';
import '../../../widgets/InputField.dart';


class AddEmployeeLarge extends StatefulWidget {
  const AddEmployeeLarge({super.key});

  @override
  State<AddEmployeeLarge> createState() => _AddEmployeeLargeState();
}

class _AddEmployeeLargeState extends State<AddEmployeeLarge> {
  final controller = Get.find<EmployeeController>();

  late GoogleMapController mapController;
  Set<Marker> markers = {};
  LatLng initialPosition = LatLng(37.4221, -122.0841); // Example coordinates (Googleplex)
  List<Set<String>> officeList = [{'Select Office', '8768'}];
  void _addMarker(LatLng position) {
    markers.add(
      Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(
          title: 'Your Location',
          snippet: 'This is your current location',
        ),
        icon: BitmapDescriptor.defaultMarker, // Default red marker icon
      ),
    );
    initialPosition = position;
    setState(() {}); // Update the UI with the new marker
  }
  void _onMapTapped(LatLng latLng) async {
    print("Map tapped at: ${latLng.latitude}, ${latLng.longitude}");

    try {
      var request = http.Request('GET', Uri.parse('https://vr-safetrips.onrender.com/api/direction/geocode?latitude=${latLng.latitude}&longitude=${latLng.longitude}'));
      request.headers.addAll({
        'Content-Type': 'application/json',
      });

      http.StreamedResponse response = await request.send();
      print(response.statusCode);

      if (response.statusCode == 200) {
        String address = await response.stream.bytesToString();
        print("Response: $address");

        if (address.isNotEmpty) {
          Map<String, dynamic> jsonResponse = jsonDecode(address);

          if (jsonResponse["success"] == true && jsonResponse["data"] != null) {
            List<dynamic> data = jsonResponse["data"];

            if (data.isNotEmpty) {
              String location = data[0]["formatted_address"];
              controller.employee.value.address = location;
              controller.employee.value.locality = location;
              controller.employee.value.latitude = latLng.latitude.toString();
              controller.employee.value.longitude = latLng.longitude.toString();
              setState(() {
                markers.clear();
                markers.add(Marker(
                  markerId: MarkerId(latLng.toString()),
                  position: latLng,
                  infoWindow: InfoWindow(title: location), // Show address on marker
                ));
              });
            } else {
              print("No data found");
            }
          } else {
            print("API Success false or Empty Data");
          }
        } else {
          print("Empty Address Response");
        }
      } else {
        print("Failed with status: ${response.statusCode}");
      }

    } catch (e) {
      print("Geocoding Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    List<String> gender = ['Male', 'Female', 'Other'];
    List<String>  categories = ['Driver', 'Helper', 'Admin', 'Manager', 'Supervisor', 'Other'];
    List<String>  employmentType = ['Permanent', 'Temporary', 'Contract', 'Other'];
    List<Set<String>> PickupReimbursementZone = [{"Select", '8768'}];
    List<Set<String>> DropReimbursementZone = [{'Select','87687'}];
    List<Set<String>> officeList =[{'Select','87687'}];


    controller.nodalList.forEach((element) {
      PickupReimbursementZone.add({element.nodalPointName,element.id});
      DropReimbursementZone.add({element.nodalPointName,element.id});

    });
    controller.officeList.forEach((element) {
      officeList.add({element.name, element.id});
    });
    Map<String, String> officeMap = {
      for (var set in officeList) set.first: set.last
    };
    List<String> officeListMap = officeMap.keys.toList();
    Map<String, String> PickupMap = {
      for (var set in PickupReimbursementZone) set.first: set.last
    };
    Map<String, String> DropMap = {
      for (var set in DropReimbursementZone) set.first: set.last
    };


    // Extract names from the map keys
    List<String> PickupList = PickupMap.keys.toList();
    List<String> DropList = DropMap.keys.toList();
    List<String>  isSupervisorlist = ['Yes', 'No', 'Other'];
    List<String>  languages = ['English', 'Hindi', 'Tamil', 'Telugu', 'Kannada', 'Malayalam', 'Other'];



    return  ResponsiveWidget.isLargeScreen(context)
        ? Column(
      children: [
        Row(
          children: [
            SizedBox(width: 20.w,),
            Field(
              context,
              'First Name*',
              90,
              250,
              'First Name*',
              TextEditingController(text: controller.employee.value.firstName),
                  (value) => controller.employee.update((val) => val!.firstName = value),
            ),
            SizedBox(width: 20.w,),

            Field(
              context,
              'Middle Name',
              90,
              250,
              'Middle Name',
              TextEditingController(text: controller.employee.value.middleName),
                  (value) => controller.employee.update((val) => val!.middleName = value),
            ),
            SizedBox(width: 20.w,),

            Field(
              context,
              'Last Name*',
              90,
              250,
              'Last Name*',
              TextEditingController(text: controller.employee.value.lastName),
                  (value) => controller.employee.update((val) => val!.lastName = value),
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
                        text: 'Gender*',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "Gender*",
                          items: gender,
                          onChanged: (value) {
                            controller.employee.update((val) => val?.gender = value);
                          },
                          selectedItem:  controller.employee.value.gender==null?
                          'Male':controller.employee.value.gender!,
                        ),),
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
              'Primary Contact*',
              90,
              250,
              'Primary Contact*',
              TextEditingController(text: controller.employee.value.contactNumber),
                  (value) => controller.employee.update((val) => val!.contactNumber = value),
            ),

            SizedBox(width: 20.w,),

            Field(
              context,
              'Secondary Contact',
              90,
              250,
              'Secondary Contact',
              TextEditingController(text: controller.employee.value.secondaryContactNumber),
                  (value) => controller.employee.update((val) => val!.secondaryContactNumber = value),
            ),
            SizedBox(width: 20.w,),

            Field(
              context,
              'Email*',
              90,
              250,
              'Email*',
              TextEditingController(text: controller.employee.value.email),
                  (value) => controller.employee.update((val) => val!.email = value),
            ),
            SizedBox(width: 20.w,),

            Field(
              context,
              'Age*',
              90,
              250,
              'Age*',
              TextEditingController(text: controller.employee.value.age),
                  (value) => controller.employee.update((val) => val!.age = value),
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
              TextEditingController(text: controller.employee.value.supervisorName),
                  (value) => controller.employee.update((val) => val!.supervisorName = value),
            ),
            SizedBox(width: 40,),

            Container(
              width:200.w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: CustomText(
                        text: 'Category',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "Category",
                          items: categories,
                          onChanged: (value) {
                            controller.employee.update((val) => val!.category = [value]);
                          },
                          selectedItem: controller.employee.value.category==null ? 'Driver' : controller.employee.value.category![0]!,
                        ),),
                  ]
              ),

            ),
            SizedBox(width: 5,),
            Container(
              width:250.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(8.w),
                    child: CustomText(
                      text: 'Transport Inactive Date',
                      size: 15.sp,
                      color: dark,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Obx(() =>  DateFiller(
                    title: "Transport Inactive Date",
                    context: context,
                    value: controller.TransportInactiveday.value.isNotEmpty ? controller.TransportInactiveday.value.toString().split(' ')[0] : 'Select', onChanged: () {
                    controller.SelectDate(context, controller.TransportInactiveday);
                  },
                  ),),
                ],
              ),
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
                        text: 'isSupervisor',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "isSupervisor",
                          items: isSupervisorlist,
                          onChanged: (value) {
                            if(value == 'Yes'){
                              controller.employee.value.isSupervisor = true;
                            }else{
                              controller.employee.value.isSupervisor = false;
                            }
                          },
                          selectedItem:  controller.employee.value.isSupervisor == true ? 'Yes' : 'No',
                        ),),
                  ]
              ),

            ),

          ],
        ),
        Row(
          children: [
            SizedBox(width: 40,),
            Container(
              width:200.w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: CustomText(
                        text: 'Employment Type',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "Employment Type",
                          items: employmentType,
                          onChanged: (value) {
                            controller.employee.update((val) => val!.employmentType = value);
                          },
                          selectedItem:  controller.employee.value.employmentType==null ? 'Permanent' : controller.employee.value.employmentType!,
                        ),),
                  ]
              ),

            ),
            Field(
              context,
              'Employee ID*',
              90,
              250,
              'Employee ID*',
              TextEditingController(text: controller.employee.value.employeeId),
                  (value) => controller.employee.update((val) => val!.employeeId = value),
            ),

            SizedBox(width: 20.w,),
            Field(
              context,
              'Secondary Id',
              90,
              250,
              'Secondary Id',
              TextEditingController(text: controller.employee.value.secondaryId),
                  (value) => controller.employee.update((val) => val!.secondaryId = value),
            ),
            SizedBox(width: 20.w,),
            Field(
              context,
              'RFID*',
              90,
              250,
              'RFID*',
              TextEditingController(text: controller.employee.value.rfid),
                  (value) => controller.employee.update((val) => val!.rfid = value),
            ),

          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 20.w,),
            Container(
              width:250.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(8.w),
                    child: CustomText(
                        text: 'Date of Birth*',
                      size: 15.sp,
                      color: dark,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Obx(() =>  DateFiller(
                    title: "Date of Birth*",
                    context: context,
                    value: controller.DateofBirth.value.isNotEmpty ? controller.DateofBirth.value.toString().split(' ')[0] : 'Select', onChanged: () {
                    controller.SelectDate(context, controller.DateofBirth);
                  },
                  ),),
                ],
              ),
            ),
            SizedBox(width: 20.w,),
            Container(
              width: 250.w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: CustomText(
                        text: 'Joining Date*',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DateFiller(
                          title: "Joining Date*",
                          context: context,
                          value: controller.DateofJoining.value.isNotEmpty ? controller.DateofJoining.value.toString().split(' ')[0] : 'Select', onChanged: () {
                          controller.SelectDate(context,controller.DateofJoining);
                        },
                        ),),
                  ]
              ),
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
                        text: 'Languages Known',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "Launguage Known",
                          items: languages,
                          onChanged: (value) {
                            controller.employee.update((val) => val!.languagesKnown = [value]);
                          },
                          selectedItem: controller.employee.value.languagesKnown==null?
                          'English':controller.employee.value.languagesKnown![0]!,
                        ),),
                  ]
              ),

            ),
            SizedBox(width: 20.w,),
            Field(
              context,
              'Disability*',
              90,
              250,
              'Disability*',
              TextEditingController(text: controller.employee.value.disability),
                  (value) => controller.employee.update((val) => val!.disability = value),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 20.w,),
            Field(
              context,
              'Address*',
              90,
              250,
              'Address*',
              TextEditingController(text: controller.employee.value.address),
                  (value) => controller.employee.update((val) => val!.address = value),
            ),

            SizedBox(width: 20.w,),
            Field(
              context,
              'City',
              90,
              250,
              'City',
              TextEditingController(text: controller.employee.value.locality),
                  (value) => controller.employee.update((val) => val!.locality = value),
            ),
            SizedBox(width: 20.w,),
            Field(
              context,
              'Latitude*',
              90,
              150,
              'Latitude*',
              TextEditingController(text: controller.employee.value.latitude),
                  (value) => controller.employee.update((val) => val!.latitude = value),
            ),
            SizedBox(width: 20.w,),
            Field(
              context,
              'Longitude*',
              90,
              150,
              'Longitude*',
              TextEditingController(text: controller.employee.value.longitude),
                  (value) => controller.employee.update((val) => val!.longitude = value),
            ),
            SizedBox(width: 20.w,),
            Padding(
              padding: const EdgeInsets.only(top :25.0),
              child: InkWell(
                onTap: (){
                  controller.gotolocation(context);
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
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
              width: 400.w,
              height:400.h,
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                markers: markers, // Set of markers on the map
                initialCameraPosition: CameraPosition(
                  target: initialPosition,
                  zoom: 14.0, // Zoom level
                ),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                onTap: (LatLng latLng) {
                  _onMapTapped(latLng);
                },
              )
          ),
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 40,),
            Container(
              width:250.w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: CustomText(
                        text: 'Pickup Reimbursement Zone',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "Pickup Reimbursement Zone",
                          items: PickupList,
                          onChanged: (value) {
                            controller.employee.update((val) => val!.pickupReimbursementZone = [value]);
                          },
                          selectedItem: controller.employee.value.pickupReimbursementZone==null ? 'Select' : controller.employee.value.pickupReimbursementZone![0]!,
                        ),),
                  ]
              ),

            ),
            SizedBox(width: 40,),
            Container(
              width:250.w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: CustomText(
                        text: 'Pickup Reimbursement Zone',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "Drop Reimbursement Zone",
                          items: DropList,
                          onChanged: (value) {
                            controller.employee.update((val) => val!.dropReimbursementZone = [value]);
                            String? selectedId =  DropMap[value];
                            print("Selected ID: $selectedId");
                          },
                          selectedItem:   controller.employee.value.dropReimbursementZone==null ? 'Select' : controller.employee.value.dropReimbursementZone![0]!,
                        ),),
                  ]
              ),

            ),
            SizedBox(width: 40,),
            Container(
              width:250.w,

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: CustomText(
                        text: 'Office*',
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
                            title: "Select Office*",
                            items: officeListMap,
                            onChanged: (value) {
                              controller.employee.value.office = officeMap[value]!;
                              controller.officeName.value = value!;
                            },
                            selectedItem: controller.officeName.value==''?'Select':controller.officeName.value,
                          ),
                        )
                    ),
                  ]
              ),

            ),


          ],)
      ],
    )
        : ResponsiveWidget.isMediumScreen(context)
        ? Column(
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
              TextEditingController(text: controller.employee.value.firstName),
                  (value) => controller.employee.update((val) => val!.firstName = value),
            ),
            SizedBox(width: 20.w,),

            Field(
              context,
              'Middle Name',
              90,
              250,
              'Middle Name',
              TextEditingController(text: controller.employee.value.middleName),
                  (value) => controller.employee.update((val) => val!.middleName = value),
            ),
            SizedBox(width: 20.w,),

            Field(
              context,
              'Last Name',
              90,
              250,
              'Last Name',
              TextEditingController(text: controller.employee.value.lastName),
                  (value) => controller.employee.update((val) => val!.lastName = value),
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
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "Gender",
                          items: gender,
                          onChanged: (value) {
                            controller.employee.update((val) => val?.gender = value);
                          },
                          selectedItem:  controller.employee.value.gender==null?
                          'Male':controller.employee.value.gender!,
                        ),),
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
              TextEditingController(text: controller.employee.value.contactNumber),
                  (value) => controller.employee.update((val) => val!.contactNumber = value),
            ),

            SizedBox(width: 20.w,),

            Field(
              context,
              'Secondary Contact',
              90,
              250,
              'Secondary Contact',
              TextEditingController(text: controller.employee.value.secondaryContactNumber),
                  (value) => controller.employee.update((val) => val!.secondaryContactNumber = value),
            ),
            SizedBox(width: 20.w,),

            Field(
              context,
              'Email',
              90,
              250,
              'Email',
              TextEditingController(text: controller.employee.value.email),
                  (value) => controller.employee.update((val) => val!.email = value),
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
              TextEditingController(text: controller.employee.value.supervisorName),
                  (value) => controller.employee.update((val) => val!.supervisorName = value),
            ),
            SizedBox(width: 40,),

            Container(
              width:200.w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: CustomText(
                        text: 'Category',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "Category",
                          items: categories,
                          onChanged: (value) {
                            controller.employee.update((val) => val!.category = [value]);
                          },
                          selectedItem: controller.employee.value.category==null ? 'Driver' : controller.employee.value.category![0]!,
                        ),),
                  ]
              ),

            ),
            SizedBox(width: 5,),
            Obx(() =>  DateFiller(
              title: "Transport Inactive Date",
              context: context,
              value: controller.TransportInactiveday.value.isNotEmpty ? controller.TransportInactiveday.value.toString().split(' ')[0] : 'Select', onChanged: () {
              controller.SelectDate(context, controller.TransportInactiveday);
            },
            ),),
            SizedBox(width: 30,),

            Container(
              width:200.w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: CustomText(
                        text: 'isSupervisor',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "isSupervisor",
                          items: isSupervisorlist,
                          onChanged: (value) {
                            if(value == 'Yes'){
                              controller.employee.value.isSupervisor = true;
                            }else{
                              controller.employee.value.isSupervisor = false;
                            }
                          },
                          selectedItem:  controller.employee.value.isSupervisor == true ? 'Yes' : 'No',
                        ),),
                  ]
              ),

            ),

          ],
        ),
        Row(
          children: [
            SizedBox(width: 40,),
            Container(
              width:200.w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: CustomText(
                        text: 'Employment Type',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "Employment Type",
                          items: employmentType,
                          onChanged: (value) {
                            controller.employee.update((val) => val!.employmentType = value);
                          },
                          selectedItem:  controller.employee.value.employmentType==null ? 'Permanent' : controller.employee.value.employmentType!,
                        ),),
                  ]
              ),

            ),
            Field(
              context,
              'Employee ID*',
              90,
              250,
              'Employee ID*',
              TextEditingController(text: controller.employee.value.employeeId),
                  (value) => controller.employee.update((val) => val!.employeeId = value),
            ),

            SizedBox(width: 20.w,),
            Field(
              context,
              'Secondary Id',
              90,
              250,
              'Secondary Id',
              TextEditingController(text: controller.employee.value.secondaryId),
                  (value) => controller.employee.update((val) => val!.secondaryId = value),
            ),
            SizedBox(width: 20.w,),
            Field(
              context,
              'RFID*',
              90,
              250,
              'RFID*',
              TextEditingController(text: controller.employee.value.rfid),
                  (value) => controller.employee.update((val) => val!.rfid = value),
            ),

          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 20.w,),
            Container(
              width:200.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(8.w),
                    child: CustomText(
                      text: 'Date of Birth',
                      size: 15.sp,
                      color: dark,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Obx(() =>  DateFiller(
                    title: "Date of Birth",
                    context: context,
                    value: controller.DateofBirth.value.isNotEmpty ? controller.DateofBirth.value.toString().split(' ')[0] : 'Select', onChanged: () {
                    controller.SelectDate(context, controller.DateofBirth);
                  },
                  ),),
                ],
              ),
            ),
            SizedBox(width: 20.w,),
            Container(
              width: 200.w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: CustomText(
                        text: 'Joining Date',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DateFiller(
                          title: "Joining Date",
                          context: context,
                          value: controller.DateofJoining.value.isNotEmpty ? controller.DateofJoining.value.toString().split(' ')[0] : 'Select', onChanged: () {
                          controller.SelectDate(context,controller.DateofJoining);
                        },
                        ),),
                  ]
              ),
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
                        text: 'Languages Known',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "Launguage Known",
                          items: languages,
                          onChanged: (value) {
                            controller.employee.update((val) => val!.languagesKnown = [value]);
                          },
                          selectedItem: controller.employee.value.languagesKnown==null?
                          'English':controller.employee.value.languagesKnown![0]!,
                        ),),
                  ]
              ),

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
              TextEditingController(text: controller.employee.value.address),
                  (value) => controller.employee.update((val) => val!.address = value),
            ),

            SizedBox(width: 20.w,),
            Field(
              context,
              'City',
              90,
              250,
              'City',
              TextEditingController(text: controller.employee.value.locality),
                  (value) => controller.employee.update((val) => val!.locality = value),
            ),
            SizedBox(width: 20.w,),
            Field(
              context,
              'Latitude',
              90,
              150,
              'Latitude',
              TextEditingController(text: controller.employee.value.latitude),
                  (value) => controller.employee.update((val) => val!.latitude = value),
            ),
            SizedBox(width: 20.w,),
            Field(
              context,
              'Longitude',
              90,
              150,
              'Longitude',
              TextEditingController(text: controller.employee.value.longitude),
                  (value) => controller.employee.update((val) => val!.longitude = value),
            ),
            SizedBox(width: 20.w,),
            Padding(
              padding: const EdgeInsets.only(top :25.0),
              child: InkWell(
                onTap: (){
                  controller.gotolocation(context);
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
            Container(
              width:200.w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: CustomText(
                        text: 'Pickup Reimbursement Zone',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "Pickup Reimbursement Zone",
                          items: employmentType,
                          onChanged: (value) {
                            controller.employee.update((val) => val!.pickupReimbursementZone = [value]);
                          },
                          selectedItem: controller.employee.value.pickupReimbursementZone==null ? 'Permanent' : controller.employee.value.pickupReimbursementZone![0]!,
                        ),),
                  ]
              ),

            ),
            SizedBox(width: 40,),
            Container(
              width:200.w,

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: CustomText(
                        text: 'Pickup Reimbursement Zone',
                        size: 15.sp,
                        color: dark,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Obx(() =>
                        DropDown(
                          context: context,
                          title: "Drop Reimbursement Zone",
                          items: employmentType,
                          onChanged: (value) {
                            controller.employee.update((val) => val!.dropReimbursementZone = [value]);
                          },
                          selectedItem:   controller.employee.value.dropReimbursementZone==null ? 'Permanent' : controller.employee.value.dropReimbursementZone![0]!,
                        ),),
                  ]
              ),

            ),
            Container(
              width:200.w,

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: CustomText(
                        text: 'Pickup Reimbursement Zone',
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
                              controller.employee.value.office = officeMap[value]!;
                              controller.officeName.value = value!;
                            },
                            selectedItem: controller.officeName.value==''?'Select Office':controller.officeName.value,
                          ),
                        )
                    ),
                  ]
              ),

            ),


          ],)
      ],
    )
        : Column(
            children: [
          SizedBox(width: 20.w,),
          Field(
            context,
          'First Name',
          90,
          1000,
          'First Name',
          TextEditingController(text: controller.employee.value.firstName),
              (value) => controller.employee.update((val) => val!.firstName = value),
          fontsize: 60,
        ),
        SizedBox(width: 20.w,),

        Field(
          context,
          'Middle Name',
          90,
          1000,
          'Middle Name',
          TextEditingController(text: controller.employee.value.middleName),
              (value) => controller.employee.update((val) => val!.middleName = value),
          fontsize: 60,
        ),
        SizedBox(width: 20.w,),

        Field(
          context,
          'Last Name',
          90,
          1000,
          'Last Name',
          TextEditingController(text: controller.employee.value.lastName),
              (value) => controller.employee.update((val) => val!.lastName = value),
          fontsize: 60,
        ),


        SizedBox(width: 30,),
        Container(
          width:1000.w,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Padding(
                  padding:  EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Gender',
                    size: 60.sp,
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
                        controller.employee.update((val) => val?.gender = value);
                      },
                      selectedItem:  controller.employee.value.gender==null?
                      'Male':controller.employee.value.gender!,
                      fontsize: 60,
                    ),),
              ]
          ),

        ),
        SizedBox(width: 20.w,),
        Field(
          context,
          'Primary Contact',
          90,
          1000,
          'Primary Contact',
          TextEditingController(text: controller.employee.value.contactNumber),
              (value) => controller.employee.update((val) => val!.contactNumber = value),
          fontsize: 60,
        ),

        SizedBox(width: 20.w,),

        Field(
          context,
          'Secondary Contact',
          90,
          1000,
          'Secondary Contact',
          TextEditingController(text: controller.employee.value.secondaryContactNumber),
              (value) => controller.employee.update((val) => val!.secondaryContactNumber = value),
          fontsize: 60,
        ),
        SizedBox(width: 20.w,),

        Field(
          context,
          'Email',
          90,
          1000,
          'Email',
          TextEditingController(text: controller.employee.value.email),
              (value) => controller.employee.update((val) => val!.email = value),
          fontsize: 60,
        ),
        SizedBox(width: 20.w,),
        Field(
          context,
          'Supervisor Name',
          90,
          1000,
          'Supervisor Name',
          TextEditingController(text: controller.employee.value.supervisorName),
              (value) => controller.employee.update((val) => val!.supervisorName = value),
          fontsize: 60,
        ),
        SizedBox(width: 40,),

        Container(
          width:1000.w,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Padding(
                  padding:  EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Category',
                    size: 60.sp,
                    color: dark,
                    weight: FontWeight.bold,
                  ),
                ),
                Obx(() =>
                    DropDown(
                      context: context,
                      title: "Category",
                      items: categories,
                      onChanged: (value) {
                        controller.employee.update((val) => val!.category = [value]);
                      },
                      selectedItem: controller.employee.value.category==null ? 'Driver' : controller.employee.value.category![0]!,
                      fontsize: 60,
                    ),),
              ]
          ),

        ),
        SizedBox(width: 5,),
        Container(
          width: 1000.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.all(8.w),
                child: CustomText(
                  text: 'Transport Inactive Date',
                  size: 60.sp,
                  color: dark,
                  weight: FontWeight.bold,
                ),
              ),
              Obx(() =>  DateFiller(
                title: "Transport Inactive Date",
                context: context,
                value: controller.TransportInactiveday.value.isNotEmpty ? controller.TransportInactiveday.value.toString().split(' ')[0] : 'Select', onChanged: () {
                controller.SelectDate(context, controller.TransportInactiveday);
                },
                fontsize: 60,
              ),),
            ],
          ),
        ),
        SizedBox(width: 30,),

        Container(
          width:1000.w,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Padding(
                  padding:  EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'isSupervisor',
                    size: 60.sp,
                    color: dark,
                    weight: FontWeight.bold,
                  ),
                ),
                Obx(() =>
                    DropDown(
                      context: context,
                      title: "isSupervisor",
                      items: isSupervisorlist,
                      onChanged: (value) {
                        if(value == 'Yes'){
                          controller.employee.value.isSupervisor = true;
                        }else{
                          controller.employee.value.isSupervisor = false;
                        }
                      },
                      selectedItem:  controller.employee.value.isSupervisor == true ? 'Yes' : 'No',
                      fontsize: 60,
                    ),),
              ]
          ),

        ),
        SizedBox(width: 40,),
        Container(
          width:1000.w,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Padding(
                  padding:  EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Employment Type',
                    size: 60.sp,
                    color: dark,
                    weight: FontWeight.bold,
                  ),
                ),
                Obx(() =>
                    DropDown(
                      context: context,
                      title: "Employment Type",
                      items: employmentType,
                      onChanged: (value) {
                        controller.employee.update((val) => val!.employmentType = value);
                      },
                      selectedItem:  controller.employee.value.employmentType==null ? 'Permanent' : controller.employee.value.employmentType!,
                      fontsize: 60,
                    ),),
              ]
          ),

        ),
        Field(
          context,
          'Employee ID',
          90,
          1000,
          'Employee ID',
          TextEditingController(text: controller.employee.value.employeeId),
              (value) => controller.employee.update((val) => val!.employeeId = value),
          fontsize: 60,
        ),

        SizedBox(width: 20.w,),
        Field(
          context,
          'Secondary Id',
          90,
          1000,
          'Secondary Id',
          TextEditingController(text: controller.employee.value.secondaryId),
              (value) => controller.employee.update((val) => val!.secondaryId = value),
          fontsize: 60,
        ),
        SizedBox(width: 20.w,),
        Field(
          context,
          'RFID',
          90,
          1000,
          'RFID',
          TextEditingController(text: controller.employee.value.rfid),
              (value) => controller.employee.update((val) => val!.rfid = value),
          fontsize: 60,
        ),
        Container(
          width:1000.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.all(8.w),
                child: CustomText(
                  text: 'Date of Birth',
                  size: 60.sp,
                  color: dark,
                  weight: FontWeight.bold,
                ),
              ),
              Obx(() =>  DateFiller(
                title: "Date of Birth",
                context: context,
                value: controller.DateofBirth.value.isNotEmpty ? controller.DateofBirth.value.toString().split(' ')[0] : 'Select', onChanged: () {
                controller.SelectDate(context, controller.DateofBirth);
              },
                fontsize: 60,

              ),),
            ],
          ),
        ),
        SizedBox(width: 20.w,),
        Container(
          width: 1000.w,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Padding(
                  padding:  EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Joining Date',
                    size: 60.sp,
                    color: dark,
                    weight: FontWeight.bold,
                  ),
                ),
                Obx(() =>
                    DateFiller(
                      title: "Joining Date",
                      context: context,
                      value: controller.DateofJoining.value.isNotEmpty ? controller.DateofJoining.value.toString().split(' ')[0] : 'Select', onChanged: () {
                      controller.SelectDate(context,controller.DateofJoining);
                    },
                      fontsize: 60,
                    ),),
              ]
          ),
        ),
        SizedBox(width: 30,),
        Container(
          width:1000.w,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Padding(
                  padding:  EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Languages Known',
                    size: 60.sp,
                    color: dark,
                    weight: FontWeight.bold,
                  ),
                ),
                Obx(() =>
                    DropDown(
                      context: context,
                      title: "Launguage Known",
                      items: languages,
                      onChanged: (value) {
                        controller.employee.update((val) => val!.languagesKnown = [value]);
                      },
                      selectedItem: controller.employee.value.languagesKnown==null?
                      'English':controller.employee.value.languagesKnown![0]!,
                      fontsize: 60,
                    ),),
              ]
          ),

        ),
        SizedBox(height: 10,),
        SizedBox(width: 20.w,),
        Field(
          context,
          'Address',
          90,
          1000,
          'Address',
          TextEditingController(text: controller.employee.value.address),
              (value) => controller.employee.update((val) => val!.address = value),
          fontsize: 60,
        ),

        SizedBox(width: 20.w,),
        Field(
          context,
          'City',
          90,
          1000,
          'City',
          TextEditingController(text: controller.employee.value.locality),
              (value) => controller.employee.update((val) => val!.locality = value),
          fontsize: 60,
        ),
        SizedBox(width: 20.w,),
        Field(
          context,
          'Latitude',
          90,
          150,
          'Latitude',
          TextEditingController(text: controller.employee.value.latitude),
              (value) => controller.employee.update((val) => val!.latitude = value),
          fontsize: 60,
        ),
        SizedBox(width: 20.w,),
        Field(
          context,
          'Longitude',
          90,
          150,
          'Longitude',
          TextEditingController(text: controller.employee.value.longitude),
              (value) => controller.employee.update((val) => val!.longitude = value)
          ,fontsize: 60,
        ),
        SizedBox(width: 20.w,),
        Padding(
          padding: const EdgeInsets.only(top :25.0),
          child: InkWell(
            onTap: (){
              controller.gotolocation(context);
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

        Container(
          width:1000.w,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Padding(
                  padding:  EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Pickup Reimbursement Zone',
                    size: 60.sp,
                    color: dark,
                    weight: FontWeight.bold,
                  ),
                ),
                Obx(() =>
                    DropDown(
                      context: context,
                      title: "Pickup Reimbursement Zone",
                      items: PickupList,
                      onChanged: (value) {
                        controller.employee.update((val) => val!.pickupReimbursementZone = [value]);
                        String? selectedId =  DropMap[value];
                        controller.employee.value.nodalPoint = selectedId!;
                        print("Selected ID: $selectedId");

                      },
                      selectedItem: controller.employee.value.pickupReimbursementZone==null ? 'Select' : controller.employee.value.pickupReimbursementZone![0]!,
                      fontsize: 60,
                    ),),
              ]
          ),

        ),
        SizedBox(width: 40,),
        Container(
          width:1000.w,

          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Padding(
                  padding:  EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Pickup Reimbursement Zone',
                    size: 60.sp,
                    color: dark,
                    weight: FontWeight.bold,
                  ),
                ),
                Obx(() =>
                    DropDown(
                      context: context,
                      title: "Drop Reimbursement Zone",
                      items: DropList,
                      onChanged: (value) {
                        controller.employee.update((val) => val!.dropReimbursementZone = [value]);

                      },
                      selectedItem:   controller.employee.value.dropReimbursementZone==null ? 'Select' : controller.employee.value.dropReimbursementZone![0]!,
                      fontsize: 60,
                    ),),
              ]
          ),

        )
      ],
    )
    ;
  }
}

