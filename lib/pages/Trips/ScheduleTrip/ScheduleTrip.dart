import 'package:flutter/material.dart';
import 'package:vrsstranslinkcompany/pages/Trips/TripController/TripController.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../constants/controllers.dart';
import '../../../../constants/style.dart';
import '../../../constants/responsiveness.dart';
import '../../../../widgets/custom_text.dart';
import '../../../widgets/InputField.dart';


class ScheduleTripsScreen extends GetView<TripController> {
  const ScheduleTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> Driver= ["Driver 1", "Driver 2", "Driver 3", "Driver 4"];
    double H = MediaQuery.of(context).size.height;
    double W = MediaQuery.of(context).size.width;
    return  Column(
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
                  color: light,
                )
            ),
          ],
        ),
        ),

      Expanded(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Container(
              width: W,
              decoration: BoxDecoration(
                color: light,
                borderRadius: BorderRadius.circular(10),
              ),
              child:Row(
                children: [
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      CustomText(
                          text: "Driver",
                      size: 17,
                      ),
                      SizedBox(height: 10,),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 250,
                        ),
                        height: 50,
                        child: MultiSelectDropDown.network(
                          onOptionSelected: (options) {},
                          networkConfig: NetworkConfig(
                            url: 'https://jsonplaceholder.typicode.com/users',
                            method: RequestMethod.get,
                            headers: {
                              'Content-Type': 'application/json',
                            },
                          ),
                          searchEnabled: true,
                          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                          responseParser: (response) {

                            final list = (response as List<dynamic>).map((e) {
                              final item = e as Map<String, dynamic>;
                              return ValueItem(
                                label: item['name'],
                                value: item['id'].toString(),
                              );
                            }).toList();

                            return Future.value(list);
                          },
                          responseErrorBuilder: ((context, body) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('Error fetching the data'),
                            );
                          }),
                                        ),
                                    ),
                      SizedBox(height: 20,),
                      CustomText(
                        text: "Vehicle",
                        size: 17,
                      ),
                      SizedBox(height: 10,),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 250,
                        ),
                        height: 50,
                        child: MultiSelectDropDown.network(
                          onOptionSelected: (options) {},
                          networkConfig: NetworkConfig(
                            url: 'https://jsonplaceholder.typicode.com/users',
                            method: RequestMethod.get,
                            headers: {
                              'Content-Type': 'application/json',
                            },
                          ),
                          searchEnabled: true,
                          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                          responseParser: (response) {

                            final list = (response as List<dynamic>).map((e) {
                              final item = e as Map<String, dynamic>;
                              return ValueItem(
                                label: item['name'],
                                value: item['id'].toString(),
                              );
                            }).toList();

                            return Future.value(list);
                          },
                          responseErrorBuilder: ((context, body) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('Error fetching the data'),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 20,),
                      CustomText(
                        text: "Trip Start Time",
                        size: 17,
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
                          controller.selectTime(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: light,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: lightGrey, width: 0.5),
                          ),
                          child:Padding(
                            padding: const EdgeInsets.only(right: 14.0,left: 14.0,top: 8.0,bottom: 8.0),
                            child: Obx(() =>
                            CustomText(
                              text: controller.time.value,
                              size: 17,
                            ),
                                                    ),
                          ),),
                      )
                    ],
                  ),
                  Container(
                    width: W*0.3,
                    height: H,
                    color: light,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(37.42796133580664, -122.085749655962),
                          zoom: 14.4746,
                        ),
                      ),
                    )
                  ),
                  SizedBox(width: 6,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      CustomText(text: 'Select Employee',
                          size: 19
                      ),
                      CustomText(text: 'Selected 2/21'),
                      Container(
                        margin: EdgeInsets.only(top:20,bottom: 20),
                        width: W*0.286,
                        height: H*0.7,
                        color: light,
                        child:  SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                7,
                                    (index) =>
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Container(
                                                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: lightGrey, width: 0.5),
                                                                ),
                                                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              CustomText(text: 'Employee 1',size: 15,),
                                              CustomText(text: 'Gender',size: 13,),

                                            ],
                                          )
                                          ,Spacer(),
                                          InkWell(
                                            onTap: (){},
                                            child: Container(
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: light,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: lightGrey, width: 0.5),
                                              ),
                                              child: Center(
                                                  child: CustomText(text:'Select')),
                                            ),
                                          ),

                                          SizedBox(width: 10,),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      const Row(
                                          children:[
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(text: 'Pick Up',size: 15,),
                                                  CustomText(text: 'GRGR+M78, Shivajinagar, F.C. ',size: 12),
                                                  CustomText(text: 'Road, Pune, Maharashtra 411004',size: 12,),

                                                ]
                                            ),
                                            SizedBox(width: 18,),
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(text: 'Drop Up',size: 15,),
                                                  CustomText(text: 'GRGR+M78, Shivajinagar, F.C.',size: 12),
                                                  CustomText(text: 'Road, Pune, Maharashtra 411004',size: 12,),
                                                ]
                                            )
                                          ]
                                      )
                                    ],
                                  ),
                                                                ),

                                                              ),
                                )
                            )
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              )
            ),
          )
      ),




      ],
    );
  }
}
