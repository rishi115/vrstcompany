import 'dart:io';


class GaurdModel {
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? address;
  double? latitude;
  double? longitude;
  int? age;
  String? gender;
  String? contact;
  int? otp;
  String? status;
  String? uid;
  String? office;
  String? company;
  List<dynamic>? listOfTrips;
  String? photo;
  String? adharCard;
  bool? disabled;
  String? agency;
  bool? routeAssigned;
  bool? insideTrip;
  String? createdAt;
  String? updatedAt;
  int? v;

  GaurdModel({this.id, this.firstName, this.middleName, this.lastName, this.address, this.latitude, this.longitude, this.age, this.gender, this.contact, this.otp, this.status, this.uid, this.office, this.company, this.listOfTrips, this.photo, this.adharCard, this.disabled, this.agency, this.routeAssigned, this.insideTrip, this.createdAt, this.updatedAt, this.v});

  GaurdModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    firstName = json["firstName"];
    middleName = json["middleName"];
    lastName = json["lastName"];
    address = json["address"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    age = json["age"];
    gender = json["gender"];
    contact = json["contact"];
    otp = json["otp"];
    status = json["status"];
    uid = json["uid"];
    office = json["office"];
    company = json["company"];
    listOfTrips = json["listOfTrips"] ?? [];
    photo = json["photo"];
    adharCard = json["adharCard"];
    disabled = json["disabled"];
    agency = json["agency"];
    routeAssigned = json["routeAssigned"];
    insideTrip = json["insideTrip"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["firstName"] = firstName;
    _data["middleName"] = middleName;
    _data["lastName"] = lastName;
    _data["address"] = address;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["age"] = age;
    _data["gender"] = gender;
    _data["contact"] = contact;
    _data["otp"] = otp;
    _data["status"] = status;
    _data["uid"] = uid;
    _data["office"] = office;
    _data["company"] = company;
    if(listOfTrips != null) {
      _data["listOfTrips"] = listOfTrips;
    }
    _data["photo"] = photo;
    _data["adharCard"] = adharCard;
    _data["disabled"] = disabled;
    _data["agency"] = agency;
    _data["routeAssigned"] = routeAssigned;
    _data["insideTrip"] = insideTrip;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}
class Guard {
  String? firstName;
  String? middleName;
  String? lastName;
  String? contactNumber;
  String? gender = 'Male';
  String? age;
  String? office;
  String? status;
  File?  image;
  String? address;
  String? locality;
  String? latitude;
  String? longitude;
  String? agency;
  String? otp;
  String? uid;
  String? company;
  String? photo;
  String? adharCard;
  Guard({
    this.firstName,
    this.middleName,
    this.lastName,
    this.contactNumber,
    this.age,
    this.gender,
    this.office,
    this.status,
    this.image,
    this.address,
    this.locality,
    this.latitude,
    this.longitude,
    this.agency,
    this.otp,
    this.uid,
    this.company,
    this.photo,
    this.adharCard,
  });

}

class AgencyList {
  String? id;
  String? name;
  List<String>? listOfGuards;
  List<dynamic>? listOfTrips;
  List<dynamic>? listOfCompanies;
  String? address;
  String? primaryContact;
  String? primaryEmail;
  String? status;
  bool? disabled;
  int? v;

  AgencyList({this.id, this.name, this.listOfGuards, this.listOfTrips, this.listOfCompanies, this.address, this.primaryContact, this.primaryEmail, this.status, this.disabled, this.v});

  AgencyList.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    listOfGuards = json["listOfGuards"] == null ? null : List<String>.from(json["listOfGuards"]);
    listOfTrips = json["listOfTrips"] ?? [];
    listOfCompanies = json["listOfCompanies"] ?? [];
    address = json["address"];
    primaryContact = json["primaryContact"];
    primaryEmail = json["primaryEmail"];
    status = json["status"];
    disabled = json["disabled"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    if(listOfGuards != null) {
      _data["listOfGuards"] = listOfGuards;
    }
    if(listOfTrips != null) {
      _data["listOfTrips"] = listOfTrips;
    }
    if(listOfCompanies != null) {
      _data["listOfCompanies"] = listOfCompanies;
    }
    _data["address"] = address;
    _data["primaryContact"] = primaryContact;
    _data["primaryEmail"] = primaryEmail;
    _data["status"] = status;
    _data["disabled"] = disabled;
    _data["__v"] = v;
    return _data;
  }
}