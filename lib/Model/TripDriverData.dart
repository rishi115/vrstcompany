
class TripsDriverData {
  List<Drivers>? drivers;

  TripsDriverData({this.drivers});

  TripsDriverData.fromJson(Map<String, dynamic> json) {
    drivers = json["drivers"] == null ? null : (json["drivers"] as List).map((e) => Drivers.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(drivers != null) {
      _data["drivers"] = drivers?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Drivers {
  String? tripId;
  String? driverName;
  String? startTime;
  String? endTime;
  String? tripStatus;
  String? vehicleNumber;
  String? vehicleId;
  String? employeesPresent;
  List<Employees>? employees;

  Drivers({this.tripId, this.driverName, this.startTime, this.endTime, this.tripStatus, this.vehicleNumber, this.vehicleId, this.employeesPresent, this.employees});

  Drivers.fromJson(Map<String, dynamic> json) {
    tripId = json["tripId"];
    driverName = json["driverName"];
    startTime = json["startTime"];
    endTime = json["endTime"];
    tripStatus = json["tripStatus"];
    vehicleNumber = json["vehicleNumber"];
    vehicleId = json["vehicleId"];
    employeesPresent = json["employeesPresent"];
    employees = json["employees"] == null ? null : (json["employees"] as List).map((e) => Employees.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["tripId"] = tripId;
    _data["driverName"] = driverName;
    _data["startTime"] = startTime;
    _data["endTime"] = endTime;
    _data["tripStatus"] = tripStatus;
    _data["vehicleNumber"] = vehicleNumber;
    _data["vehicleId"] = vehicleId;
    _data["employeesPresent"] = employeesPresent;
    if(employees != null) {
      _data["employees"] = employees?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Employees {
  String? employeeId;
  String? employeeName;
  String? status;

  Employees({this.employeeId, this.employeeName, this.status});

  Employees.fromJson(Map<String, dynamic> json) {
    employeeId = json["employeeId"];
    employeeName = json["employeeName"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["employeeId"] = employeeId;
    _data["employeeName"] = employeeName;
    _data["status"] = status;
    return _data;
  }
}