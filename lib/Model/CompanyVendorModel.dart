
class CompanyModelVendor {
  String? companyId;
  String? companyName;
  String? registeredAddress;
  String? primaryContactNumber;
  int? vehicleCount;

  CompanyModelVendor({this.companyId, this.companyName, this.registeredAddress, this.primaryContactNumber, this.vehicleCount});

  CompanyModelVendor.fromJson(Map<String, dynamic> json) {
    companyId = json["companyId"];
    companyName = json["companyName"];
    registeredAddress = json["registeredAddress"];
    primaryContactNumber = json["primaryContactNumber"];
    vehicleCount = json["vehicleCount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["companyId"] = companyId;
    _data["companyName"] = companyName;
    _data["registeredAddress"] = registeredAddress;
    _data["primaryContactNumber"] = primaryContactNumber;
    _data["vehicleCount"] = vehicleCount;
    return _data;
  }
}


class CompanyModel {
  List<dynamic>? listOfDrivers;
  String? id;
  String? companyName;
  String? registeredAddress;
  String? city;
  String? state;
  int? pincode;
  String? companySize;
  String? primaryContactName;
  String? primaryContactDesignation;
  String? primaryContactNumber;
  String? primaryContactEmail;
  String? gstin;
  String? pan;
  String? companyEmail;
  String? role;
  String? secondaryContactName;
  String? secondaryContactDesignation;
  String? secondaryContactNumber;
  String? secondaryContactEmail;
  String? businessType;
  bool? disabled;
  List<ListOfVehicles>? listOfVehicles;
  List<dynamic>? listOfTrips;
  List<dynamic>? listOfTeams;
  List<String>? listOfNodalPoints;
  List<String>? listOfOffices;
  List<String>? listOfShifts;
  List<dynamic>? listOfRosters;
  List<dynamic>? listOfGuards;
  List<String>? listOfEmployees;
  List<ListOfVendors>? listOfVendors;

