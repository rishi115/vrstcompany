import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vrsstranslinkcompany/pages/Report/ReportController/ReportController.dart';
import '../../constants/controllers.dart';
import '../../constants/responsiveness.dart';
import '../../constants/style.dart';
import '../../widgets/custom_text.dart';

class ReportPage extends GetView<ReportController> {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        SizedBox(
          height: 10.h,
        ),
        const ReportUI(),
      ],
    ),
    );
  }
}


class ReportUI extends GetView<ReportController> {
  const ReportUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding:  EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            title: 'Generate Trips Report Excel',
            showTripType: true,
            showStatus: true,
            showButtons: true,
            tripDate: controller.tripStartDate,
            tripEndDate: controller.tripEndDate,
            context: context,
          ),
          SizedBox(height: 20.0),
          _buildSection(
            title: 'Generate Employee Excel',
            showStatus: true,
            context: context,
            tripDate: controller.employeeStartDate,
            tripEndDate: controller.employeeEndDate,
          ),
          const SizedBox(height: 16.0),
          _buildSection(
            title: 'Generate Routes Excel',
            showTripType: true,
            context: context,
            tripDate: controller.routeStartDate,
            tripEndDate: controller.routeEndDate,
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    bool showTripType = false,
    bool showStatus = false,
    bool showButtons = false,
    required RxString tripDate,
    required RxString tripEndDate,
    required BuildContext context,
  }) {
    List<String> Triptype = ["login", "logout"];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      padding:  EdgeInsets.all(16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(child: _buildDatePicker(label: 'From', datePicked:tripDate ,context: context)),
              SizedBox(width: 18.w),
              Expanded(child: _buildDatePicker(label: 'To', datePicked: tripEndDate,context: context )),
              if (showTripType) ...[
                SizedBox(width: 18.w),
                Expanded(child: _buildDropdown(label: 'Trip Type',
                    list: Triptype)),
              ],
              if (showStatus) ...[
                SizedBox(width: 18.w),
                Expanded(child: _buildDropdown(label: 'Status'
                    , list: ["Active", "Inactive"])),
              ],
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              if (showButtons) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        if(
                        tripDate.value.isNotEmpty && tripEndDate.value.isNotEmpty && controller.tripType.value.isNotEmpty && controller.status.value.isNotEmpty){
                          controller.excelOfTrips();
                        }else{
                          Get.snackbar(
                              "Error","Please Fill All Fields"
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(color: active,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        constraints:  const BoxConstraints(
                          maxWidth:330,
                        ),
                        height:45,
                        child:  const CustomText(
                          text: "Trips Per Employee",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        if(
                        tripDate.value.isNotEmpty && tripEndDate.value.isNotEmpty && controller.tripType.value.isNotEmpty && controller.status.value.isNotEmpty){
                          controller.excelOfTrips();
                        }else{
                          Get.snackbar(
                            "Error","Please Fill All Fields"
                          );
                        }
                        },
                      child: Container(
                        decoration: BoxDecoration(color: active,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        constraints:  const BoxConstraints(
                          maxWidth:330,
                        ),
                        height:45,
                        child:  const CustomText(
                          text: "only Trips",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ] else
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        if(
                        tripDate.value.isNotEmpty && tripEndDate.value.isNotEmpty && controller.tripType.value.isNotEmpty && controller.status.value.isNotEmpty){
                          controller.excelOfTrips();
                        }else{
                          Get.snackbar(
                              "Error","Please Fill All Fields"
                          );
                        }

                      },
                      child: Container(
                        decoration: BoxDecoration(color: active,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        constraints:  const BoxConstraints(
                          maxWidth:330,
                        ),
                        height:45,
                        child:  const CustomText(
                          text: "Get Report",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'RESET',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker({required String label,required RxString datePicked,required BuildContext context
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: 75.h,
      child: Row(
        children: [
          SizedBox(width: 8.h),
          Icon(Icons.calendar_today, color: Colors.grey),
          const SizedBox(width: 8.0),
          Text(label),
          const Spacer(),

          Obx(()=>TextButton(
            onPressed: () {
              controller.SelectDate(context, datePicked);
            },
            child: datePicked.value.isEmpty
                ? const Text('Select Date')
                : Text(datePicked.value.split(
                ' ')[0].toString().split('-').join('-'
            )),
          ),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }

  Widget _buildDropdown({required String label,required List<String> list}
      ) {
    return SizedBox(
      height: 75.h,
      child: DropdownButtonFormField<String>(
        selectedItemBuilder: (context) {
          return list.map<Widget>((String item) {
            return Text(item);
          }).toList();
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: list
            .map((e) => DropdownMenuItem<String>(
          value: e,
          child: Text(e),
        ))
            .toList(),
        onChanged: (value) {},
      ),
    );
  }
}
