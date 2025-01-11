import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:vrsstranslinkcompany/Model/RouteModel.dart';
import 'package:vrsstranslinkcompany/Model/VehicleModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Model/RoasterModel.dart';
import '../helpers/SharedPreference/shared_preferences_constants.dart';
import '../helpers/SharedPreference/shared_preferences_methods.dart';
import '../helpers/api_constants.dart';
import '../helpers/api_utils.dart';
import '../pages/RoasterPage/RoasterController/RoasterController.dart';

class RoasterService {
  Future<RoasterModel> getRoasterByDate(
      String date,
      String shift,
      String office,
      int page,
      String tripType,
      int limit
      ) async {
    String companyId = await getStringFromCache(SharedPreferenceString.companyId);
    String url = '${ApiStringConstants.baseurl}${ApiStringConstants.getAllRoastersAndRoutes}?company=$companyId&date=$date&shift=$shift&office=$office&tripType=$tripType&page=1&limit=10';
    RoasterModel? roasters;
    try {
      String token = await getStringFromCache(SharedPreferenceString.accessToken);

      final response = await apiUtils.get(url: url,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {
        roasters = RoasterModel.fromJson(response.data['data']);
        return roasters;
      }
    } catch (e) {
      print('Error getting Roaster details: $e');
    }
    return roasters!;
  }

  Future<void> getRoutes(
      String date,
      String shift,
      String office,
      int page,
      int limit,
      String tripType
      ) async {
    String companyId = await getStringFromCache(SharedPreferenceString.companyId);
    String url = '${ApiStringConstants.baseurl}${ApiStringConstants.getRoutes}?company=$companyId&date=$date&shift=$shift&office=$office&tripType=$tripType&page=1&limit=10';
    List<RouteModel> routes = [];
    try {
      String token = await getStringFromCache(SharedPreferenceString.accessToken);
      final response = await apiUtils.get(url: url,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.data['success'] == true) {

      }
    } catch (e) {
      print('Error getting Roaster details: $e');
    }
  }


  Future<List<VehicleCapacity>> getVehicleCapacity() async {
      List<VehicleCapacity> vehicleCapacity = [];
      try {
        String url = '${ApiStringConstants.baseurl}${ApiStringConstants.getVehicleCapacity}';
        String token = await getStringFromCache(SharedPreferenceString.accessToken);
        String company = await getStringFromCache(SharedPreferenceString.companyId);

        // Append the company ID as a query parameter
        String fullUrl = '$url/$company';

        // Make the GET request without a body
        var response = await apiUtils.get(
          url: fullUrl,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        // Handle the response
        if (response.data['success'] == true) {
          response.data['data'].forEach((data) {
            vehicleCapacity.add(VehicleCapacity.fromJson(data));
          });
        }
      } catch (e) {
        print('Error getting Vehicle Capacity details: $e');
      }

      return vehicleCapacity;
    }

    publishRoute(
        List<String> routeList
        )async{
      String url = ApiStringConstants.baseurl + ApiStringConstants.publishRoute;
      try {
        String token = await getStringFromCache(SharedPreferenceString.accessToken);
        final response = await apiUtils.post(url: url,
            options: Options(headers:{
              'Authorization': 'Bearer $token',
            }),
            data:{
              "listOfRoutes" :routeList
            }
          );
        if(response.data['success']=='true'){
        }
      } catch (e) {
        Get.snackbar('Error Publishing Route',e.toString());
        print('Error Creating Route : $e');
      }
    }

    Future<void> createRoute(
        LatLng startPoint,
        LatLng endPoint,
        String startPointName,
       int totalDistance,
        String startTime,
        String endTime,
        String shiftId,
        String date,
        int capacity,
        List<Map<String,dynamic>> loc,
        List<Map<String,dynamic>> locaList,
        String vendor,
        )async{
        String url = ApiStringConstants.baseurl + ApiStringConstants.createRoute;
        try {
          String token = await getStringFromCache(SharedPreferenceString.accessToken);
          String companyId = await getStringFromCache(SharedPreferenceString.companyId);
          final response = await apiUtils.post(url: url,
              options: Options(headers:{
                'Authorization': 'Bearer $token',
              }),
              data:
                {
                  "startPoint": {
                    "latitude": startPoint.latitude,
                    "longitude": startPoint.longitude
                  },
                  "endPoint": {
                    "latitude": endPoint.latitude,
                    "longitude": endPoint.longitude
                  },
                  "startPointName": startPointName,
                  "totalDistance": totalDistance,
                  "startTime": startTime,
                  "endTime": endTime,
                  "shift": shiftId, // Replace with an actual Shift ID
                  "date": date,
                  "isGuard": false,
                  "capacity": 5,
                  "listOfEmployees": loc,
                  "locaList": locaList,
                  "company": companyId, // Replace with an actual Company ID
                  "vendor": vendor  // Replace with an actual Vendor ID (optional)

          });

          if(response.data['success']=='true'){
          print("route Created");

          }
        } catch (e) {
          print('Error Creating Route : $e');
      }
    }

    Future<void> deleteRoaster(
        String roasterId
        )async{

    try {
        String url = '${ApiStringConstants.baseurl}${ApiStringConstants.getRoasterById}';
        String token = await getStringFromCache(SharedPreferenceString.accessToken);
        // Append the company ID as a query parameter
        String fullUrl = '$url$roasterId';

        // Make the GET request without a body
        var response = await apiUtils.delete(
          api: fullUrl,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        // Handle the response
        if (response.data['success'] == true) {
          Get.snackbar(
            'Success',
            'Roaster Deleted',
          );
        }
      } catch (e) {
        print('Error getting Route details: $e');
      }
    }

  approveVendor(
      List<String> routeList
      )async{
    String url = ApiStringConstants.baseurl + ApiStringConstants.visibleToVendor;
    try {
      String token = await getStringFromCache(SharedPreferenceString.accessToken);
      final response = await apiUtils.post(url: url,
          options: Options(headers:{
            'Authorization': 'Bearer $token',
          }),
          data:{
            "listOfRoutes" :routeList
          }
      );

      if(response.data['success']=='true'){
        Get.snackbar('Success', 'Route Send');
      }
    } catch (e) {
      Get.snackbar('Error Publishing Route',e.toString());
      print('Error Creating Route : $e');
    }
  }
  updateVendor(
      String vendorId,
      String vendorName,
      String routeId
      ) async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.updateRoute;
    try {
      String token = await getStringFromCache(SharedPreferenceString.accessToken);
      final response = await apiUtils.put(url: url+routeId,
          options: Options(headers:{
            'Authorization': 'Bearer $token',
          }),
          data:{
            "vendorId": vendorId,
            "vendorName": vendorName,
          }
          );

      if(response.data['success']=='true'){
        print("Vendor  Changed");
      }
    } catch (e) {
      print('Error Creating Route : $e');
    }
  }
  Future<void> updateRoute(List<Employees> employees, String routeId) async {
    String url = ApiStringConstants.baseurl + ApiStringConstants.updateRoute;
    try {
      String token = await getStringFromCache(SharedPreferenceString.accessToken);

      // Convert the employees list to JSON
      List<Map<String, dynamic>> employeesJson = employees.map((e) => e.toJson()).toList();

      final response = await apiUtils.put(
        url: url + routeId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "listOfEmployees": employeesJson, // Pass the serialized list
        },
      );

      if (response.data['success'] == 'true') {
        print(
            "Route updated successfully: ${response.data['data']}");
      } else {
        print("Failed to update route: ${response.data}");
      }
    } catch (e) {
      print('Error Updating Route: $e');
    }
  }


}
