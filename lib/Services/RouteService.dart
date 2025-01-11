import 'package:dio/dio.dart';
import 'package:vrsstranslinkcompany/Model/RouteModel.dart';

import '../helpers/SharedPreference/shared_preferences_constants.dart';
import '../helpers/SharedPreference/shared_preferences_methods.dart';
import '../helpers/api_constants.dart';
import '../helpers/api_utils.dart';

class RouteService{
  Future<List<RouteModel>> getRoutes() async {
    List<RouteModel> Route = [];
    try {
      String url = '${ApiStringConstants.baseurl}${ApiStringConstants.getRouteByVendorId}';
      String token = await getStringFromCache(SharedPreferenceString.accessToken);
      String vendor = await getStringFromCache(SharedPreferenceString.vendorId);

      // Append the company ID as a query parameter
      String fullUrl = '$url$vendor';

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
        List<dynamic> data = response.data['assignments'];
        Route = data.map((e) => RouteModel.fromJson(e)).toList();
      }
    } catch (e) {
      print('Error getting Route details: $e');
    }

    return Route;
  }
  Future<void> assignVehicleAndDriverToRoute(
      String routeId, String vehicleId, String driverId
      )async{
    try{
      String url = '${ApiStringConstants.baseurl}${ApiStringConstants.assignDriverAndVehicleToRoute}';
      String token = await getStringFromCache(SharedPreferenceString.accessToken);
      final response = await apiUtils.put(
        url: '$url$routeId',
          options: Options(headers:{
            'Authorization': 'Bearer $token',
          }),
        data: {
          'vehicle': vehicleId,
          'driver': driverId,
        }
      );
      if(response.data['success'] == true){
        print('Vehicle and driver assigned to route successfully');
      }

    }catch(e){
      print('Error assigning vehicle and driver to route: $e');
    }
  }
}