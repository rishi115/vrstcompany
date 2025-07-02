
class TripDriverLoc {
  List<Drivers>? drivers;
  List<Trips>? trips;

  TripDriverLoc({this.drivers, this.trips});

  TripDriverLoc.fromJson(Map<String, dynamic> json) {
    drivers = json["drivers"] == null ? null : (json["drivers"] as List).map((e) => Drivers.fromJson(e)).toList();
    trips = json["trips"] == null ? null : (json["trips"] as List).map((e) => Trips.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(drivers != null) {
      _data["drivers"] = drivers?.map((e) => e.toJson()).toList();
    }
    if(trips != null) {
      _data["trips"] = trips?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Trips {
  String? tripId;
  String? status;
  String? vehicleNumber;
  Driver? driver;
  List<Employees>? employees;

  Trips({this.tripId, this.status, this.vehicleNumber, this.driver, this.employees});

  Trips.fromJson(Map<String, dynamic> json) {
    tripId = json["tripId"];
    status = json["status"];
    vehicleNumber = json["vehicleNumber"];
    driver = json["driver"] == null ? null : Driver.fromJson(json["driver"]);
    employees = json["employees"] == null ? null : (json["employees"] as List).map((e) => Employees.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["tripId"] = tripId;
    _data["status"] = status;
    _data["vehicleNumber"] = vehicleNumber;
    if(driver != null) {
      _data["driver"] = driver?.toJson();
    }
    if(employees != null) {
      _data["employees"] = employees?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Employees {
  String? name;
  String? status;
  bool? isAbsent;

  Employees({this.name, this.status, this.isAbsent});

  Employees.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    status = json["status"];
    isAbsent = json["isAbsent"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["status"] = status;
    _data["isAbsent"] = isAbsent;
    return _data;
  }
}

class Driver {
  String? name;
  Location? location;

  Driver({this.name, this.location});

  Driver.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    location = json["location"] == null ? null : Location.fromJson(json["location"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    if(location != null) {
      _data["location"] = location?.toJson();
    }
    return _data;
  }
}

class Location {
  Location();

  Location.fromJson(Map<String, dynamic> json) {

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};

    return _data;
  }
}

class Drivers {
  String? driverId;
  double? latitude;
  double? longitude;

  Drivers({this.driverId, this.latitude, this.longitude});

  Drivers.fromJson(Map<String, dynamic> json) {
    driverId = json["driverId"];
    latitude = json["latitude"];
    longitude = json["longitude"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["driverId"] = driverId;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    return _data;
  }
}