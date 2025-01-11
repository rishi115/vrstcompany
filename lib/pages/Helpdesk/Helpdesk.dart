import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vrsstranslinkcompany/pages/Helpdesk/HelpdeskController.dart';
import '../../constants/controllers.dart';
import '../../constants/responsiveness.dart';
import '../../constants/style.dart';
import '../../widgets/custom_text.dart';
import 'package:get/get.dart';

class Helpdesk extends GetView<HelpdeskController> {
  const Helpdesk({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpdeskController());
    return Column(
      children: [
        Obx(
              () => Row(
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
        const SizedBox(
          height: 35,
        ),
        Row(
          children: [
            SizedBox(
              width: 630,
              height: 50,
              child: TextField(
                onChanged: (value){
                  // controller.listFilter(value);
                },
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
            const SizedBox(
              width: 20,
            ),

            IconButton(icon: Image.asset('assets/FilterImage.png',width: 36,height: 36,), onPressed: () {  },),
            const SizedBox(
              width: 10,
            ),
            IconButton(icon: Image.asset('assets/Refresh.png',width: 36,height: 36,), onPressed: () {
              // controller.getAllEmployee();
            },),

            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: InkWell(
                onTap:
                // controller.loading.value ? null :
                    (){
                  // controller.addemployee(context);
                },
                child: Container(
                  decoration: BoxDecoration(color: active,
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  constraints:  const BoxConstraints(
                    maxWidth:430,
                  ),
                  height: 50,
                  child:  const CustomText(
                    text: "+ Register New Employee",
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          ],
        ),
        const SizedBox(
          height: 20,
        ),
        // Row(
        //   children: [
        //     SizedBox(
        //       width: 35.w,
        //     ),
        //     const CustomText(
        //       text: "Id",
        //       size: 14,
        //       weight: FontWeight.bold,
        //       color: lightGrey,
        //     ),
        //     SizedBox(
        //       width: 80.w,
        //     ),
        //     const CustomText(
        //       text: "created at",
        //       size: 14,
        //       weight: FontWeight.bold,
        //       color: lightGrey,
        //     ),
        //     SizedBox(
        //       width: 60.w,
        //     ),
        //     const CustomText(
        //       text: "time",
        //       size: 14,
        //       weight: FontWeight.bold,
        //       color: lightGrey,
        //     ),
        //     SizedBox(
        //       width: 30.w,
        //     ),
        //     const CustomText(
        //       text: "created by",
        //       size: 14,
        //       weight: FontWeight.bold,
        //       color: lightGrey,
        //     ),
        //     SizedBox(
        //       width: 60.w,
        //     ),
        //     const CustomText(
        //       text: "role",
        //       size: 14, weight: FontWeight.bold,
        //       color: lightGrey,
        //     ),
        //     SizedBox(
        //       width: 50.w,
        //     ),
        //
        //     const CustomText(
        //       text: "category",
        //       size: 14,
        //       weight: FontWeight.bold,
        //       color: lightGrey,
        //     ),
        //     SizedBox(
        //       width: 50.w,
        //     ),
        //     const CustomText(
        //       text: "priority",
        //       size: 14,
        //       weight: FontWeight.bold,
        //       color: lightGrey,
        //     ),
        //     SizedBox(
        //       width: 30.w,
        //     ),
        //     const CustomText(
        //       text: "locate",
        //       size: 14,
        //       weight: FontWeight.bold,
        //       color: lightGrey,
        //     ),
        //     SizedBox(
        //       width: 30.w,
        //     ),
        //     const CustomText(
        //       text: "assigned to",
        //       size: 14,
        //       weight: FontWeight.bold,
        //       color: lightGrey,
        //     ),
        //     SizedBox(
        //       width: 60.w,
        //     ),
        //     const CustomText(
        //       text: "resolved at",
        //       size: 14,
        //       weight: FontWeight.bold,
        //       color: lightGrey,
        //     ),
        //   ],
        // ),
        // Divider(),
        //  Obx(()=>
        //  Column(
        //    children: List.generate(controller.helpDeskList.length, (index) =>Row(
        //      children: [
        //        SizedBox(
        //          width: 15.w,
        //        ),
        //        SizedBox(
        //          width: 100.w,
        //          child:  CustomText(
        //            text:controller.helpDeskList[index].id?.substring(
        //                controller.helpDeskList[index].id!.length - 8
        //            ) ?? "",
        //            size: 14,
        //            weight: FontWeight.bold,
        //          ),
        //        ),
        //
        //        SizedBox(
        //          width: 120.w,
        //          child: CustomText(
        //            text: "Oct 07, 2024",
        //            size: 14,
        //            weight: FontWeight.bold,
        //          ),
        //        ),
        //
        //        SizedBox(
        //          width: 80.w,
        //          child: const CustomText(
        //            text: "09:15 AM",
        //            size: 14,
        //            weight: FontWeight.bold,
        //          ),
        //        ),
        //
        //        SizedBox(
        //          width: 100.w,
        //          child: CustomText(
        //            text: "John Doe",
        //            size: 14,
        //            weight: FontWeight.bold,
        //          ),
        //        ),
        //
        //        SizedBox(
        //          width: 100.w,
        //          child: CustomText(
        //            text: "Employee",
        //            size: 14, weight: FontWeight.bold,
        //          ),
        //        ),
        //        SizedBox(
        //          width: 95.w,
        //          child: const CustomText(
        //            text: "Vehicle",
        //            size: 14,
        //            weight: FontWeight.bold,
        //          ),
        //        ),
        //        SizedBox(
        //          width: 80.w,
        //          child: CustomText(
        //            text: "Medium",
        //            size: 14,
        //            weight: FontWeight.bold,
        //          ),
        //        ),
        //        SizedBox(
        //          width:  65.w,
        //          child: CustomText(
        //            text: "locate",
        //            size: 14,
        //            weight: FontWeight.bold,
        //          ),
        //        ),
        //        SizedBox(
        //          width: 130.w,
        //          child: CustomText(
        //            text: "Jack Sparrow",
        //            size: 14,
        //            weight: FontWeight.bold,
        //          ),
        //        ),
        //        SizedBox(
        //          width: 100.w,
        //          child: CustomText(
        //            text: "Oct 27, 2024",
        //            size: 14,
        //            weight: FontWeight.bold,
        //          ),
        //        ),
        //      ],
        //    ) ),
        //  )
        //  ),
        IssuesTable(),
      ],
    );
  }
}
class IssuesTable extends GetView<HelpdeskController> {
  @override
  Widget build(BuildContext context) {
    var issues = controller.helpDeskList;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Allow horizontal scrolling
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical, // Allow vertical scrolling
        child: Obx(()=>
        DataTable(
          columnSpacing: 40,
          headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Created At')),
            DataColumn(label: Text('Time')),
            DataColumn(label: Text('Created By')),
            DataColumn(label: Text('Role')),
            DataColumn(label: Text('Category')),
            DataColumn(label: Text('Priority')),
            DataColumn(label: Text('Locate')),
            DataColumn(label: Text('Assigned To')),
            DataColumn(label: Text('Resolved At')),
            DataColumn(label: Text('Status')),
          ],
          rows: issues.map((issue) {
            return DataRow(cells: [
              DataCell(Text(issue.id.toString())),
              DataCell(Text(issue.createdAt.toString())),
              DataCell(Text(issue.createdAt.toString().substring(11, 16))),
              DataCell(Text(issue.raisedBy!.name.toString())),
              DataCell(Text(issue.raisedBy!.role.toString())),
              DataCell(Text(issue.raisedBy!.company.toString())),
              DataCell(
                Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: _getPriorityColor(issue.priority.toString()),
                    ),
                    SizedBox(width: 5),
                    Text(issue.priority.toString()),
                  ],
                ),
              ),
              DataCell(Icon(Icons.location_on, color: Colors.teal)),
              DataCell(Text(issue.status.toString())),
              DataCell(Text("9:30 Am")),
              DataCell(Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(issue.status.toString()),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  issue.status.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              )),
            ]);
          }).toList(),
        ),
        )
      ),
    );
  }

  // Function to determine priority color
  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // Function to determine status background color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Ongoing':
        return Colors.orange;
      case 'Resolved':
        return Colors.teal;
      case 'Unattended':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }
}
