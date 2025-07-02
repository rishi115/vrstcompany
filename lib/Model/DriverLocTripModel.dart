
class DriverLoc {
  List<Trips>? trips;

  DriverLoc({this.trips});

  DriverLoc.fromJson(Map<String, dynamic> json) {
    trips = json["trips"] == null ? null : (json["trips"] as List).map((e) => Trips.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(trips != null) {
      _data["trips"] = trips?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Trips {
  String? tripId;
  String? status;
  Guard? guard;
  Vehicle? vehicle;
  Driver? driver;
  List<Employees>? employees;

  Trips({this.tripId, this.status, this.guard, this.vehicle, this.driver, this.employees});

  Trips.fromJson(Map<String, dynamic> json) {
    tripId = json["tripId"];
    status = json["status"];
    guard = json["guard"] == null ? null : Guard.fromJson(json["guard"]);
    vehicle = json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]);
    driver = json["driver"] == null ? null : Driver.fromJson(json["driver"]);
    employees = json["employees"] == null ? null : (json["employees"] as List).map((e) => Employees.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["tripId"] = tripId;
    _data["status"] = status;
    if(guard != null) {
      _data["guard"] = guard?.toJson();
    }
    if(vehicle != null) {
      _data["vehicle"] = vehicle?.toJson();
    }
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
  String? id;
  String? name;
  String? status;
  PickupLocation? pickupLocation;
  DropLocation? dropLocation;
  bool? isAbsent;

  Employees({this.id, this.name, this.status, this.pickupLocation, this.dropLocation, this.isAbsent});

  Employees.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    status = json["status"];
    pickupLocation = json["pickupLocation"] == null ? null : PickupLocation.fromJson(json["pickupLocation"]);
    dropLocation = json["dropLocation"] == null ? null : DropLocation.fromJson(json["dropLocation"]);
    isAbsent = json["isAbsent"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["status"] = status;
    if(pickupLocation != null) {
      _data["pickupLocation"] = pickupLocation?.toJson();
    }
    if(dropLocation != null) {
      _data["dropLocation"] = dropLocation?.toJson();
    }
    _data["isAbsent"] = isAbsent;
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

class Driver {
  String? id;
  String? name;
  Location? location;
  String? phone;

  Driver({this.id, this.name, this.location, this.phone});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    location = json["location"] == null ? null : Location.fromJson(json["location"]);
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    if(location != null) {
      _data["location"] = location?.toJson();
    }
    _data["phone"] = phone;
    return _data;
  }
}

class Location {
  String? driverId;
  double? latitude;
  double? longitude;

  Location({this.driverId, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
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

class Vehicle {
  String? id;
  String? vehicleNumber;
  String? vehicleModel;

  Vehicle({this.id, this.vehicleNumber, this.vehicleModel});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    vehicleNumber = json["vehicleNumber"];
    vehicleModel = json["vehicleModel"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["vehicleNumber"] = vehicleNumber;
    _data["vehicleModel"] = vehicleModel;
    return _data;
  }
}

class Guard {
  String? id;
  String? contact;
  String? name;

  Guard({this.id, this.contact, this.name});

  Guard.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    contact = json["contact"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["contact"] = contact;
    _data["name"] = name;
    return _data;
  }
}