  CompanyModel({this.listOfDrivers, this.id, this.companyName, this.registeredAddress, this.city, this.state, this.pincode, this.companySize, this.primaryContactName, this.primaryContactDesignation, this.primaryContactNumber, this.primaryContactEmail, this.gstin, this.pan, this.companyEmail, this.role, this.secondaryContactName, this.secondaryContactDesignation, this.secondaryContactNumber, this.secondaryContactEmail, this.businessType, this.disabled, this.listOfVehicles, this.listOfTrips, this.listOfTeams, this.listOfNodalPoints, this.listOfOffices, this.listOfShifts, this.listOfRosters, this.listOfGuards, this.listOfEmployees, this.listOfVendors});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    listOfDrivers = json["listOfDrivers"] ?? [];
    id = json["_id"];
    companyName = json["companyName"];
    registeredAddress = json["registeredAddress"];
    city = json["city"];
    state = json["state"];
    pincode = json["pincode"];
    companySize = json["companySize"];
    primaryContactName = json["primaryContactName"];
    primaryContactDesignation = json["primaryContactDesignation"];
    primaryContactNumber = json["primaryContactNumber"];
    primaryContactEmail = json["primaryContactEmail"];
    gstin = json["gstin"];
    pan = json["pan"];
    companyEmail = json["companyEmail"];
    role = json["role"];
    secondaryContactName = json["secondaryContactName"];
    secondaryContactDesignation = json["secondaryContactDesignation"];
    secondaryContactNumber = json["secondaryContactNumber"];
    secondaryContactEmail = json["secondaryContactEmail"];
    businessType = json["businessType"];
    disabled = json["disabled"];
    listOfVehicles = json["listOfVehicles"] == null ? null : (json["listOfVehicles"] as List).map((e) => ListOfVehicles.fromJson(e)).toList();
    listOfTrips = json["listOfTrips"] ?? [];
    listOfTeams = json["listOfTeams"] ?? [];
    listOfNodalPoints = json["listOfNodalPoints"] == null ? null : List<String>.from(json["listOfNodalPoints"]);
    listOfOffices = json["listOfOffices"] == null ? null : List<String>.from(json["listOfOffices"]);
    listOfShifts = json["listOfShifts"] == null ? null : List<String>.from(json["listOfShifts"]);
    listOfRosters = json["listOfRosters"] ?? [];
    listOfGuards = json["listOfGuards"] ?? [];
    listOfEmployees = json["listOfEmployees"] == null ? null : List<String>.from(json["listOfEmployees"]);
    listOfVendors = json["listOfVendors"] == null ? null : (json["listOfVendors"] as List).map((e) => ListOfVendors.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(listOfDrivers != null) {
      _data["listOfDrivers"] = listOfDrivers;
    }
    _data["_id"] = id;
    _data["companyName"] = companyName;
    _data["registeredAddress"] = registeredAddress;
    _data["city"] = city;
    _data["state"] = state;
    _data["pincode"] = pincode;
    _data["companySize"] = companySize;
    _data["primaryContactName"] = primaryContactName;
    _data["primaryContactDesignation"] = primaryContactDesignation;
    _data["primaryContactNumber"] = primaryContactNumber;
    _data["primaryContactEmail"] = primaryContactEmail;
    _data["gstin"] = gstin;
    _data["pan"] = pan;
    _data["companyEmail"] = companyEmail;
    _data["role"] = role;
    _data["secondaryContactName"] = secondaryContactName;
    _data["secondaryContactDesignation"] = secondaryContactDesignation;
    _data["secondaryContactNumber"] = secondaryContactNumber;
    _data["secondaryContactEmail"] = secondaryContactEmail;
    _data["businessType"] = businessType;
    _data["disabled"] = disabled;
    if(listOfVehicles != null) {
      _data["listOfVehicles"] = listOfVehicles?.map((e) => e.toJson()).toList();
    }
    if(listOfTrips != null) {
      _data["listOfTrips"] = listOfTrips;
    }
    if(listOfTeams != null) {
      _data["listOfTeams"] = listOfTeams;
    }
    if(listOfNodalPoints != null) {
      _data["listOfNodalPoints"] = listOfNodalPoints;
    }
    if(listOfOffices != null) {
      _data["listOfOffices"] = listOfOffices;
    }
    if(listOfShifts != null) {
      _data["listOfShifts"] = listOfShifts;
    }
    if(listOfRosters != null) {
      _data["listOfRosters"] = listOfRosters;
    }
    if(listOfGuards != null) {
      _data["listOfGuards"] = listOfGuards;
    }
    if(listOfEmployees != null) {
      _data["listOfEmployees"] = listOfEmployees;
    }
    if(listOfVendors != null) {
      _data["listOfVendors"] = listOfVendors?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ListOfVendors {
  String? id;
  String? vendorName;
  String? address;
  int? pincode;
  int? vehicleCount;
  int? driverCount;

  ListOfVendors({this.id, this.vendorName, this.address, this.pincode, this.vehicleCount, this.driverCount});

  ListOfVendors.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    vendorName = json["vendorName"];
    address = json["address"];
    pincode = json["pincode"];
    vehicleCount = json["vehicleCount"];
    driverCount = json["driverCount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["vendorName"] = vendorName;
    _data["address"] = address;
    _data["pincode"] = pincode;
    _data["vehicleCount"] = vehicleCount;
    _data["driverCount"] = driverCount;
    return _data;
  }
}

class ListOfVehicles {
  String? id;
  String? vehicleModel;
  String? vehicleNumber;
  int? vehicleCapacity;
  String? driverAssignedOn;
  String? driver;

  ListOfVehicles({this.id, this.vehicleModel, this.vehicleNumber, this.vehicleCapacity, this.driverAssignedOn, this.driver});

  ListOfVehicles.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    vehicleModel = json["vehicleModel"];
    vehicleNumber = json["vehicleNumber"];
    vehicleCapacity = json["vehicleCapacity"];
    driverAssignedOn = json["driverAssignedOn"];
    driver = json["driver"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["vehicleModel"] = vehicleModel;
    _data["vehicleNumber"] = vehicleNumber;
    _data["vehicleCapacity"] = vehicleCapacity;
    _data["driverAssignedOn"] = driverAssignedOn;
    _data["driver"] = driver;
    return _data;
  }
}