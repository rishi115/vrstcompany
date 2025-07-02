
class VendorModelById {
  String? id;
  String? vendorName;
  String? address;
  int? pincode;
  String? city;
  String? gstin;
  double? latitude;
  double? longitude;
  String? primaryContact;
  String? primaryName;
  String? primaryEmail;
  String? secondaryContact;
  String? secondaryName;
  String? secondaryEmail;
  int? vehicleCount;
  int? driverCount;
  String? panCardNumber;
  String? role;
  bool? disabled;
  List<String>? listOfVehicles;
  List<String>? listOfDrivers;
  List<dynamic>? listOfTrips;
  List<dynamic>? listOfCompanies;
  int? vendorId;
  int? v;

  VendorModelById({this.id, this.vendorName, this.address, this.pincode, this.city, this.gstin, this.latitude, this.longitude, this.primaryContact, this.primaryName, this.primaryEmail, this.secondaryContact, this.secondaryName, this.secondaryEmail, this.vehicleCount, this.driverCount, this.panCardNumber, this.role, this.disabled, this.listOfVehicles, this.listOfDrivers, this.listOfTrips, this.listOfCompanies, this.vendorId, this.v});

  VendorModelById.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    vendorName = json["vendorName"];
    address = json["address"];
    pincode = json["pincode"];
    city = json["city"];
    gstin = json["gstin"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    primaryContact = json["primaryContact"];
    primaryName = json["primaryName"];
    primaryEmail = json["primaryEmail"];
    secondaryContact = json["secondaryContact"];
    secondaryName = json["secondaryName"];
    secondaryEmail = json["secondaryEmail"];
    vehicleCount = json["vehicleCount"];
    driverCount = json["driverCount"];
    panCardNumber = json["panCardNumber"];
    role = json["role"];
    disabled = json["disabled"];
    listOfVehicles = json["listOfVehicles"] == null ? null : List<String>.from(json["listOfVehicles"]);
    listOfDrivers = json["listOfDrivers"] == null ? null : List<String>.from(json["listOfDrivers"]);
    listOfTrips = json["listOfTrips"] ?? [];
    listOfCompanies = json["listOfCompanies"] == null ? null : List<dynamic>.from(json["listOfCompanies"]);
    vendorId = json["vendorId"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["vendorName"] = vendorName;
    _data["address"] = address;
    _data["pincode"] = pincode;
    _data["city"] = city;
    _data["gstin"] = gstin;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["primaryContact"] = primaryContact;
    _data["primaryName"] = primaryName;
    _data["primaryEmail"] = primaryEmail;
    _data["secondaryContact"] = secondaryContact;
    _data["secondaryName"] = secondaryName;
    _data["secondaryEmail"] = secondaryEmail;
    _data["vehicleCount"] = vehicleCount;
    _data["driverCount"] = driverCount;
    _data["panCardNumber"] = panCardNumber;
    _data["role"] = role;
    _data["disabled"] = disabled;
    if(listOfVehicles != null) {
      _data["listOfVehicles"] = listOfVehicles;
    }
    if(listOfDrivers != null) {
      _data["listOfDrivers"] = listOfDrivers;
    }
    if(listOfTrips != null) {
      _data["listOfTrips"] = listOfTrips;
    }
    if(listOfCompanies != null) {
      _data["listOfCompanies"] = listOfCompanies;
    }
    _data["vendorId"] = vendorId;
    _data["__v"] = v;
    return _data;
  }
}

