import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/Model/VehicleModel.dart';
import 'package:vrsstranslinkcompany/pages/RoasterPage/RoasterController/RoasterController.dart';

import '../../../constants/style.dart';
import '../../../widgets/ShimmerEfflect.dart';
import '../../../widgets/custom_text.dart';


class RoastersWidget extends GetView<RoasterController> {
  const RoastersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> showVehicleDialog(
        BuildContext context,
        List<VehicleCapacity> vehicles,
        ) async {
      final screenWidth = MediaQuery.of(context).size.width;
      final selectedVehicleId = controller.isSelectedVehicle;

      TextEditingController searchController = TextEditingController();

      int getTotalCapacity() {
        controller.selectedVehicleCapacity.value = vehicles
            .where((v) => selectedVehicleId.contains(v.id))
            .fold(0, (sum, v) => sum + (v.vehicleCapacity ?? 0));
        return controller.selectedVehicleCapacity.value;
      }

      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              width: screenWidth * 0.6,
              constraints: BoxConstraints(maxHeight: 520),
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                final filteredVehicles = vehicles.where((v) {
                  final query = searchController.text.toLowerCase();
                  return v.vehicleModel?.toLowerCase().contains(query) ?? false;
                }).toList();

                return Column(
                  children: [
                    // Title Row
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Select Vehicles",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text("Required capacity: "),
                        Text(
                          "${controller.roasterTotal.value} / ${getTotalCapacity()}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            for (var v in vehicles) {
                              if (!selectedVehicleId.contains(v.id)) {
                                selectedVehicleId.add(v.id!);
                              }
                            }
                          },
                          child: Text(
                            "Select All",
                            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Search Bar
                    TextField(
                      controller: searchController,
                      onChanged: (_) => controller.update(),
                      decoration: InputDecoration(
                        hintText: 'Search by vehicle name',
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Table Header
                    Row(
                      children: const [
                        Expanded(child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 2, child: Text('Vehicle Name', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Capacity', style: TextStyle(fontWeight: FontWeight.bold))),
                        SizedBox(width: 24),
                      ],
                    ),
                    Divider(),

                    // Vehicle List
                    Expanded(
                      child: ListView.separated(
                        itemCount: filteredVehicles.length,
                        separatorBuilder: (_, __) => SizedBox(height: 4),
                        itemBuilder: (context, index) {
                          final v = filteredVehicles[index];
                          final isSelected = selectedVehicleId.contains(v.id);

                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.teal[100] : Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(child: Text('${v.id}', style: TextStyle(fontSize: 13))),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    v.vehicleModel ?? 'N/A',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                Expanded(
                                  child: Text('${v.vehicleCapacity ?? 0}',
                                      style: TextStyle(fontSize: 13)),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (isSelected) {
                                      selectedVehicleId.remove(v.id);
                                    } else {
                                      selectedVehicleId.add(v.id!);
                                    }
                                  },
                                  icon: Icon(
                                    isSelected ? Icons.close : Icons.add,
                                    size: 18,
                                    color: isSelected ? Colors.red : Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Bottom Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Capacity: ${getTotalCapacity()}",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            Text("Total Roster: ${controller.roasterTotal.value}",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('CANCEL', style: TextStyle(color: Colors.red)),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                if (controller.selectedVehicleCapacity.value <
                                    controller.roasterTotal.value) {
                                  Get.snackbar('Error', 'Capacity is less than roaster');
                                  return;
                                }
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              ),
                              child: const Text('CONFIRM',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          );
        },
      );
    }




    return Padding(
      padding:  EdgeInsets.all(15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Spacer(),
              const CustomText(text: "Rosters",
                size: 14,
                weight: FontWeight.w400,
                color: active,
              ),
              VerticalDivider(),
              Obx(() {
                if (!controller.hasRoute.value) return const SizedBox.shrink();

                return TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/routes'),
                  style: TextButton.styleFrom(
                    minimumSize: Size(80.w, 32.h), // Small size
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    backgroundColor: Colors.blue.shade50,
                    foregroundColor: Colors.blue.shade700,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      side: BorderSide(color: Colors.blue.shade300),
                    ),
                  ),
                  child: Text(
                    "Has Routes",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }),


            ],
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _HeaderCell("Employee ID", width: 100.w),
                _vDivider(),

                _HeaderCell("Name", width: 170.w),
                _vDivider(),

                _HeaderCell("Gender", width: 140.w),
                _vDivider(),

                _HeaderCell("Contact", width: 170.w),
                _vDivider(),

                _HeaderCell("Nodal Point", width: 220.w),
                _vDivider(),

                _HeaderCell("Actions", width: 60.w),
              ],
            ),
          ),
          const Divider(),
          Obx(() => controller.loading.value
              ? ShimmerList(
            width: 0.8.sw,
            height: 0.5.sh,
          )
              : SizedBox(
            height: 550.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(
                  controller.Rxroasters.value.rosters?.length ?? 0,
                      (index) {
                    final current = controller.Rxroasters.value.rosters![index];
                    return Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _CellText(current.employee?.substring(current.employee!.length - 4) ?? "-", width: 100.w),
                              _vDivider(),

                              _CellText(current.employeeName ?? "-", width: 170.w),
                              _vDivider(),

                              _CellText(current.employeeGender ?? "-", width: 140.w),
                              _vDivider(),

                              _CellText(current.employeeContactNumber ?? "-", width: 170.w),
                              _vDivider(),

                              _CellText(current.nodalPointName ?? "-", width: 220.w),
                              _vDivider(),

                              Container(
                                width: 100.w,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (current.disability == "no")
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.w),
                                        child: Image.asset(
                                          "assets/DisabilityIcon.png",
                                          width: 24.w,
                                          height: 24.h,
                                        ),
                                      ),
                                    Tooltip(
                                      message: 'Switch Location to home Location',
                                      child: IconButton(
                                        icon: const Icon(Icons.home, color: Colors.red, size: 18),
                                        onPressed: () => controller.switchBetweenNodalAndHome(current.id!),
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Delete',
                                      child: IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red, size: 18),
                                        onPressed: () => controller.deleteRoaster(current.id!),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        const Divider(thickness: 0.8),
                      ],
                    );
                  },
                ),
              ),
            ),
          )

          ),
          Row(
            children: [
              Spacer(),
              Center(
                child: InkWell(
                  onTap: () async {
                    controller.roasterTotal.value = controller.Rxroasters.value.rosters?.length ?? 0 ;

                      // Step 1: Check if any vehicle is selected
                      if (controller.selectedVehicleCapacity.value == 0) {
                       await  showVehicleDialog(context, controller.vehicleList ?? []);
                      }

                      if (controller.roasterTotal.value==0) {
                        Get.snackbar("Error", "Please add roasters before making routes.",duration: const Duration(seconds: 1));
                        return;
                      }
                      if (controller.selectedVehicleCapacity.value == 0) {
                        Get.snackbar("Error", "Please select a vehicle.",duration: const Duration(seconds: 1));
                        return;
                      }

                      // Step 3: Capacity check
                      if (controller.roasterTotal.value > controller.selectedVehicleCapacity.value) {
                        Get.snackbar("Error", "Selected vehicle capacity is less than total roaster.",duration: const Duration(seconds: 1));
                        await showVehicleDialog(context, controller.vehicleList ?? []);
                        return;
                      }

                      // Step 4: All good → proceed to loading and API calls
                      Navigator.pushNamed(context, '/loading');
                      await controller.routeNow();
                      await controller.getRoaster();

                      if (controller.hasRoute.value) {
                        controller.selectedVehicleCapacity.value = 0; // Reset capacity after successful route creation
                        Navigator.pushNamed(context, "/routes");

                      } else {
                        Get.snackbar("Error", "Failed to create routes. Please try again.",duration: const Duration(seconds: 1));
                        controller.selectedVehicleCapacity.value = 0;
                        Navigator.pop(context); // Close loader if there's an error
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
Widget _CellText(String text, {required double width}) {
  return Container(
    width: width,
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 13.sp, color: Colors.black87),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _vDivider() {
  return VerticalDivider(
    thickness: 1,
    width: 1,
    color: Colors.grey.shade300,
  );
}
Widget _HeaderCell(String text, {required double width}) {
  return Container(
    width: width,
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.sp,
        color: Colors.black87,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

