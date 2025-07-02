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
import '../../NodalPoint/predictionField.dart';


class AddEmployeeLarge extends StatefulWidget {
  const AddEmployeeLarge({super.key});

  @override
  State<AddEmployeeLarge> createState() => _AddEmployeeLargeState();
}

class _AddEmployeeLargeState extends State<AddEmployeeLarge> {
  final controller = Get.find<EmployeeController>();
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  LatLng initialPosition = LatLng(19.13882698246765, 73.00576897485509);
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
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    initialPosition = position;
    setState(() {});
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
                  infoWindow: InfoWindow(title: location),
                ));
              });
            }
          }
        }
      }
    } catch (e) {
      print("Geocoding Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> gender = ['Male', 'Female', 'Other'];
    List<String> categories = ['Driver', 'Helper', 'Admin', 'Manager', 'Supervisor', 'Other'];
    List<String> employmentType = ['Permanent', 'Temporary', 'Contract', 'Other'];
    List<String> isSupervisorlist = ['Yes', 'No', 'Other'];
    List<String> languages = ['English', 'Hindi', 'Tamil', 'Telugu', 'Kannada', 'Malayalam', 'Other'];

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

    List<String> PickupList = PickupMap.keys.toList();
    List<String> DropList = DropMap.keys.toList();

    Widget _buildReimbursementInfoFields(List<String> PickupList, List<String> DropList,
        List<String> officeListMap, Map<String, String> officeMap) {
      return Wrap(
        spacing: 20.w,
        runSpacing: 16.h,
        children: [
          // Pickup Reimbursement Zone
          SizedBox(
            width: 300.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Pickup Reimbursement Zone',
                    size: 15.sp,
                    color: dark,
                    weight: FontWeight.bold,
                  ),
                ),
                Obx(() => DropDown(
                  context: context,
                  title: "Pickup Reimbursement Zone",
                  items: PickupList,
                  onChanged: (value) {
                    controller.employee.update((val) => val!.pickupReimbursementZone = [value]);
                  },
                  selectedItem: controller.employee.value.pickupReimbursementZone == null ?
                  'Select' : controller.employee.value.pickupReimbursementZone![0]!,
                )),
              ],
            ),
          ),

          // Drop Reimbursement Zone
          SizedBox(
            width: 300.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Drop Reimbursement Zone',
                    size: 15.sp,
                    color: dark,
                    weight: FontWeight.bold,
                  ),
                ),
                Obx(() => DropDown(
                  context: context,
                  title: "Drop Reimbursement Zone",
                  items: DropList,
                  onChanged: (value) {
                    controller.employee.update((val) => val!.dropReimbursementZone = [value]);
                    String? selectedId = DropMap[value];
                    controller.nodalPointId.value = selectedId!;
                    print("Selected ID: $selectedId");
                  },
                  selectedItem: controller.employee.value.dropReimbursementZone == null ?
                  'Select' : controller.employee.value.dropReimbursementZone![0]!,
                )),
              ],
            ),
          ),

          // Office
          SizedBox(
            width: 300.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Office*',
                    size: 15.sp,
                    color: dark,
                    weight: FontWeight.bold,
                  ),
                ),
                Obx(() => Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: DropDown(
                    fontsize: 15,
                    context: context,
                    title: "Select Office*",
                    items: officeListMap,
                    onChanged: (value) {
                      controller.employee.value.office = officeMap[value]!;
                      controller.officeName.value = value!;
                    },
                    selectedItem: controller.officeName.value == '' ?
                    'Select' : controller.officeName.value,
                  ),
                )),
              ],
            ),
          ),
        ],
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("Personal Information"),
            SizedBox(height: 16),
            _buildPersonalInfoFields(gender, languages),
            SizedBox(height: 24),

            // Contact Information Section
            _buildSectionHeader("Contact Information"),
            SizedBox(height: 16),
            _buildContactInfoFields(),
            SizedBox(height: 24),

            // Employment Information Section
            _buildSectionHeader("Employment Information"),
            SizedBox(height: 16),
            _buildEmploymentInfoFields(categories, employmentType, isSupervisorlist),
            SizedBox(height: 24),

            // Address Information Section
            _buildSectionHeader("Address Information"),
            SizedBox(height: 16),
            _buildAddressInfoFields(),
            SizedBox(height: 16),

            // Map Section
            _buildMapSection(),
            SizedBox(height: 24),

            // Reimbursement Information Section
            _buildSectionHeader("Reimbursement Information"),
            SizedBox(height: 16),
            _buildReimbursementInfoFields(PickupList, DropList, officeListMap, officeMap),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade800,
      ),
    );
  }

  Widget _buildPersonalInfoFields(List<String> gender, List<String> languages) {
    return Wrap(
      spacing: 20.w,
      runSpacing: 16.h,
      children: [
        // Name Fields
        Field(
          context,
          'First Name*',
          90,
          250,
          'First Name*',
          TextEditingController(text: controller.employee.value.firstName),
              (value) => controller.employee.update((val) => val!.firstName = value),
        ),
        Field(
          context,
          'Middle Name',
          90,
          250,
          'Middle Name',
          TextEditingController(text: controller.employee.value.middleName),
              (value) => controller.employee.update((val) => val!.middleName = value),
        ),
        Field(
          context,
          'Last Name*',
          90,
          250,
          'Last Name*',
          TextEditingController(text: controller.employee.value.lastName),
              (value) => controller.employee.update((val) => val!.lastName = value),
        ),

        // Gender Dropdown
        SizedBox(
          width: 250.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: CustomText(
                  text: 'Gender*',
                  size: 15.sp,
                  color: dark,
                  weight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:12.0),
                child: Obx(() => DropDown(
                  context: context,
                  title: "Gender*",
                  items: gender,
                  onChanged: (value) {
                    controller.employee.update((val) => val?.gender = value);
                  },
                  selectedItem: controller.employee.value.gender == null ?
                  'Male' : controller.employee.value.gender!,
                )),
              ),
            ],
          ),
        ),

        // Date of Birth
        SizedBox(
          width: 250.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: CustomText(
                  text: 'Date of Birth*',
                  size: 15.sp,
                  color: dark,
                  weight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:12.0),
                child: Obx(() => DateFiller(
                  title: "Date of Birth*",
                  context: context,
                  value: controller.DateofBirth.value.isNotEmpty ?
                  controller.DateofBirth.value.toString().split(' ')[0] : 'Select',
                  onChanged: () {
                    controller.SelectDate(context, controller.DateofBirth);
                  },
                )),
              ),
            ],
          ),
        ),

        // Age
        Field(
          context,
          'Age*',
          90,
          250,
          'Age*',
          TextEditingController(text: controller.employee.value.age),
              (value) => controller.employee.update((val) => val!.age = value),
        ),

        // Languages Known
        SizedBox(
          width: 250.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: CustomText(
                  text: 'Languages Known',
                  size: 15.sp,
                  color: dark,
                  weight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:12.0),
                child: Obx(() => DropDown(
                  context: context,
                  title: "Language Known",
                  items: languages,
                  onChanged: (value) {
                    controller.employee.update((val) => val!.languagesKnown = [value]);
                  },
                  selectedItem: controller.employee.value.languagesKnown == null ?
                  'English' : controller.employee.value.languagesKnown![0]!,
                )),
              ),
            ],
          ),
        ),

        // Disability
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
    );
  }

  Widget _buildContactInfoFields() {
    return Wrap(
      spacing: 20.w,
      runSpacing: 16.h,
      children: [
        Field(
          context,
          'Primary Contact*',
          90,
          250,
          'Primary Contact*',
          TextEditingController(text: controller.employee.value.contactNumber),
              (value) => controller.employee.update((val) => val!.contactNumber = value),
        ),
        Field(
          context,
          'Secondary Contact',
          90,
          250,
          'Secondary Contact',
          TextEditingController(text: controller.employee.value.secondaryContactNumber),
              (value) => controller.employee.update((val) => val!.secondaryContactNumber = value),
        ),
        Field(
          context,
          'Email*',
          90,
          250,
          'Email*',
          TextEditingController(text: controller.employee.value.email),
              (value) => controller.employee.update((val) => val!.email = value),
        ),
      ],
    );
  }

  Widget _buildEmploymentInfoFields(List<String> categories, List<String> employmentType, List<String> isSupervisorlist) {
    return Wrap(
      spacing: 20.w,
      runSpacing: 16.h,
      children: [
        // Employee ID Fields
        Field(
          context,
          'Employee ID*',
          90,
          250,
          'Employee ID*',
          TextEditingController(text: controller.employee.value.employeeId),
              (value) => controller.employee.update((val) => val!.employeeId = value),
        ),
        Field(
          context,
          'Secondary Id',
          90,
          250,
          'Secondary Id',
          TextEditingController(text: controller.employee.value.secondaryId),
              (value) => controller.employee.update((val) => val!.secondaryId = value),
        ),
        Field(
          context,
          'RFID*',
          90,
          250,
          'RFID*',
          TextEditingController(text: controller.employee.value.rfid),
              (value) => controller.employee.update((val) => val!.rfid = value),
        ),

        // Employment Type
        SizedBox(
          width: 250.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: CustomText(
                  text: 'Employment Type',
                  size: 15.sp,
                  color: dark,
                  weight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:12.0),                child: Obx(() => DropDown(
                  context: context,
                  title: "Employment Type",
                  items: employmentType,
                  onChanged: (value) {
                    controller.employee.update((val) => val!.employmentType = value);
                  },
                  selectedItem: controller.employee.value.employmentType == null ?
                  'Permanent' : controller.employee.value.employmentType!,
                )),
              ),
            ],
          ),
        ),

        // Category
        SizedBox(
          width: 250.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: CustomText(
                  text: 'Category',
                  size: 15.sp,
                  color: dark,
                  weight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:12.0),                child: Obx(() => DropDown(
                  context: context,
                  title: "Category",
                  items: categories,
                  onChanged: (value) {
                    controller.employee.update((val) => val!.category = [value]);
                  },
                  selectedItem: controller.employee.value.category == null ?
                  'Driver' : controller.employee.value.category![0]!,
                )),
              ),
            ],
          ),
        ),

        // Joining Date
        SizedBox(
          width: 250.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: CustomText(
                  text: 'Joining Date*',
                  size: 15.sp,
                  color: dark,
                  weight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:12.0),                child: Obx(() => DateFiller(
                  title: "Joining Date*",
                  context: context,
                  value: controller.DateofJoining.value.isNotEmpty ?
                  controller.DateofJoining.value.toString().split(' ')[0] : 'Select',
                  onChanged: () {
                    controller.SelectDate(context, controller.DateofJoining);
                  },
                )),
              ),
            ],
          ),
        ),

        // Supervisor Fields
        Field(
          context,
          'Supervisor Name',
          90,
          250,
          'Supervisor Name',
          TextEditingController(text: controller.employee.value.supervisorName),
              (value) => controller.employee.update((val) => val!.supervisorName = value),
        ),

        // Is Supervisor
        SizedBox(
          width: 250.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: CustomText(
                  text: 'Is Supervisor',
                  size: 15.sp,
                  color: dark,
                  weight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:12.0),                child: Obx(() => DropDown(
                  context: context,
                  title: "Is Supervisor",
                  items: isSupervisorlist,
                  onChanged: (value) {
                    if (value == 'Yes') {
                      controller.employee.value.isSupervisor = true;
                    } else {
                      controller.employee.value.isSupervisor = false;
                    }
                  },
                  selectedItem: controller.employee.value.isSupervisor == true ?
                  'Yes' : 'No',
                )),
              ),
            ],
          ),
        ),

        // Transport Inactive Date
        SizedBox(
          width: 250.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: CustomText(
                  text: 'Transport Inactive Date',
                  size: 15.sp,
                  color: dark,
                  weight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:12.0),                child: Obx(() => DateFiller(
                  title: "Transport Inactive Date",
                  context: context,
                  value: controller.TransportInactiveday.value.isNotEmpty ?
                  controller.TransportInactiveday.value.toString().split(' ')[0] : 'Select',
                  onChanged: () {
                    controller.SelectDate(context, controller.TransportInactiveday);
                  },
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddressInfoFields() {
    return Wrap(
      spacing: 20.w,
      runSpacing: 16.h,
      children: [
        SizedBox(
          width: 400.w,
          child: AddressField(
            controller: TextEditingController(text: controller.employee.value.address),
            onChanged: (value) {
              controller.employee.value.address = value;
            },
          ),
        ),
        Field(
          context,
          'City',
          90,
          250,
          'City',
          TextEditingController(text: controller.employee.value.locality),
              (value) => controller.employee.update((val) => val!.locality = value),
        ),
        Field(
          context,
          'Latitude*',
          90,
          150,
          'Latitude*',
          TextEditingController(text: controller.employee.value.latitude),
              (value) => controller.employee.update((val) => val!.latitude = value),
        ),
        Field(
          context,
          'Longitude*',
          90,
          150,
          'Longitude*',
          TextEditingController(text: controller.employee.value.longitude),
              (value) => controller.employee.update((val) => val!.longitude = value),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: InkWell(
            onTap: () async {
              await controller.getLatLngFromAddress(controller.employee.value.address!);
              _addMarker(LatLng(
                  double.parse(controller.latitude.value),
                  double.parse(controller.longitude.value)
              ));
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(
                        double.parse(controller.latitude.value),
                        double.parse(controller.longitude.value)
                    ),
                    zoom: 14.0,
                  ),
                ),
              );
            },
            child: Container(
              width: 150.w,
              decoration: BoxDecoration(
                  color: active,
                  borderRadius: BorderRadius.circular(10)
              ),
              alignment: Alignment.center,
              constraints: const BoxConstraints(maxWidth: 150),
              height: 40,
              child: const CustomText(
                text: "Map",
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Location",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: dark,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 300.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              markers: markers,
              initialCameraPosition: CameraPosition(
                target: initialPosition,
                zoom: 14.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              onTap: (LatLng latLng) {
                _onMapTapped(latLng);
              },
            ),
          ),
        ),
      ],
    );
  }



}

