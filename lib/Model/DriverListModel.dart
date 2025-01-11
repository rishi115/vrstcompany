
class DriverListModel {
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? contactNumber;
  String? gender;
  String? status;
  String? licenseNo;
  Vehicle? vehicle;
  bool? disabled;

  DriverListModel({this.id, this.firstName, this.middleName, this.lastName, this.contactNumber, this.gender, this.status, this.licenseNo, this.vehicle, this.disabled});

  DriverListModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    firstName = json["firstName"];
    middleName = json["middleName"];
    lastName = json["lastName"];
    contactNumber = json["contactNumber"];
    gender = json["gender"];
    status = json["status"];
    licenseNo = json["licenseNo"];
    vehicle = json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]);
    disabled = json["disabled"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["firstName"] = firstName;
    _data["middleName"] = middleName;
    _data["lastName"] = lastName;
    _data["contactNumber"] = contactNumber;
    _data["gender"] = gender;
    _data["status"] = status;
    _data["licenseNo"] = licenseNo;
    if(vehicle != null) {
      _data["vehicle"] = vehicle?.toJson();
    }
    _data["disabled"] = disabled;
    return _data;
  }
}

class Vehicle {
  String? id;
  String? vehicleModel;
  String? vehicleNumber;
  int? vehicleCapacity;

  Vehicle({this.id, this.vehicleModel, this.vehicleNumber, this.vehicleCapacity});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    vehicleModel = json["vehicleModel"];
    vehicleNumber = json["vehicleNumber"];
    vehicleCapacity = json["vehicleCapacity"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["vehicleModel"] = vehicleModel;
    _data["vehicleNumber"] = vehicleNumber;
    _data["vehicleCapacity"] = vehicleCapacity;
    return _data;
  }
}