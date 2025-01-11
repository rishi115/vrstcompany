import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/pages/Setting/AddGuard.dart';
import 'package:vrsstranslinkcompany/pages/Setting/AddOffice.dart';
import 'package:vrsstranslinkcompany/pages/Setting/SettingController/SettingController.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../constants/responsiveness.dart';
import '../../widgets/Button.dart';
import '../../widgets/custom_text.dart';


class Settings extends GetView<SettingController> {
  Settings({super.key});

  @override
  Widget build(BuildContext context) {
    void showMyDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text('Add New Shift'),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListBody(
                children: <Widget>[
                  CustomText(text: "Login Time"),
                  Padding(
                    padding: EdgeInsets.all(18.w),
                    child:InkWell(
                      onTap: () {
                        controller.pickTime(context,"Login");
                      },
                      child: Container(
                        width: 300.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color :Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: lightGrey),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width:10,
                            ),
                            Obx(()=> CustomText(
                              text: DateFormat('h:mm a').format(controller.logintime.value),
                              size: 16,
                              weight: FontWeight.w200,
                            ))
                            ,
                            Spacer(),
                            Image.asset("assets/Clock.png",scale: 1.4,),
                            SizedBox(
                              width:10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomText(text: "Logout Time"),
                  Padding(
                    padding: EdgeInsets.all(18.w),
                    child:InkWell(
                      onTap: () {
                        controller.pickTime(context,"Logout");
                      },
                      child: Container(
                        width: 300.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color :Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: lightGrey),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width:10,
                            ),
                            Obx(()=> CustomText(
                              text: DateFormat('h:mm a').format(controller.logouttime.value),
                              size: 16,
                              weight: FontWeight.w200,
                            ))
                            ,
                            Spacer(),
                            Image.asset("assets/Clock.png",scale: 1.4,),
                            SizedBox(
                              width:10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
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
                  controller.createShift();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    void addSupervisor(BuildContext context){
      showDialog(
        context: context,
        builder: (BuildContext context) {

          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text('Add New Supervisor'),
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
                        text: "Employee Name",
                        size: 15,
                        weight: FontWeight.w100,
                      ),
                      SizedBox(
                        width: 80.w,
                      ),
                      CustomText(
                        text: "Contact",
                        size: 15,
                        weight: FontWeight.w100,
                      ),
                      SizedBox(
                        width: 130.w,
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
                  controller.employeeListModel.isEmpty ? Center(child: CustomText(text: "No Employee Found",size: 15,weight: FontWeight.w100,)) :
                  Obx(()=>
                      Column(
                        children: List.generate(controller.employeeListModel.length, (index) =>
                            Padding(
                              padding:  EdgeInsets.all(10.w),
                              child: InkWell(
                                onHover: (value){
                                  controller.SupervisorHover.value = value;
                                },
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        title: const Text('Add New Supervisor'),
                                        content: const Text(
                                            'Are you sure you want to add this employee as supervisor?'),
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
                                              controller.addSupervisor(controller.employeeListModel[index].id!);
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
                                    color : controller.SupervisorHover.value == index ? light :
                                    background,
                                    borderRadius: BorderRadius.circular(23.r),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:130.w,
                                        child: CustomText(
                                            text: "${controller.employeeListModel[index].middleName ?? ""} ${controller.employeeListModel[index].lastName?? ""}",
                                            size:15
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                      SizedBox(
                                        width:130.w,
                                        child: Center(
                                          child: CustomText(
                                              text: controller.employeeListModel[index].contactNumber ?? "Contact",
                                              size:15
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                      SizedBox(
                                        width:250.w,
                                        child: CustomText(
                                            text: controller.employeeListModel[index].address ?? "Address",
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
    void _showMyDialog(BuildContext context,int index) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text('Trip Route Details'),
            content: SizedBox(
              height: 0.5.sh, // Adjust the height of the map
              width: 0.3.sw, // Adjust the width of the map
              child: Obx(()=> GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(controller.officesList[index].latitude!, controller.officesList[index].latitude!),
                  zoom: 14.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('1'),
                    position: LatLng(controller.officesList[index].latitude!, controller.officesList[index].latitude!),
                  ),
                },
                // Inside the `onMapCreated` callback of your Google Map
                onMapCreated: (GoogleMapController mapController) {
                },

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
    return ResponsiveWidget(largeScreen: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
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
                  width: 30.w,
                ),
                Padding(
                  padding:  EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Total Shift",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                          child: CustomText(
                            text: controller.shiftList.length.toString(),
                            weight: FontWeight.bold,
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 40.w,
                ),
                Padding(
                  padding:  EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Total Guards",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const CustomText(
                        text: "100",
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 40.w,
                ),
                Padding(
                  padding:  EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Total Supervisor",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                          child: CustomText(
                            text: "100",
                            weight: FontWeight.bold,
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 40.w,
                ),
                Padding(
                  padding:  EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Total Offices",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                          child: CustomText(
                            text: "100",
                            weight: FontWeight.bold,
                          )
                      ),
                    ],
                  ),
                ),

                const Spacer(),
                IconButton(icon: Image.asset('assets/Refresh.png',width: 45,height: 45,), onPressed: () {
                  controller.RefreshApi();
                },),
                SizedBox(
                  width: 40.w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
              children:[
                Expanded(
                    flex: 1,
                    child:Container(
                      height: 500.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color :light,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "Shifts",size: 17,weight: FontWeight.bold,),
                            SizedBox(
                              height: 10.h,
                            ),
                            const Row(
                              children: [
                                CustomText(text: "Login",size: 16,weight: FontWeight.w200,),
                                Spacer(),
                                CustomText(text: "Logout",size: 16,weight: FontWeight.w200,),
                              ],
                            ),
                            Divider(),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child:
                                Obx(()=>Column(
                                  children: List.generate(controller.shiftList.length, (index) => Container(
                                    height: 70.h,
                                    padding: EdgeInsets.all(10.w),
                                    margin: EdgeInsets.only(top: 5.h),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color :background,
                                      borderRadius: BorderRadius.circular(23.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: controller.shiftList[index].loginTime! ?? "---",
                                          size: 16,
                                          weight: FontWeight.w400,
                                        ),
                                        InkWell(
                                          onTap: (){
                                            controller.deleteShift(
                                                controller.shiftList[index].id!
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/Delete.png',
                                            scale: 1.8,
                                          ),
                                        ),
                                        CustomText(
                                          text:controller.shiftList[index].logoutTime! ?? "---",
                                          size: 16,
                                          weight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            InkWell(
                                onTap: (){
                                  showMyDialog(context);
                                },
                                child: Button("Add", 100,14 ,50)
                            )
                          ],
                        ),
                      ),
                    )
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                    flex: 2,
                    child:Container(
                        height: 500.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color :light,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child:Padding(
                          padding:  EdgeInsets.all(6.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const CustomText(text: "Supervisor",size: 17,weight: FontWeight.bold,),
                                  const Spacer(),
                                  InkWell(
                                    onTap: (){
                                      addSupervisor(context);
                                    },
                                    child: Button(
                                      "Add",
                                      90,
                                      15,
                                      50,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  CustomText(
                                    text: "Name",
                                    size: 16,
                                    weight: FontWeight.w400,
                                  ),
                                  SizedBox(
                                    width: 200.w,
                                  ),
                                  CustomText(
                                    text: "Contact",
                                    size: 16,
                                    weight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              Divider(),
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Obx(()=>Column(
                                    children: List.generate(controller.supervisorList.length, (index) =>
                                        Row(
                                          children: [
                                            SizedBox(
                                              width:140.w,
                                              child: Center(
                                                child: CustomText(
                                                  text: "${controller.supervisorList[index].middleName ?? ""} ${controller.supervisorList[index].lastName?? ""}",
                                                  size:14,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:80.w,
                                            ),
                                            SizedBox(
                                              width:140.w,
                                              child: Center(
                                                child: CustomText(
                                                    text: controller.supervisorList[index].contactNumber ?? "Contact",
                                                    size:14
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:40.w,
                                            ),
                                            Spacer(),
                                            Image.asset('assets/EditIcon.png',scale: 1.8,),
                                            SizedBox(
                                              width:40.w,
                                            ),
                                            Image.asset('assets/Delete.png',scale: 1.8)
                                          ],
                                        ))
                                ),
                                ),
                              )


                            ],
                          ),
                        )
                    )
                ),
              ]
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 700.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color :light,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(text: "Guards",size: 18,weight: FontWeight.bold,),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          showGuardAgencyDialog(
                              context,
                              controller,
                          );
                        },
                        child: Button(
                          "Add Agency",
                          100,
                          15,
                          50,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddGuard()));
                        },
                        child: Button(
                          "Add Guard",
                          90,
                          15,
                          50,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "Guard Name",
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        width: 120.w,
                      ),
                      CustomText(
                        text: "Gender",
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      CustomText(
                        text: "Age",
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      CustomText(
                        text: "Contact",
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        width: 90.w,
                      ),
                      CustomText(
                        text: "Trip Count",
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      CustomText(
                        text: "Address",
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                    ],
                  ),
                  Divider(),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        children: List.generate(controller.officesList.length, (index) =>
                            Row(
                              children: [
                                SizedBox(
                                  width:130.w,
                                  child: CustomText(
                                    text: 'Employee name',
                                    size:14,
                                  ),
                                ),
                                SizedBox(
                                  width:70.w,
                                ),
                                SizedBox(
                                  width:60.w,
                                  child: Center(
                                    child: CustomText(
                                        text: 'Male',
                                        size:14
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width:40.w,
                                ),
                                SizedBox(
                                  width:50.w,
                                  child: Center(
                                    child: CustomText(
                                        text: '45',
                                        size:14
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width:20.w,
                                ),
                                SizedBox(
                                  width:140.w,
                                  child: Center(
                                    child: CustomText(
                                        text: '498983989303',
                                        size:14
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:40.w,
                                ),
                                SizedBox(
                                  width:40.w,
                                  child: Center(
                                    child: CustomText(
                                        text: '12',
                                        size:14
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:70.w,
                                ),
                                SizedBox(
                                  width:300.w,
                                  child: Center(
                                    child: CustomText(
                                        text: 'Samrat Nagar, majiwada niwas, Gandhi park pune east',
                                        size:14
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width:40.w,
                                ),
                                Image.asset('assets/EditIcon.png',scale: 1.8,),
                                SizedBox(
                                  width:40.w,
                                ),
                                Image.asset('assets/Delete.png',scale: 1.8)
                              ],
                            )
                        )
                    ),
                  )


                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 600,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Office",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AddOffice()),
                          );
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                   SizedBox(height: 10.h),
                  Expanded(
                    child: Obx(
                          () => DataTable(
                        columnSpacing: 50,
                        horizontalMargin: 10,

                        columns: const [
                          DataColumn(
                            label: Text("Office Name",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          DataColumn(
                            label: Text("Supervisor Id",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          DataColumn(
                            label: Text("Address",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          DataColumn(
                            label: Text("Actions",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                        rows: List.generate(
                          controller.officesList.length,
                              (index) => DataRow(
                            cells: [
                              DataCell(
                                Text(controller.officesList[index].name ?? "Office name"),
                              ),
                              DataCell(
                                Text(controller.officesList[index].supervisorId ??
                                    "Supervisor Id"),
                              ),
                              DataCell(
                                Text(controller.officesList[index].address ?? "Address"),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _showMyDialog(context, index);
                                      },
                                      child: Image.asset(
                                        'assets/Maps.png',
                                        scale: 1.8,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    InkWell(
                                      onTap: () {
                                        // Handle delete action here
                                      },
                                      child: Image.asset(
                                        'assets/Delete.png',
                                        scale: 1.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),


        ],
      ),
    ),
    );
  }
}