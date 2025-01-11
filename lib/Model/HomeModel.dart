//
// class VendorDistribution {
//   Distribution? distribution;
//   Summary? summary;
//
//   VendorDistribution({this.distribution, this.summary});
//
//   VendorDistribution.fromJson(Map<String, dynamic> json) {
//     distribution = json["distribution"] == null ? null : Distribution.fromJson(json["distribution"]);
//     summary = json["summary"] == null ? null : Summary.fromJson(json["summary"]);
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     if(distribution != null) {
//       _data["distribution"] = distribution?.toJson();
//     }
//     if(summary != null) {
//       _data["summary"] = summary?.toJson();
//     }
//     return _data;
//   }
// }
// //
// class Summary {
//   int? totalTrips;
//   int? totalVendors;
//   String? topVendor;
//   int? topVendorPercentage;
//
//   Summary({this.totalTrips, this.totalVendors, this.topVendor, this.topVendorPercentage});
//
//   Summary.fromJson(Map<String, dynamic> json) {
//     totalTrips = json["totalTrips"];
//     totalVendors = json["totalVendors"];
//     topVendor = json["topVendor"];
//     topVendorPercentage = json["topVendorPercentage"];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["totalTrips"] = totalTrips;
//     _data["totalVendors"] = totalVendors;
//     _data["topVendor"] = topVendor;
//     _data["topVendorPercentage"] = topVendorPercentage;
//     return _data;
//   }
// }
//
// class Distribution {
//   6766540B6Fe141F4F8899482? 6766540B6Fe141F4F8899482;
//
//   Distribution({this.6766540B6Fe141F4F8899482});
//
//   Distribution.fromJson(Map<String, dynamic> json) {
//   6766540B6Fe141F4F8899482 = json["6766540b6fe141f4f8899482"] == null ? null : 6766540B6Fe141F4F8899482.fromJson(json["6766540b6fe141f4f8899482"]);
//   }
//
//   Map<String, dynamic> toJson() {
//   final Map<String, dynamic> _data = <String, dynamic>{};
//   if(6766540B6Fe141F4F8899482 != null) {
//   _data["6766540b6fe141f4f8899482"] = 6766540B6Fe141F4F8899482?.toJson();
//   }
//   return _data;
//   }
// }
//
// class 6766540B6Fe141F4F8899482 {
// String? name;
// int? count;
// int? percentage;
//
// 6766540B6Fe141F4F8899482({this.name, this.count, this.percentage});
//
// 6766540B6Fe141F4F8899482.fromJson(Map<String, dynamic> json) {
// name = json["name"];
// count = json["count"];
// percentage = json["percentage"];
// }
//
// Map<String, dynamic> toJson() {
// final Map<String, dynamic> _data = <String, dynamic>{};
// _data["name"] = name;
// _data["count"] = count;
// _data["percentage"] = percentage;
// return _data;
// }
// }
//

class TripAnalytics {
  Overview? overview;
  PeriodCounts? periodCounts;

  TripAnalytics({this.overview, this.periodCounts});

  TripAnalytics.fromJson(Map<String, dynamic> json) {
    overview = json["overview"] == null ? null : Overview.fromJson(json["overview"]);
    periodCounts = json["periodCounts"] == null ? null : PeriodCounts.fromJson(json["periodCounts"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(overview != null) {
      _data["overview"] = overview?.toJson();
    }
    if(periodCounts != null) {
      _data["periodCounts"] = periodCounts?.toJson();
    }
    return _data;
  }
}

class PeriodCounts {
  List<Months>? months;

  PeriodCounts({this.months});

  PeriodCounts.fromJson(Map<String, dynamic> json) {
    months = json["months"] == null ? null : (json["months"] as List).map((e) => Months.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(months != null) {
      _data["months"] = months?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Months {
  String? month;
  int? year;
  int? count;

  Months({this.month, this.year, this.count});

  Months.fromJson(Map<String, dynamic> json) {
    month = json["month"];
    year = json["year"];
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["month"] = month;
    _data["year"] = year;
    _data["count"] = count;
    return _data;
  }
}

class Overview {
  int? total;
  int? completed;
  int? cancelled;
  int? ongoing;

  Overview({this.total, this.completed, this.cancelled, this.ongoing});

  Overview.fromJson(Map<String, dynamic> json) {
    total = json["total"];
    completed = json["completed"];
    cancelled = json["cancelled"];
    ongoing = json["ongoing"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["total"] = total;
    _data["completed"] = completed;
    _data["cancelled"] = cancelled;
    _data["ongoing"] = ongoing;
    return _data;
  }
}

class TripData {
  TripData({
    required this.id,
    required this.shift,
    required this.date,
    required this.isGuard,
    required this.isGuardLoggedIn,
    required this.capacity,
    required this.approxStartTime,
    required this.approxEndTime,
    required this.listOfEmployees,
    required this.tripType,
    required this.vendor,
    required this.vehicle,
    required this.company,
    required this.driver,
    required this.guard,
    required this.office,
    required this.started,
    required this.status,
    required this.providedRoute,
    required this.travelledRoute,
    required this.ota,
    required this.otd,
    required this.driverName,
    required this.vehicleNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.tripStartTime,
    required this.tripEndTime,
  });

  final String? id;
  final String? shift;
  final DateTime? date;
  final bool? isGuard;
  final bool? isGuardLoggedIn;
  final int? capacity;
  final String? approxStartTime;
  final String? approxEndTime;
  final List<ListOfEmployee> listOfEmployees;
  final String? tripType;
  final String? vendor;
  final String? vehicle;
  final String? company;
  final String? driver;
  final dynamic guard;
  final String? office;
  final bool? started;
  final String? status;
  final List<ProvidedRoute> providedRoute;
  final List<dynamic> travelledRoute;
  final int? ota;
  final int? otd;
  final String? driverName;
  final String? vehicleNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? tripStartTime;
  final String? tripEndTime;

  factory TripData.fromJson(Map<String, dynamic> json){
    return TripData(
      id: json["_id"],
      shift: json["shift"],
      date: DateTime.tryParse(json["date"] ?? ""),
      isGuard: json["isGuard"],
      isGuardLoggedIn: json["isGuardLoggedIn"],
      capacity: json["capacity"],
      approxStartTime: json["approxStartTime"],
      approxEndTime: json["approxEndTime"],
      listOfEmployees: json["listOfEmployees"] == null ? [] : List<ListOfEmployee>.from(json["listOfEmployees"]!.map((x) => ListOfEmployee.fromJson(x))),
      tripType: json["tripType"],
      vendor: json["vendor"],
      vehicle: json["vehicle"],
      company: json["company"],
      driver: json["driver"],
      guard: json["guard"],
      office: json["office"],
      started: json["started"],
      status: json["status"],
      providedRoute: json["providedRoute"] == null ? [] : List<ProvidedRoute>.from(json["providedRoute"]!.map((x) => ProvidedRoute.fromJson(x))),
      travelledRoute: json["travelledRoute"] == null ? [] : List<dynamic>.from(json["travelledRoute"]!.map((x) => x)),
      ota: json["ota"],
      otd: json["otd"],
      driverName: json["driverName"],
      vehicleNumber: json["vehicleNumber"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      tripStartTime: json["tripStartTime"],
      tripEndTime: json["tripEndTime"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "shift": shift,
    "date": date?.toIso8601String(),
    "isGuard": isGuard,
    "isGuardLoggedIn": isGuardLoggedIn,
    "capacity": capacity,
    "approxStartTime": approxStartTime,
    "approxEndTime": approxEndTime,
    "listOfEmployees": listOfEmployees.map((x) => x?.toJson()).toList(),
    "tripType": tripType,
    "vendor": vendor,
    "vehicle": vehicle,
    "company": company,
    "driver": driver,
    "guard": guard,
    "office": office,
    "started": started,
    "status": status,
    "providedRoute": providedRoute.map((x) => x?.toJson()).toList(),
    "travelledRoute": travelledRoute.map((x) => x).toList(),
    "ota": ota,
    "otd": otd,
    "driverName": driverName,
    "vehicleNumber": vehicleNumber,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "tripStartTime": tripStartTime,
    "tripEndTime": tripEndTime,
  };

}

class ListOfEmployee {
  ListOfEmployee({
    required this.employeeId,
    required this.employeeName,
    required this.nodalId,
    required this.nodalName,
    required this.nodalLat,
    required this.nodalLng,
    required this.nodalDistance,
    required this.homeLat,
    required this.otp,
    required this.homeLng,
    required this.nodalZone,
    required this.pickupTime,
    required this.pickupLocation,
    required this.dropLocation,
    required this.phoneNumber,
    required this.status,
    required this.id,
  });

  final String? employeeId;
  final String? employeeName;
  final String? nodalId;
  final String? nodalName;
  final double? nodalLat;
  final double? nodalLng;
  final double? nodalDistance;
  final double? homeLat;
  final int? otp;
  final double? homeLng;
  final String? nodalZone;
  final String? pickupTime;
  final PLocation? pickupLocation;
  final PLocation? dropLocation;
  final String? phoneNumber;
  final String? status;
  final String? id;

  factory ListOfEmployee.fromJson(Map<String, dynamic> json){
    return ListOfEmployee(
      employeeId: json["employeeId"],
      employeeName: json["employeeName"],
      nodalId: json["nodalId"],
      nodalName: json["nodalName"],
      nodalLat: json["nodalLat"],
      nodalLng: json["nodalLng"],
      nodalDistance: json["nodalDistance"],
      homeLat: json["homeLat"],
      otp: json["otp"],
      homeLng: json["homeLng"],
      nodalZone: json["nodalZone"],
      pickupTime: json["pickupTime"],
      pickupLocation: json["pickupLocation"] == null ? null : PLocation.fromJson(json["pickupLocation"]),
      dropLocation: json["dropLocation"] == null ? null : PLocation.fromJson(json["dropLocation"]),
      phoneNumber: json["phoneNumber"],
      status: json["status"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "employeeId": employeeId,
    "employeeName": employeeName,
    "nodalId": nodalId,
    "nodalName": nodalName,
    "nodalLat": nodalLat,
    "nodalLng": nodalLng,
    "nodalDistance": nodalDistance,
    "homeLat": homeLat,
    "otp": otp,
    "homeLng": homeLng,
    "nodalZone": nodalZone,
    "pickupTime": pickupTime,
    "pickupLocation": pickupLocation?.toJson(),
    "dropLocation": dropLocation?.toJson(),
    "phoneNumber": phoneNumber,
    "status": status,
    "_id": id,
  };

}

class PLocation {
  PLocation({
    required this.latitude,
    required this.longitude,
    required this.id,
  });

  final double? latitude;
  final double? longitude;
  final String? id;

  factory PLocation.fromJson(Map<String, dynamic> json){
    return PLocation(
      latitude: json["latitude"],
      longitude: json["longitude"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "_id": id,
  };

}

class ProvidedRoute {
  ProvidedRoute({
    required this.lat,
    required this.lng,
  });

  final double? lat;
  final double? lng;

  factory ProvidedRoute.fromJson(Map<String, dynamic> json){
    return ProvidedRoute(
      lat: json["lat"],
      lng: json["lng"],
    );
  }

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };

}

class VendorDistributionModel {
  List<Distribution>? distribution;
  Summary? summary;

  VendorDistributionModel({this.distribution, this.summary});

  VendorDistributionModel.fromJson(Map<String, dynamic> json) {
    distribution = json["distribution"] == null ? null : (json["distribution"] as List).map((e) => Distribution.fromJson(e)).toList();
    summary = json["summary"] == null ? null : Summary.fromJson(json["summary"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(distribution != null) {
      _data["distribution"] = distribution?.map((e) => e.toJson()).toList();
    }
    if(summary != null) {
      _data["summary"] = summary?.toJson();
    }
    return _data;
  }
}

class Summary {
  int? totalTrips;
  int? totalVendors;

  Summary({this.totalTrips, this.totalVendors});

  Summary.fromJson(Map<String, dynamic> json) {
    totalTrips = json["totalTrips"];
    totalVendors = json["totalVendors"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["totalTrips"] = totalTrips;
    _data["totalVendors"] = totalVendors;
    return _data;
  }
}

class Distribution {
  String? id;
  String? name;
  int? count;
  int? percentage;

  Distribution({this.id, this.name, this.count, this.percentage});

  Distribution.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    count = json["count"];
    percentage = json["percentage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["count"] = count;
    _data["percentage"] = percentage;
    return _data;
  }
}
