import 'package:dio/dio.dart';
import 'package:vrsstranslinkcompany/Model/RouteModel.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Model/TripData.dart';
import '../helpers/SharedPreference/shared_preferences_constants.dart';
import '../helpers/SharedPreference/shared_preferences_methods.dart';
import '../helpers/api_constants.dart';
import '../helpers/api_utils.dart';

class TripService{
  // Future<void> createTrip(
  //     RouteModel routeModel,
  //     )async{
  //   String url = ApiStringConstants.baseurl + ApiStringConstants.scheduleTrip;
  //   try {
  //     // Map<String,dynamic> employeeList = {
  //     //     "employeeId": routeModel.listOfEmployees![0].employeeId,
  //     //     "nodalPoint":   routeModel.listOfEmployees![0].nodalPoint,
  //     //     "pickUpTime": routeModel.listOfEmployees![0].pickUpTime,
  //     //     "status": "On the way"
  //     // };
  //
  //     for(int i=0;i<routeModel.listOfEmployees!.length;i++){
  //       routeModel.listOfEmployees![i].status = "On the way";
  //     }
  //     String token = await getStringFromCache(SharedPreferenceString.accessToken);
  //     final response = await apiUtils.post(url: url + routeModel.id!,
  //         options: Options(headers:{
  //           'Authorization': 'Bearer $token',
  //         }),
  //         data: {
  //           "startPoint": {
  //             "longitude": routeModel.startPoint!.longitude.toString(),
  //             "latitude": routeModel.startPoint!.latitude.toString()
  //           },
  //           "endPoint": {
  //             "longitude": routeModel.endPoint!.longitude.toString(),
  //             "latitude": routeModel.endPoint!.latitude.toString()
  //           },
  //           "totalDistance": routeModel.totalDistance,
  //           "startTime": routeModel.startTime,
  //           "endTime": routeModel.endTime,
  //           "startPointName":routeModel.startPointName,
  //           "shift": routeModel.shift,
  //           "date": routeModel.date,
  //           "isGuard": routeModel.isGuard,
  //           "capacity": routeModel.capacity,
  //           "listOfEmployees": routeModel.listOfEmployees,
  //           "locaList": routeModel.locaList,
  //           "company": routeModel.company,
  //           "vendor": routeModel.vendor,
  //           "vehicle": routeModel.vehicle,
  //           "driver": routeModel.driver,
  //         });
  //
  //     if(response.data['success']=='true'){
  //       print("route Created");
  //
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error Creating Route',e.toString());
  //   }
  // }

  Future<List<TripByDate>> getTripByCompanyId(
      String date
      ) async{
    String url = ApiStringConstants.baseurl + ApiStringConstants.getTripsByDateAndCompanyId;
    List<TripByDate> tripData = [];
    try {
      String token = await getStringFromCache(SharedPreferenceString.accessToken);
      String companyId = await getStringFromCache(SharedPreferenceString.companyId);
      final response = await apiUtils.get(url: "$url?date=$date&companyId=$companyId&page=1&limit=10",
        options: Options(headers:{
          'Authorization': 'Bearer $token',
        }),
      );
      if(response.statusCode == 200){
        print('got all trips successfully');
        for(var item in response.data['data']){
          tripData.add(TripByDate.fromJson(item));
        }
      }
      return tripData;
    } catch (e) {
      // Get.snackbar('Error Getting Trips',e.toString());
      return tripData;

    }
  }
}