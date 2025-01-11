import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vrsstranslinkcompany/constants/controllers.dart';
import 'package:vrsstranslinkcompany/constants/style.dart';
import 'package:vrsstranslinkcompany/pages/Trips/TripController/TripController.dart';
import 'package:vrsstranslinkcompany/widgets/Button.dart';
import 'package:vrsstranslinkcompany/widgets/custom_text.dart';
import 'package:get/get.dart';
import '../../constants/responsiveness.dart';

class TripsScreen extends GetView<TripController> {
  TripsScreen({Key? key}) : super(key: key);
  tripRow({
    required String driver,
    required String vehicleModel,
    required String startTime,
    required String endTime,
    required String profile,
    required String status,
    required String employee
  }) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      color: background,
      child: Row(
        children: [
          Expanded(
            // flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Driver",
                      style: TextStyle(
                        fontSize: 12.sp,
                      )
                  ),
                  Text(
                    "$driver",
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  )
                ],
              )
          ),

          SizedBox(
            width: 10.w,
          ),

          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vehicle model",
                    style: TextStyle(
                      fontSize: 12.sp,),
                  ),
                  Text(
                    "$vehicleModel",
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  )
                ],
              )
          ),
          SizedBox(
            width: 10.w,
          ),

          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Employee",
                    style: TextStyle(
                      fontSize: 12.sp,),
                  ),
                  Text(
                    employee,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  )
                ],
              )
          ),

          SizedBox(
            width: 10.w,
          ),

          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Start time",
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    "$startTime",
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  )
                ],
              )
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "End time",
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    "$endTime",
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  )
                ],
              )
          ),

          SizedBox(
            width: 10.w,
          ),
          Row(
            children: [
              Image.asset(
                  "assets/profile.png",
                  width: 30,
                  height: 30
              ),

              SizedBox(
                width: 10,
              ),

              Text(
                "$profile",
                style: TextStyle(
                  color: lightGrey,
                  fontSize: 14.sp,
                ),
              )
            ],
          ),
          SizedBox(
            width: 10.w,
          ),

          Row(
            children: [
              Container(
                width: 6.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: active,
                  shape: BoxShape.circle,
                ),
              ),

              SizedBox(
                width: 5.w,
              ),

              Text(
                "$status",
                style: TextStyle(
                  color: active,
                  fontSize: 10.sp,
                ),
              )
            ],
          )

        ],
      ),
    );
  }
  final List<Map<String, dynamic>> trips = [
    {
      "tripName": "Morning Trip A",
      "tripDetails": {
        "tripId": "T0897989879789870",
        "date": "2024-12-25",
        "isGuard": true,
        "employeeCapacity": 3,
        "approxStartTime": "07:00 AM",
        "realStartTime": "07:10 AM",
        "approxEndTime": "09:00 AM",
        "realEndTime": "09:05 AM",
        "tripType": "One-way",
        "driverName": "David Williams",
        "vehicleNumber": "ABC1234",
        "ota": "08:00 AM",
        "otd": "08:15 AM",
      },
      "employees": [
        {
          "employeeId": "E87990",
          "name": "John  Doe",
          "phone": "1234567890",
          "nodalName": "kalyan mumbai india ",
          "otp": "1234",
          "pickupTime": "08:00 AM",
          "approxPickupTime": "07:50 AM",
          "status": "On Time"
        },
        {
          "employeeId": "E002",
          "name": "Jane Smith",
          "phone": "0987654321",
          "nodalName": "Node B",
          "otp": "5678",
          "pickupTime": "08:30 AM",
          "approxPickupTime": "08:20 AM",
          "status": "Delayed"
        },
      ]
    },
    {
      "tripName": "Evening Trip B",
      "tripDetails": {
        "tripId": "T002",
        "date": "2024-12-25",
        "isGuard": false,
        "employeeCapacity": 2,
        "approxStartTime": "05:00 PM",
        "realStartTime": "05:10 PM",
        "approxEndTime": "07:00 PM",
        "realEndTime": "07:05 PM",
        "tripType": "Round-trip",
        "driverName": "Alice Brown",
        "vehicleNumber": "XYZ5678",
        "ota": "06:00 PM",
        "otd": "06:10 PM",
      },
      "employees": [
        {
          "employeeId": "E003",
          "name": "Alice Brown",
          "phone": "1112223333",
          "nodalName": "Node C",
          "otp": "9101",
          "pickupTime": "06:00 PM",
          "approxPickupTime": "05:50 PM",
          "status": "On Time"
        }
      ]
    },
  ];
  Widget buildTripDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
  openContainer(
      {required Map<String, dynamic> trip}
      ){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:  MainAxisAlignment.start,
                children: [
                  Text("Employees", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text("Employee ID")),
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Phone")),
                        DataColumn(label: Text("Node")),
                        DataColumn(label: Text("Pickup Time")),
                        DataColumn(label: Text("Approx Time")),
                        DataColumn(label: Text("Status")),
                      ],
                      rows: trip["employees"].map<DataRow>((employee) {
                        return DataRow(cells: [
                          DataCell(Text(employee["employeeId"])),
                          DataCell(Text(employee["name"])),
                          DataCell(Text(employee["phone"])),
                          DataCell(Text(employee["nodalName"])),
                          DataCell(Text(employee["pickupTime"])),
                          DataCell(Text(employee["approxPickupTime"])),
                          DataCell(Text(employee["status"])),
                        ]);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16),
          // Trip Details on the right
          Container(
            width: 250,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Trip Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                buildTripDetailRow("Trip ID", trip["tripDetails"]["tripId"]),
                buildTripDetailRow("Date", trip["tripDetails"]["date"]),
                buildTripDetailRow("Is Guard", trip["tripDetails"]["isGuard"].toString()),
                buildTripDetailRow("Capacity", trip["tripDetails"]["employeeCapacity"].toString()),
                buildTripDetailRow("Approx Start Time", trip["tripDetails"]["approxStartTime"]),
                buildTripDetailRow("Real Start Time", trip["tripDetails"]["realStartTime"]),
                buildTripDetailRow("Approx End Time", trip["tripDetails"]["approxEndTime"]),
                buildTripDetailRow("Real End Time", trip["tripDetails"]["realEndTime"]),
                buildTripDetailRow("Trip Type", trip["tripDetails"]["tripType"]),
                buildTripDetailRow("Driver Name", trip["tripDetails"]["driverName"]),
                buildTripDetailRow("Vehicle No.", trip["tripDetails"]["vehicleNumber"]),
                buildTripDetailRow("OTA", trip["tripDetails"]["ota"]),
                buildTripDetailRow("OTD", trip["tripDetails"]["otd"]),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top : ResponsiveWidget.isSmallScreen(context) ? 56 : 13),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                    color: dark,
                  )
              )
            ],
          )
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            children: [
              SizedBox(
                width: 435,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Driver name',
                    hintStyle: const TextStyle(color: lightGrey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.only(right:10.0),
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
                width: 10,
              ),
              IconButton(icon: Image.asset('assets/Refresh.png',width: 36,height: 36,), onPressed: () {
                controller.getTripByCompanyId();
              },),
              Padding(
                padding:  EdgeInsets.all(18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        controller.selectDate(context);
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
                                        Obx(()=>
                                            CustomText(
                                              text :controller.selectedDate.value !=null ? controller.selectedDate.value.toString().split(' ')[0] : 'Select',
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
            ],
          ),

          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            //height: 820.h,
            decoration: BoxDecoration(
              color: light,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "All trips",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,

                          ),
                        ),

                        SizedBox(
                          width: 207.w,
                          height: 55.h,
                          child: Button("EXPORT AS CSV", 207, 14, 40),
                        )
                      ],
                    ),
                  ),
                  Obx(() => controller.loading.value
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                    width: double.infinity,
                    height: 700.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 8.h),
                      itemCount: controller.tripList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.toggleContainer(index);  // Toggle the container visibility
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: tripRow(
                                  driver: '${controller.tripList[index].driverName}',
                                  vehicleModel: controller.tripList[index].vehicleNumber ?? "",
                                  startTime: controller.tripList[index].approxStartTime ?? "",
                                  endTime: controller.tripList[index].approxEndTime ?? "",
                                  profile: controller.tripList[index].listOfEmployees.length.toString(),
                                  status: controller.tripList[index].status ?? "",
                                  employee: controller.tripList[index].listOfEmployees.isNotEmpty
                                      ? controller.tripList[index].listOfEmployees.first.employeeName ?? ""
                                      : "No Employee",
                                ),
                              ),
                            ),
                            if (controller.openContainer.contains(index))
                              openContainer(trip: controller.tripList[index].toJson())
                          ],
                        );
                      },
                    ),
                  ),
                  )

                ]
            ),
          ),

        ],
      ),
    );
  }
}