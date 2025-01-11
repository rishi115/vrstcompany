import 'dart:io';

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