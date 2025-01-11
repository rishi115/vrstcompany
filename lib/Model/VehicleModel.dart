import 'dart:io';

class Vehicle {
  String? vehicleOwner;
  String? vehicleType;
  String? vehicleModel;
  String? vehicleMake;
  String? vehicleNumber;
  String? vehicleCapacity;
  String? status;
  String? chassisNumber;
  String? vehicleGroup;
  File? vehicleImage;
  String? fuelType;
  String? company;
  String? imeiNumber;
  String? inactiveDate;
  String? driver;
  String? dateOfManufacture;
  String? address;
  String? locality;
  String? latitude;
  String? longitude;
  String? inductionDate;
  String? inductionType;

  Vehicle({
     this.vehicleNumber,
      this.vehicleOwner,
     this.vehicleType,
     this.vehicleModel,
     this.vehicleMake,
      this.vehicleCapacity,
     this.vehicleGroup,
      this.vehicleImage,
     this.imeiNumber,
      this.status,
      this.chassisNumber,
      this.fuelType,
      this.company,
      this.dateOfManufacture,
    this.driver,
     this.address,
     this.locality,
     this.latitude,
     this.longitude,
     this.inductionDate,
     this.inductionType,
    this.inactiveDate,

  });
}


class AllVehicle {
  String? id;
  String? vehicleType;
  String? vehicleMake;
  String? vehicleModel;
  String? vehicleNumber;
  int? vehicleCapacity;
  String? status;
  String? fuelType;
  String? chassisNumber;
  String? vendor;
  List<dynamic>? vehicleGroup;
  String? inactiveDate;
  String? inductionDate;
  String? inductionType;
  String? address;
  String? locality;
  double? latitude;
  double? longitude;
  String? dateOfManufacturing;
  List<dynamic>? listOfTrips;
  String? registrationCertificate;
  String? registrationCertificateExpiration;
  String? insurancePaper;
  String? insurancePaperExpiration;
  String? taxReceipt;
  String? taxReceiptExpiration;
  String? permit;
  String? permitExpiration;
  String? pucExpiration;
  String? fitnessCertificateExpiration;
  String? driverAssignedOn;
  List<dynamic>? listOfPastDrivers;
  String? lastServiced;
  int? v;

  AllVehicle({this.id, this.vehicleType, this.vehicleMake, this.vehicleModel, this.vehicleNumber, this.vehicleCapacity, this.status, this.fuelType, this.chassisNumber, this.vendor, this.vehicleGroup, this.inactiveDate, this.inductionDate, this.inductionType, this.address, this.locality, this.latitude, this.longitude, this.dateOfManufacturing, this.listOfTrips, this.registrationCertificate, this.registrationCertificateExpiration, this.insurancePaper, this.insurancePaperExpiration, this.taxReceipt, this.taxReceiptExpiration, this.permit, this.permitExpiration, this.pucExpiration, this.fitnessCertificateExpiration, this.driverAssignedOn, this.listOfPastDrivers, this.lastServiced, this.v});

  AllVehicle.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    vehicleType = json["vehicleType"];
    vehicleMake = json["vehicleMake"];
    vehicleModel = json["vehicleModel"];
    vehicleNumber = json["vehicleNumber"];
    vehicleCapacity = json["vehicleCapacity"];
    status = json["status"];
    fuelType = json["fuelType"];
    chassisNumber = json["chassisNumber"];
    vendor = json["vendor"];
    vehicleGroup = json["vehicleGroup"] ?? [];
    inactiveDate = json["inactiveDate"];
    inductionDate = json["inductionDate"];
    inductionType = json["inductionType"];
    address = json["address"];
    locality = json["locality"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    dateOfManufacturing = json["dateOfManufacturing"];
    listOfTrips = json["listOfTrips"] ?? [];
    registrationCertificate = json["registrationCertificate"];
    registrationCertificateExpiration = json["registrationCertificateExpiration"];
    insurancePaper = json["insurancePaper"];
    insurancePaperExpiration = json["insurancePaperExpiration"];
    taxReceipt = json["taxReceipt"];
    taxReceiptExpiration = json["taxReceiptExpiration"];
    permit = json["permit"];
    permitExpiration = json["permitExpiration"];
    pucExpiration = json["pucExpiration"];
    fitnessCertificateExpiration = json["fitnessCertificateExpiration"];
    driverAssignedOn = json["driverAssignedOn"];
    listOfPastDrivers = json["listOfPastDrivers"] ?? [];
    lastServiced = json["lastServiced"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["vehicleType"] = vehicleType;
    _data["vehicleMake"] = vehicleMake;
    _data["vehicleModel"] = vehicleModel;
    _data["vehicleNumber"] = vehicleNumber;
    _data["vehicleCapacity"] = vehicleCapacity;
    _data["status"] = status;
    _data["fuelType"] = fuelType;
    _data["chassisNumber"] = chassisNumber;
    _data["vendor"] = vendor;
    if(vehicleGroup != null) {
      _data["vehicleGroup"] = vehicleGroup;
    }
    _data["inactiveDate"] = inactiveDate;
    _data["inductionDate"] = inductionDate;
    _data["inductionType"] = inductionType;
    _data["address"] = address;
    _data["locality"] = locality;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["dateOfManufacturing"] = dateOfManufacturing;
    if(listOfTrips != null) {
      _data["listOfTrips"] = listOfTrips;
    }
    _data["registrationCertificate"] = registrationCertificate;
    _data["registrationCertificateExpiration"] = registrationCertificateExpiration;
    _data["insurancePaper"] = insurancePaper;
    _data["insurancePaperExpiration"] = insurancePaperExpiration;
    _data["taxReceipt"] = taxReceipt;
    _data["taxReceiptExpiration"] = taxReceiptExpiration;
    _data["permit"] = permit;
    _data["permitExpiration"] = permitExpiration;
    _data["pucExpiration"] = pucExpiration;
    _data["fitnessCertificateExpiration"] = fitnessCertificateExpiration;
    _data["driverAssignedOn"] = driverAssignedOn;
    if(listOfPastDrivers != null) {
      _data["listOfPastDrivers"] = listOfPastDrivers;
    }
    _data["lastServiced"] = lastServiced;
    _data["__v"] = v;
    return _data;
  }
}


class VehicleCapacity {
  String? id;
  String? vehicleModel;
  int? vehicleCapacity;
  String? vendor;
  String? vendorName;

  VehicleCapacity({this.id, this.vehicleModel, this.vehicleCapacity, this.vendor, this.vendorName});

  VehicleCapacity.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    vehicleModel = json["vehicleModel"];
    vehicleCapacity = json["vehicleCapacity"];
    vendor = json["vendor"];
    vendorName = json["vendorName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["vehicleModel"] = vehicleModel;
    _data["vehicleCapacity"] = vehicleCapacity;
    _data["vendor"] = vendor;
    _data["vendorName"] = vendorName;
    return _data;
  }
}






