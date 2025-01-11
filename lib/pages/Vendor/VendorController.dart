import 'package:get/get.dart';
import 'package:vrsstranslinkcompany/Services/VendorService.dart';
import 'package:flutter/material.dart';
import 'package:vrsstranslinkcompany/pages/Vendor/vendorDetails/VendorDetails.dart';

import '../../Model/VendorModel.dart';
import '../LoadingScreen/loadingScreen.dart';

class VendorController extends GetxController{
var vendorList = [].obs;
final  vendorDetails = VendorModelById().obs;

final VendorService vendorService = VendorService();

  void getVendorByCompanyId() async {
    vendorList.value = await vendorService.getVendorByCompanyId();
  }
Future<void> navigateToDetailsPage(String id, BuildContext context) async {
  // Show the loading screen
  final overlayContext = Navigator.of(context).overlay?.context;
  if (overlayContext != null) {
    Navigator.push(
      overlayContext,
      MaterialPageRoute(builder: (context) => const LoadingScreen()),
    );
  }

  try {
    // Fetch data
    vendorDetails.value = await vendorService.getVendorById(id);
  } catch (e) {
    print('Error fetching vendor details: $e');
  } finally {
    // Navigate to the main details page and remove the loading screen
    if (overlayContext != null) {
      Navigator.pushReplacement(
        overlayContext,
        MaterialPageRoute(
          builder: (context) => Vendordetails(), // Pass companyModel if needed
        ),
      );
    }
  }
}


@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVendorByCompanyId();
  }

}