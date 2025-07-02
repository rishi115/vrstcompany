
class TripByDate {
  String? id;
  Shift? shift;
  String? date;
  bool? isGuard;
  bool? isGuardLoggedIn;
  int? capacity;
  String? approxStartTime;
  String? approxEndTime;
  List<ListOfEmployees>? listOfEmployees;
  String? tripType;
  String? vendor;
  Vehicle? vehicle;
  String? company;
  Driver? driver;
  dynamic guard;
  Office? office;
  bool? started;
  String? startDateTime;
  String? endDateTime;
  String? status;
  List<ProvidedRoute>? providedRoute;
  List<dynamic>? travelledRoute;
  int? ota;
  int? otd;
  String? driverName;
  String? vehicleNumber;
  String? createdAt;
  String? updatedAt;
  int? v;

  TripByDate({this.id, this.shift, this.date, this.isGuard, this.isGuardLoggedIn, this.capacity, this.approxStartTime, this.approxEndTime, this.listOfEmployees, this.tripType, this.vendor, this.vehicle, this.company, this.driver, this.guard, this.office, this.started, this.startDateTime, this.endDateTime, this.status, this.providedRoute, this.travelledRoute, this.ota, this.otd, this.driverName, this.vehicleNumber, this.createdAt, this.updatedAt, this.v});

  TripByDate.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    shift = json["shift"] == null ? null : Shift.fromJson(json["shift"]);
    date = json["date"];
    isGuard = json["isGuard"];
    isGuardLoggedIn = json["isGuardLoggedIn"];
    capacity = json["capacity"];
    approxStartTime = json["approxStartTime"];
    approxEndTime = json["approxEndTime"];
    listOfEmployees = json["listOfEmployees"] == null ? null : (json["listOfEmployees"] as List).map((e) => ListOfEmployees.fromJson(e)).toList();
    tripType = json["tripType"];
    vendor = json["vendor"];
    vehicle = json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]);
    company = json["company"];
    driver = json["driver"] == null ? null : Driver.fromJson(json["driver"]);
    guard = json["guard"];
    office = json["office"] == null ? null : Office.fromJson(json["office"]);
    started = json["started"];
    startDateTime = json["startDateTime"];
    endDateTime = json["endDateTime"];
    status = json["status"];
    providedRoute = json["providedRoute"] == null ? null : (json["providedRoute"] as List).map((e) => ProvidedRoute.fromJson(e)).toList();
    travelledRoute = json["travelledRoute"] ?? [];
    ota = json["ota"];
    otd = json["otd"];
    driverName = json["driverName"];
    vehicleNumber = json["vehicleNumber"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    if(shift != null) {
      _data["shift"] = shift?.toJson();
    }
    _data["date"] = date;
    _data["isGuard"] = isGuard;
    _data["isGuardLoggedIn"] = isGuardLoggedIn;
    _data["capacity"] = capacity;
    _data["approxStartTime"] = approxStartTime;
    _data["approxEndTime"] = approxEndTime;
    if(listOfEmployees != null) {
      _data["listOfEmployees"] = listOfEmployees?.map((e) => e.toJson()).toList();
    }
    _data["tripType"] = tripType;
    _data["vendor"] = vendor;
    if(vehicle != null) {
      _data["vehicle"] = vehicle?.toJson();
    }
    _data["company"] = company;
    if(driver != null) {
      _data["driver"] = driver?.toJson();
    }
    _data["guard"] = guard;
    if(office != null) {
      _data["office"] = office?.toJson();
    }
    _data["started"] = started;
    _data["startDateTime"] = startDateTime;
    _data["endDateTime"] = endDateTime;
    _data["status"] = status;
    if(providedRoute != null) {
      _data["providedRoute"] = providedRoute?.map((e) => e.toJson()).toList();
    }
    if(travelledRoute != null) {
      _data["travelledRoute"] = travelledRoute;
    }
    _data["ota"] = ota;
    _data["otd"] = otd;
    _data["driverName"] = driverName;
    _data["vehicleNumber"] = vehicleNumber;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}

class ProvidedRoute {
  double? lat;
  double? lng;

  ProvidedRoute({this.lat, this.lng});

  ProvidedRoute.fromJson(Map<String, dynamic> json) {
    lat = json["lat"];
    lng = json["lng"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["lat"] = lat;
    _data["lng"] = lng;
    return _data;
  }
}

class Office {
  String? id;
  String? name;
  double? latitude;
  double? longitude;
  String? address;

  Office({this.id, this.name, this.latitude, this.longitude, this.address});

  Office.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    address = json["address"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["address"] = address;
    return _data;
  }
}

class Driver {
  String? id;
  String? contactNumber;
  String? gender;
  String? dob;

