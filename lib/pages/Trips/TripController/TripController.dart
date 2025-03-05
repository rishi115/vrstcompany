import 'dart:async';
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrsstranslinkcompany/Model/TripData.dart';
import 'package:vrsstranslinkcompany/Services/TripService.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants/style.dart';

class TripController extends GetxController {
  RxString monthYear = "${Month[DateTime.now().month]}  ${DateTime.now().year.toString().substring(2)}".obs;
  final TripService tripService = TripService();
  RxString day = DateTime.now().day.toString().obs; // Corrected day assignment
  RxString selectedDriver = "Driver 1".obs;
  RxBool loading = false.obs;
  RxString time = "09:30 PM".obs;
  var tripList = <TripByDate>[].obs;
  var selectedDate = DateTime.now().obs;
  var mapController = Completer<GoogleMapController>().obs; // Observable Completer
  Future<void> selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 1),
      lastDate: DateTime(currentDate.year + 1),
    );
    if (picked != null && picked != currentDate) {
      // Format selected date
      String selectedMonthYear = "${Month[picked.month]}  ${picked.year.toString().substring(2)}";
      // Update monthYear with selected month and year
      monthYear.value = selectedMonthYear;
      selectedDate.value = picked;
      // Update day with selected day
      day.value = picked.day.toString();
      tripList.clear();
      getTripByCompanyId();
    }
  }
  Future selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (selectedTime != null) {
      // Format selected time
      String formattedTime = "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}";
      // Update time with selected time
      time.value = formattedTime;
    }
  }
  var openContainer=<int>[].obs;
  var polylineCoordinates = <LatLng>[].obs;
  var locationPolylines = <Polyline>[].obs;
  var Dialogmarkers = <Marker>[].obs;

  var officeLatlong = LatLng( 19.212930275061744, 72.97406369445206);
  addNormalMarker(
      LatLng latLng,
      )
  {
    final Marker marker = Marker(
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: const InfoWindow(title: 'Searched Location'),
    );

    Dialogmarkers.add(marker);
  }
  void toggleContainer(int index) {
    if (openContainer.contains(index)) {
      openContainer.remove(index);
    } else {
      openContainer.add(index);
    }
  }
  Future<void> _drawRoute(
      String originLatitude, String originLongitude,
      String destinationLatitude, String destinationLongitude
      ) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://vr-safetrips.onrender.com/api/direction/get'));
    request.body = json.encode({
      "origin": {
        "lat": originLatitude,
        "lng": originLongitude
      },
      "destination": {
        "lat": destinationLatitude,
        "lng": destinationLongitude
      }
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("response is here");
      addNormalMarker(LatLng(double.parse(originLatitude), double.parse(originLongitude)));
      final data = json.decode(await response.stream.bytesToString());
      final points = data["data"]['routes'][0]['overview_polyline']['points'];

      try {
        List<PointLatLng> decodedPoints = PolylinePoints().decodePolyline(points);
        for (var point in decodedPoints) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
        locationPolylines.add(
          Polyline(
            polylineId: PolylineId('route'),
            color: Colors.blue,
            points: polylineCoordinates,
            width: 2,
          ),
        );

      } catch (e) {
        print("error is here");
      }

    } else {
      throw Exception('Failed to load directions');
    }
  }
  getTripByCompanyId() async {
    loading.value = true;
    tripList.value = await tripService.getTripByCompanyId(
        selectedDate.value.toString().split(' ')[0]
    );
    print(tripList.length);
    loading.value = false;
  }
  routeFromCompany(
      List<ProvidedRoute> latLangs,
      double originLatitude,
      double originLongitude,
      ) async {

    if(latLangs.length==0)
    {
      return;
    }
    if(latLangs.length==1)
    {
      addNormalMarker(
          LatLng(
              latLangs[0].lat!,
              latLangs[0].lng!
          )
      );
      _drawRoute(
          latLangs[0].lat.toString(),
          latLangs[0].lng.toString(),
          originLatitude.toString(),
          originLongitude.toString()
      );
      addNormalMarker(
          LatLng(
             officeLatlong.latitude,
              officeLatlong.longitude
          )
      );
      return;
    }
    for(int i=0;i<latLangs.length-1;i++)
    {
      addNormalMarker(
          LatLng(
              latLangs[i].lat!,
              latLangs[i].lng!
          )
      );
      await _drawRoute(
          latLangs[i].lat.toString(),
          latLangs[i].lng.toString(),
          latLangs[i+1].lat.toString(),
          latLangs[i+1].lng.toString()
      );

    }
    addNormalMarker(
        LatLng(
            latLangs[latLangs.length-1].lat!,
            latLangs[latLangs.length-1].lng!
        )
    );
    _drawRoute(
        latLangs[latLangs.length-1].lat.toString(),
        latLangs[latLangs.length-1].lng.toString(),
        originLatitude.toString(),
        originLongitude.toString()
    );
    addNormalMarker(
        LatLng(
            officeLatlong.latitude,
            officeLatlong.longitude
        )
    );


  }


  @override
  void onInit() {
    super.onInit();
    getTripByCompanyId();
  }
}
