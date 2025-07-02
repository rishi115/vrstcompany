import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vrsstranslinkcompany/Model/HomeModel.dart';
import 'package:vrsstranslinkcompany/Model/TripData.dart';

import '../helpers/SharedPreference/shared_preferences_constants.dart';
import '../helpers/SharedPreference/shared_preferences_methods.dart';
import '../helpers/api_constants.dart';
import '../helpers/api_utils.dart';

class HomeService{
  Future<VendorDistributionModel> getVendorDistribution(String shiftId) async {
    String companyId = await getStringFromCache(SharedPreferenceString.companyId);
    String url = '${ApiStringConstants.baseurl}/trip/getVendorDistribution?company=$companyId&shift=$shiftId';
    VendorDistributionModel vendorDistributionModel = VendorDistributionModel();
    try {
      // Fetch the token from shared preferences
      String token = await getStringFromCache(SharedPreferenceString.accessToken);

      // Perform the API call
      final response = await apiUtils.get(
        url: url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Check for a successful response and map data to the model
      if (response.data['success'] == true) {
        print('Successfully fetched vendor distribution');
        vendorDistributionModel = VendorDistributionModel.fromJson(response.data['data']);
      } else {
        print('Failed to fetch vendor distribution: ${response.data['message']}');
      }
    } catch (e) {
      print('Error fetching vendor distribution: $e');
    }
    return vendorDistributionModel;
  }
  Future<List<TripData>> getTodayTripData() async {
    String companyId = await getStringFromCache(SharedPreferenceString.companyId);
    String url = '${ApiStringConstants.baseurl}/trip/getTodaysTrip/$companyId';
    // String url = '${ApiStringConstants.baseurl}/trip/getTodaysTrip/67663221a5d41f503ca209d2';
    List<TripData> tripList = [];
    try {
      // Fetch the token from shared preferences
      String token = await getStringFromCache(SharedPreferenceString.accessToken);

      // Perform the API call
      final response = await apiUtils.get(
        url: url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data['success'] == true) {
        print('Successfully fetched vendor distribution');
        for (var trip in response.data['trips']) {
          tripList.add(TripData.fromJson(trip));
        }

      } else {
        print('Failed to fetch vendor distribution: ${response.data['message']}');
          }
    } catch (e) {
      print('Error fetching vendor distribution: $e');
    }
    return tripList;
  }

  Future<void> getOtaOtdMetrics({
    required String companyId,
    required String shiftId,
    required int year,
    required int month,
    required String tripType,
  }) async {
    String url =
        '${ApiStringConstants.baseurl}/api/trip/getOtaOtdMetrics?company=$companyId&shift=$shiftId&year=$year&month=$month&tripType=$tripType';

    try {
      // Fetch the token from shared preferences
      String token = await getStringFromCache(SharedPreferenceString.accessToken);

      // Perform the API call
      final response = await apiUtils.get(
        url: url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Check for a successful response and map data to the model
      if (response.data['success'] == true) {
        print('Successfully fetched OTA/OTD metrics');
      } else {
        print('Failed to fetch OTA/OTD metrics: ${response.data['message']}');
      }
    } catch (e) {
      print('Error fetching OTA/OTD metrics: $e');
    }}

  Future<void> getTripCountsByMonth({
    required int year,
    required int month,
    required String tripType,
  }) async {
    String companyId = await getStringFromCache(SharedPreferenceString.companyId);
    String url =
        '${ApiStringConstants.baseurl}/api/trip/getTripCountsByMonth?companyId=$companyId&year=$year&month=$month&tripType=login';

    try {
      // Fetch the token from shared preferences
      String token = await getStringFromCache(SharedPreferenceString.accessToken);

      // Perform the API call
      final response = await apiUtils.get(
        url: url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Check for a successful response and map data to the model
      if (response.data['success'] == true) {
        print('Successfully fetched trip counts by month');
      } else {
        print('Failed to fetch trip counts by month: ${response.data['message']}');
      }
    } catch (e) {
      print('Error fetching trip counts by month: $e');
    }
  }
  Future<TripAnalytics> getTripCount({
    required String tripType,
    required String shiftId,
    required String period
  }) async {
    String companyId = await getStringFromCache(SharedPreferenceString.companyId);
    String url =
        '${ApiStringConstants.baseurl}/trip/getTripCounts?companyId=$companyId&shiftId=$shiftId&period=monthly&tripType=$tripType';
    TripAnalytics tripAnalytics = TripAnalytics();

    try {
      // Fetch the token from shared preferences
      String token = await getStringFromCache(SharedPreferenceString.accessToken);

      // Perform the API call
      final response = await apiUtils.get(
        url: url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Check for a successful response and map data to the model
      if (response.data['success'] == true) {
        tripAnalytics = TripAnalytics.fromJson(response.data['data']);
      } else {
        Get.snackbar('Error', response.data['message']);
      }
    } catch (e) {
      print('Error fetching trip counts by month: $e');
    }
    return tripAnalytics;
  }
}