  Driver({this.id, this.contactNumber, this.gender, this.dob});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    contactNumber = json["contactNumber"];
    gender = json["gender"];
    dob = json["dob"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["contactNumber"] = contactNumber;
    _data["gender"] = gender;
    _data["dob"] = dob;
    return _data;
  }
}

class Vehicle {
  String? id;
  String? vehicleType;
  String? vehicleModel;

  Vehicle({this.id, this.vehicleType, this.vehicleModel});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    vehicleType = json["vehicleType"];
    vehicleModel = json["vehicleModel"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["vehicleType"] = vehicleType;
    _data["vehicleModel"] = vehicleModel;
    return _data;
  }
}

class ListOfEmployees {
  String? employeeId;
  String? employeeName;
  String? gender;
  String? nodalId;
  String? nodalName;
  String? nodalAddress;
  double? nodalLat;
  double? nodalLng;
  int? nodalDistance;
  double? homeLat;
  int? otp;
  double? homeLng;
  dynamic nodalZone;
  String? pickupTime;
  PickupLocation? pickupLocation;
  DropLocation? dropLocation;
  String? phoneNumber;
  String? status;
  String? id;

  ListOfEmployees({this.employeeId, this.employeeName, this.gender, this.nodalId, this.nodalName, this.nodalAddress, this.nodalLat, this.nodalLng, this.nodalDistance, this.homeLat, this.otp, this.homeLng, this.nodalZone, this.pickupTime, this.pickupLocation, this.dropLocation, this.phoneNumber, this.status, this.id});

  ListOfEmployees.fromJson(Map<String, dynamic> json) {
    employeeId = json["employeeId"];
    employeeName = json["employeeName"];
    gender = json["gender"];
    nodalId = json["nodalId"];
    nodalName = json["nodalName"];
    nodalAddress = json["nodalAddress"];
    nodalLat = json["nodalLat"];
    nodalLng = json["nodalLng"];
    nodalDistance = json["nodalDistance"];
    homeLat = json["homeLat"];
    otp = json["otp"];
    homeLng = json["homeLng"];
    nodalZone = json["nodalZone"];
    pickupTime = json["pickupTime"];
    pickupLocation = json["pickupLocation"] == null ? null : PickupLocation.fromJson(json["pickupLocation"]);
    dropLocation = json["dropLocation"] == null ? null : DropLocation.fromJson(json["dropLocation"]);
    phoneNumber = json["phoneNumber"];
    status = json["status"];
    id = json["_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["employeeId"] = employeeId;
    _data["employeeName"] = employeeName;
    _data["gender"] = gender;
    _data["nodalId"] = nodalId;
    _data["nodalName"] = nodalName;
    _data["nodalAddress"] = nodalAddress;
    _data["nodalLat"] = nodalLat;
    _data["nodalLng"] = nodalLng;
    _data["nodalDistance"] = nodalDistance;
    _data["homeLat"] = homeLat;
    _data["otp"] = otp;
    _data["homeLng"] = homeLng;
    _data["nodalZone"] = nodalZone;
    _data["pickupTime"] = pickupTime;
    if(pickupLocation != null) {
      _data["pickupLocation"] = pickupLocation?.toJson();
    }
    if(dropLocation != null) {
      _data["dropLocation"] = dropLocation?.toJson();
    }
    _data["phoneNumber"] = phoneNumber;
    _data["status"] = status;
    _data["_id"] = id;
    return _data;
  }
}

class DropLocation {
  double? latitude;
  double? longitude;
  String? id;

  DropLocation({this.latitude, this.longitude, this.id});

  DropLocation.fromJson(Map<String, dynamic> json) {
    latitude = json["latitude"];
    longitude = json["longitude"];
    id = json["_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["_id"] = id;
    return _data;
  }
}

class PickupLocation {
  double? latitude;
  double? longitude;
  String? id;

  PickupLocation({this.latitude, this.longitude, this.id});

  PickupLocation.fromJson(Map<String, dynamic> json) {
    latitude = json["latitude"];
    longitude = json["longitude"];
    id = json["_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["_id"] = id;
    return _data;
  }
}

class Shift {
  String? id;
  String? loginTime;
  String? logoutTime;
  String? tripType;
  String? company;
  int? v;

  Shift({this.id, this.loginTime, this.logoutTime, this.tripType, this.company, this.v});

  Shift.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    loginTime = json["loginTime"];
    logoutTime = json["logoutTime"];
    tripType = json["tripType"];
    company = json["company"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["loginTime"] = loginTime;
    _data["logoutTime"] = logoutTime;
    _data["tripType"] = tripType;
    _data["company"] = company;
    _data["__v"] = v;
    return _data;
  }
}