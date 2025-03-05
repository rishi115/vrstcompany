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
  try {

    vendorDetails.value = await vendorService.getVendorById(id);

    // Navigate to details page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Vendordetails(), // Pass companyModel if needed
      ),
    );
  } catch (e) {
    // Handle error and dismiss loading dialog
    Navigator.pop(context);
    print('Error fetching vendor details: $e');
  }
}


@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVendorByCompanyId();
  }

}