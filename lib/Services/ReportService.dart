import 'dart:html' as html;

import '../helpers/SharedPreference/shared_preferences_constants.dart';
import '../helpers/SharedPreference/shared_preferences_methods.dart';
import '../helpers/api_constants.dart';

class ReportService{
  Future<void> excelOfTripsByCompanyId(
      String report,
      String startDate,
      String endDate,
      String tripType,
      String status,
      ) async {
    Future<void> downloadFile(String url, String fileName) async {
      try {
        // Create an anchor element with the file URL
        final anchor = html.AnchorElement(href: url)
          ..target = '_blank'  // Opens the link in a new tab
          ..download = fileName // Suggests a name for the downloaded file
          ..click();           // Triggers the download

        print('Download started for $fileName');
      } catch (e) {
        print('Error downloading file: $e');
      }
    }
    String company = await getStringFromCache(SharedPreferenceString.companyId);
    String fileUrl = '${ApiStringConstants.baseurl}${ApiStringConstants.excelOfTripsByCompanyId}$company?startDate=2023-06-23&endDate=2024-12-30&tripType=login&status=on the way';
    const String fileName = '';

    downloadFile(fileUrl, "$startDate-$endDate excelOfTrips.xlsx");
  }

  Future<void> excelOfRoutesByCompanyId(
      String report,
      String startDate,
      String endDate,
      String tripType,
      String status,
      ) async {
    Future<void> downloadFile(String url, String fileName) async {
      try {
        // Create an anchor element with the file URL
        final anchor = html.AnchorElement(href: url)
          ..target = '_blank'  // Opens the link in a new tab
          ..download = fileName // Suggests a name for the downloaded file
          ..click();           // Triggers the download

        print('Download started for $fileName');
      } catch (e) {
        print('Error downloading file: $e');
      }
    }
    String company = await getStringFromCache(SharedPreferenceString.companyId);
    String fileUrl = '${ApiStringConstants.baseurl}${ApiStringConstants.excelOfRoutesByCompanyId}$company?startDate=$startDate&endDate=$endDate';
    const String fileName = '';

    downloadFile(fileUrl, "$startDate-$endDate excelOfRoutes.xlsx");
  }

  Future<void> excelOfEmployeeByCompanyId (
      String report ,
      String startDate,
      String endDate,
      String tripType,
      )async {
    Future<void> downloadFile(String url, String fileName) async {
      try {
        // Create an anchor element with the file URL
        final anchor = html.AnchorElement(href: url)
          ..target = '_blank'  // Opens the link in a new tab
          ..download = fileName // Suggests a name for the downloaded file
          ..click();           // Triggers the download

        print('Download started for $fileName');
      } catch (e) {
        print('Error downloading file: $e');
      }

    }
    String company = await getStringFromCache(SharedPreferenceString.companyId);
    String fileUrl = '${ApiStringConstants.baseurl}${ApiStringConstants.excelOfTripsOfEmployeesByCompanyId}$company?startDate=$startDate&endDate=$endDate';
    const String fileName = '';

    downloadFile(fileUrl, "$startDate-$endDate excelOfEmployee.xlsx");



  }

}