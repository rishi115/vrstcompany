
class RoasterModel {
  List<Routes>? routes;
  List<Rosters>? rosters;

  RoasterModel({this.routes, this.rosters});

  RoasterModel.fromJson(Map<String, dynamic> json) {
    routes = json["routes"] == null ? null : (json["routes"] as List).map((e) => Routes.fromJson(e)).toList();
    rosters = json["rosters"] == null ? null : (json["rosters"] as List).map((e) => Rosters.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(routes != null) {
      _data["routes"] = routes?.map((e) => e.toJson()).toList();
    }
    if(rosters != null) {
      _data["rosters"] = rosters?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Rosters {
  String? id;
  String? company;
  String? employee;
  String? date;
  String? shift;
  String? nodalPoint;
  HomeLocation? homeLocation;
  PickupLocation1? pickupLocation;
  DropLocation1? dropLocation;
  String? office;
  String? zone;
  String? tripType;
  double? distanceFromCompany;
  bool? tampered;
  String? employeeName;
  String? disability;
  String? employeeAddress;
  String? employeeGender;
  String? employeeContactNumber;
  String? nodalAddress;
  String? nodalPointName;
  NodalLocation? nodalLocation;
  String? createdAt;
  String? updatedAt;
  int? v;
  bool? routeMade;

  Rosters({this.id, this.company, this.employee, this.date, this.shift, this.nodalPoint, this.homeLocation, this.pickupLocation, this.dropLocation, this.office, this.zone, this.tripType, this.distanceFromCompany, this.tampered, this.employeeName, this.disability, this.employeeAddress, this.employeeGender, this.employeeContactNumber, this.nodalAddress, this.nodalPointName, this.nodalLocation, this.createdAt, this.updatedAt, this.v, this.routeMade});

  Rosters.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    company = json["company"];
    employee = json["employee"];
    date = json["date"];
    shift = json["shift"];
    nodalPoint = json["nodalPoint"];
    homeLocation = json["homeLocation"] == null ? null : HomeLocation.fromJson(json["homeLocation"]);
    pickupLocation = json["pickupLocation"] == null ? null : PickupLocation1.fromJson(json["pickupLocation"]);
    dropLocation = json["dropLocation"] == null ? null : DropLocation1.fromJson(json["dropLocation"]);
    office = json["office"];
    zone = json["zone"];
    tripType = json["tripType"];
    distanceFromCompany = json["distanceFromCompany"];
    tampered = json["tampered"];
    employeeName = json["employeeName"];
    disability = json["disability"];
    employeeAddress = json["employeeAddress"];
    employeeGender = json["employeeGender"];
    employeeContactNumber = json["employeeContactNumber"];
    nodalAddress = json["nodalAddress"];
    nodalPointName = json["nodalPointName"];
    nodalLocation = json["nodalLocation"] == null ? null : NodalLocation.fromJson(json["nodalLocation"]);
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
    routeMade = json["routeMade"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["company"] = company;
    _data["employee"] = employee;
    _data["date"] = date;
    _data["shift"] = shift;
    _data["nodalPoint"] = nodalPoint;
    if(homeLocation != null) {
      _data["homeLocation"] = homeLocation?.toJson();
    }
    if(pickupLocation != null) {
      _data["pickupLocation"] = pickupLocation?.toJson();
    }
    if(dropLocation != null) {
      _data["dropLocation"] = dropLocation?.toJson();
    }
    _data["office"] = office;
    _data["zone"] = zone;
    _data["tripType"] = tripType;
    _data["distanceFromCompany"] = distanceFromCompany;
    _data["tampered"] = tampered;
    _data["employeeName"] = employeeName;
    _data["disability"] = disability;
    _data["employeeAddress"] = employeeAddress;
    _data["employeeGender"] = employeeGender;
    _data["employeeContactNumber"] = employeeContactNumber;
    _data["nodalAddress"] = nodalAddress;
    _data["nodalPointName"] = nodalPointName;
    if(nodalLocation != null) {
      _data["nodalLocation"] = nodalLocation?.toJson();
    }
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    _data["routeMade"] = routeMade;
    return _data;
  }
}

class NodalLocation {
  double? latitude;
  double? longitude;
  String? id;

  NodalLocation({this.latitude, this.longitude, this.id});

  NodalLocation.fromJson(Map<String, dynamic> json) {
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

class DropLocation1 {
  double? latitude;
  double? longitude;
  String? id;

  DropLocation1({this.latitude, this.longitude, this.id});

  DropLocation1.fromJson(Map<String, dynamic> json) {
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

class PickupLocation1 {
  double? latitude;
  double? longitude;
  String? id;

  PickupLocation1({this.latitude, this.longitude, this.id});

  PickupLocation1.fromJson(Map<String, dynamic> json) {
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

class HomeLocation {
  double? latitude;
  double? longitude;
  String? id;

  HomeLocation({this.latitude, this.longitude, this.id});

  HomeLocation.fromJson(Map<String, dynamic> json) {
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

class Routes {
  String? id;
  List<Employees>? employees;
  String? startPoint;
  String? endPoint;
  String? shift;
  String? date;
  String? vendor;
  String? vendorName;
  String? vehicle;
  String? vehicleNumber;
  bool? driverAssignedByVendor;
  bool? vehicleAssignedByVendor;
  String? driver;
  String? driverName;
  int? employeeCount;
  String? tripType;
  String? office;
  String? company;
  bool? visibleToVendor;
  bool? published;
  int? vehicleCapacity;
  bool? locked;
  bool? tampered;
  int? estimatedDuration;
  int? actualDuration;
  int? v;

  Routes({this.id, this.employees, this.startPoint, this.endPoint, this.shift, this.date, this.vendor, this.vendorName, this.vehicle, this.vehicleNumber, this.driverAssignedByVendor, this.vehicleAssignedByVendor, this.driver, this.driverName, this.employeeCount, this.tripType, this.office, this.company, this.visibleToVendor, this.published, this.vehicleCapacity, this.locked, this.tampered, this.estimatedDuration, this.actualDuration, this.v});

  Routes.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    employees = json["employees"] == null ? null : (json["employees"] as List).map((e) => Employees.fromJson(e)).toList();
    startPoint = json["startPoint"];
    endPoint = json["endPoint"];
    shift = json["shift"];
    date = json["date"];
    vendor = json["vendor"];
    vendorName = json["vendorName"];
    vehicle = json["vehicle"];
    vehicleNumber = json["vehicleNumber"];
    driverAssignedByVendor = json["driverAssignedByVendor"];
    vehicleAssignedByVendor = json["vehicleAssignedByVendor"];
    driver = json["driver"];
    driverName = json["driverName"];
    employeeCount = json["employeeCount"];
    tripType = json["tripType"];
    office = json["office"];
    company = json["company"];
    visibleToVendor = json["visibleToVendor"];
    published = json["published"];
    vehicleCapacity = json["vehicleCapacity"];
    locked = json["locked"];
    tampered = json["tampered"];
    estimatedDuration = json["estimatedDuration"];
    actualDuration = json["actualDuration"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    if(employees != null) {
      _data["employees"] = employees?.map((e) => e.toJson()).toList();
    }
    _data["startPoint"] = startPoint;
    _data["endPoint"] = endPoint;
    _data["shift"] = shift;
    _data["date"] = date;
    _data["vendor"] = vendor;
    _data["vendorName"] = vendorName;
    _data["vehicle"] = vehicle;
    _data["vehicleNumber"] = vehicleNumber;
    _data["driverAssignedByVendor"] = driverAssignedByVendor;
    _data["vehicleAssignedByVendor"] = vehicleAssignedByVendor;
    _data["driver"] = driver;
    _data["driverName"] = driverName;
    _data["employeeCount"] = employeeCount;
    _data["tripType"] = tripType;
    _data["office"] = office;
    _data["company"] = company;
    _data["visibleToVendor"] = visibleToVendor;
    _data["published"] = published;
    _data["vehicleCapacity"] = vehicleCapacity;
    _data["locked"] = locked;
    _data["tampered"] = tampered;
    _data["estimatedDuration"] = estimatedDuration;
    _data["actualDuration"] = actualDuration;
    _data["__v"] = v;
    return _data;
  }
}

class Employees {
  String? employeeId;
  String? employeeName;
  String? gender;
  String? nodalId;
  String? nodalName;
  double? nodalLat;
  double? nodalLng;
  double? nodalDistance;
  String? nodalZone;
  double? homeLat;
  double? homeLng;
  PickupLocation? pickupLocation;
  DropLocation? dropLocation;
  String? pickupTime;
  String? dropTime;
  String? phoneNumber;
  bool? attendance;
  String? rosterId;
  String? id;

  Employees({this.employeeId, this.employeeName, this.gender, this.nodalId, this.nodalName, this.nodalLat, this.nodalLng, this.nodalDistance, this.nodalZone, this.homeLat, this.homeLng, this.pickupLocation, this.dropLocation, this.pickupTime, this.dropTime, this.phoneNumber, this.attendance, this.rosterId, this.id});

  Employees.fromJson(Map<String, dynamic> json) {
    employeeId = json["employeeId"];
    employeeName = json["employeeName"];
    gender = json["gender"];
    nodalId = json["nodalId"];
    nodalName = json["nodalName"];
    nodalLat = json["nodalLat"];
    nodalLng = json["nodalLng"];
    nodalDistance = json["nodalDistance"];
    nodalZone = json["nodalZone"];
    homeLat = json["homeLat"];
    homeLng = json["homeLng"];
    pickupLocation = json["pickupLocation"] == null ? null : PickupLocation.fromJson(json["pickupLocation"]);
    dropLocation = json["dropLocation"] == null ? null : DropLocation.fromJson(json["dropLocation"]);
    pickupTime = json["pickupTime"];
    dropTime = json["dropTime"];
    phoneNumber = json["phoneNumber"];
    attendance = json["attendance"];
    rosterId = json["rosterId"];
    id = json["_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["employeeId"] = employeeId;
    _data["employeeName"] = employeeName;
    _data["gender"] = gender;
    _data["nodalId"] = nodalId;
    _data["nodalName"] = nodalName;
    _data["nodalLat"] = nodalLat;
    _data["nodalLng"] = nodalLng;
    _data["nodalDistance"] = nodalDistance;
    _data["nodalZone"] = nodalZone;
    _data["homeLat"] = homeLat;
    _data["homeLng"] = homeLng;
    if(pickupLocation != null) {
      _data["pickupLocation"] = pickupLocation?.toJson();
    }
    if(dropLocation != null) {
      _data["dropLocation"] = dropLocation?.toJson();
    }
    _data["pickupTime"] = pickupTime;
    _data["dropTime"] = dropTime;
    _data["phoneNumber"] = phoneNumber;
    _data["attendance"] = attendance;
    _data["rosterId"] = rosterId;
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