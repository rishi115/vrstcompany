import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:vrsstranslinkcompany/Model/EmployeeDetailsModel.dart';
import 'package:get/get.dart';
import 'package:vrsstranslinkcompany/Services/SettingsService.dart';
import '../../../Model/NodalPointModel.dart';
import '../../../Services/NodalService.dart';

class NodalPointController extends  GetxController {
  final NodalService nodalService = NodalService();
  final SettingsService settingsService = SettingsService();
  RxString nodalPointName = ''.obs;
  RxString address = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  var nodalList = [].obs;
  var employeeDetails = <EmployeeDetails>[].obs;
  var selectedId = <String>[].obs;
  var officeId = ''.obs;
  var officeList = [].obs;
  var islandLoading = false.obs;
  var officeName = ''.obs;




  getAllNodal() async {
    islandLoading.value = true;
    await Future.wait([
      nodalService.getAllNodalPoint(),
       nodalService.getUnassignedEmployee(),
      settingsService.getAllOffice()
    ]).then((value) {
     nodalList.value = value[0] as List<NodalPointModel>;
      employeeDetails.value = value[1] as List<EmployeeDetails>;
     officeList.value = value[2];
    });
    islandLoading.value = false;
  }

  unAssignEmployee(String nodalId,String employeeId) async {
    await nodalService.unAssignEmployeeToNodal(nodalId,employeeId);
    getAllNodal()
   ;
  }
  addInBulk(
      Uint8List bytes,
      String fileName,
      ){
    nodalService.bulkAdd(
        bytes,fileName
    );
  }


  Future<void> getLatLngFromAddress(String address) async {
    const String apiKey = 'AIzaSyCE-07OqyB1ze3XgMCta9qH95p4bhENiLg'; // Replace with your API key

    final Dio dio = Dio();
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['status'] == 'OK') {
          final location = data['results'][0]['geometry']['location'];
          final double Latitude = location['lat'];
          final double Longitude = location['lng'];
          latitude.value = Latitude.toString();
          longitude.value = Longitude.toString();
        } else {
          print('Error: ${data['status']}');
          return null;
        }
      } else {
        print('Failed to get response from API');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  createNodal() async {
    bool created = await nodalService.createNodal(
        nodalPointName.value, address.value, latitude.value, longitude.value,
        officeId.value);
    Get.snackbar('Success', 'Nodal Point Created Successfully');
      getAllNodal();
  }
  assignEmployeeToNodal(String nodalId) async {
   await  nodalService.assignEmployeeToNodal(selectedId,nodalId);
    Get.snackbar('Success', 'Employee Assigned Successfully');
    selectedId.clear();
    getAllNodal();
  }
    selectedEmployeeId(String id) {
   if(selectedId.contains(id)){
     selectedId.remove(id);
    }else{
      selectedId.add(id);
   }
  }
  @override
  void onInit() {
    super.onInit();
    getAllNodal();

  }
}
