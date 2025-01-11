
class RouteListModel {
  String? zone;
  String? vehicleId;
  List<AssignedEmployees>? assignedEmployees;
  int? vehicleCapacity;
  String? tripType;
  String? vendorId;
  String? vendorName;
  String? driverId;
  String? driverName;
  String? vehicleNumber;

  RouteListModel({this.zone, this.vehicleId, this.assignedEmployees, this.vehicleCapacity, this.tripType, this.vendorId, this.vendorName, this.driverId, this.driverName, this.vehicleNumber});

  RouteListModel.fromJson(Map<String, dynamic> json) {
    zone = json["zone"];
    vehicleId = json["vehicle_id"];
    assignedEmployees = json["assigned_employees"] == null ? null : (json["assigned_employees"] as List).map((e) => AssignedEmployees.fromJson(e)).toList();
    vehicleCapacity = json["vehicle_capacity"];
    tripType = json["trip_type"];
    vendorId = json["vendor_id"];
    vendorName = json["vendor_name"];
    driverId = json["driver_id"];
    driverName = json["driver_name"];
    vehicleNumber = json["vehicle_number"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["zone"] = zone;
    _data["vehicle_id"] = vehicleId;
    if(assignedEmployees != null) {
      _data["assigned_employees"] = assignedEmployees?.map((e) => e.toJson()).toList();
    }
    _data["vehicle_capacity"] = vehicleCapacity;
    _data["trip_type"] = tripType;
    _data["vendor_id"] = vendorId;
    _data["vendor_name"] = vendorName;
    _data["driver_id"] = driverId;
    _data["driver_name"] = driverName;
    _data["vehicle_number"] = vehicleNumber;
    return _data;
  }
}

class AssignedEmployees {
  String? id;
  Company? company;
  Employee? employee;
  String? date;
  Shift? shift;
  NodalPoint? nodalPoint;
  HomeLocation? homeLocation;
  Office? office;
  String? tripType;
  String? createdAt;
  String? updatedAt;
  int? v;

  AssignedEmployees({this.id, this.company, this.employee, this.date, this.shift, this.nodalPoint, this.homeLocation, this.office, this.tripType, this.createdAt, this.updatedAt, this.v});

  AssignedEmployees.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    company = json["company"] == null ? null : Company.fromJson(json["company"]);
    employee = json["employee"] == null ? null : Employee.fromJson(json["employee"]);
    date = json["date"];
    shift = json["shift"] == null ? null : Shift.fromJson(json["shift"]);
    nodalPoint = json["nodalPoint"] == null ? null : NodalPoint.fromJson(json["nodalPoint"]);
    homeLocation = json["homeLocation"] == null ? null : HomeLocation.fromJson(json["homeLocation"]);
    office = json["office"] == null ? null : Office.fromJson(json["office"]);
    tripType = json["tripType"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    if(company != null) {
      _data["company"] = company?.toJson();
    }
    if(employee != null) {
      _data["employee"] = employee?.toJson();
    }
    _data["date"] = date;
    if(shift != null) {
      _data["shift"] = shift?.toJson();
    }
    if(nodalPoint != null) {
      _data["nodalPoint"] = nodalPoint?.toJson();
    }
    if(homeLocation != null) {
      _data["homeLocation"] = homeLocation?.toJson();
    }
    if(office != null) {
      _data["office"] = office?.toJson();
    }
    _data["tripType"] = tripType;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}

class Office {
  String? id;
  String? address;

  Office({this.id, this.address});

  Office.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    address = json["address"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["address"] = address;
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

class NodalPoint {
  String? id;
  String? address;
  double? latitude;
  double? longitude;
  double? distanceFromCompany;
  String? zone;
  String? nodalPointName;

  NodalPoint({this.id, this.address, this.latitude, this.longitude, this.distanceFromCompany, this.zone, this.nodalPointName});

  NodalPoint.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    address = json["address"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    distanceFromCompany = json["distanceFromCompany"];
    zone = json["zone"];
    nodalPointName = json["nodalPointName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["address"] = address;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["distanceFromCompany"] = distanceFromCompany;
    _data["zone"] = zone;
    _data["nodalPointName"] = nodalPointName;
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

class Employee {
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? contactNumber;
  String? gender;

  Employee({this.id, this.firstName, this.middleName, this.lastName, this.contactNumber, this.gender});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    firstName = json["firstName"];
    middleName = json["middleName"];
    lastName = json["lastName"];
    contactNumber = json["contactNumber"];
    gender = json["gender"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["firstName"] = firstName;
    _data["middleName"] = middleName;
    _data["lastName"] = lastName;
    _data["contactNumber"] = contactNumber;
    _data["gender"] = gender;
    return _data;
  }
}

class Company {
  String? id;
  String? registeredAddress;

  Company({this.id, this.registeredAddress});

  Company.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    registeredAddress = json["registeredAddress"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["registeredAddress"] = registeredAddress;
    return _data;
  }
}
