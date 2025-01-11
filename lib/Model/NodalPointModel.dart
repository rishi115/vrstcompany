
class NodalPointModel {
  String? id;
  String? address;
  double? latitude;
  double? longitude;
  double? distanceFromCompany;
  String? zone;
  String? nodalPointName;
  int? employeeCount;
  List<ListOfEmployees>? listOfEmployees;
  String? company;
  String? office;
  bool? disabled;
  int? v;

  NodalPointModel({this.id, this.address, this.latitude, this.longitude, this.distanceFromCompany, this.zone, this.nodalPointName, this.employeeCount, this.listOfEmployees, this.company, this.office, this.disabled, this.v});

  NodalPointModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    address = json["address"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    distanceFromCompany = json["distanceFromCompany"];
    zone = json["zone"];
    nodalPointName = json["nodalPointName"];
    employeeCount = json["employeeCount"];
    listOfEmployees = json["listOfEmployees"] == null ? null : (json["listOfEmployees"] as List).map((e) => ListOfEmployees.fromJson(e)).toList();
    company = json["company"];
    office = json["office"];
    disabled = json["disabled"];
    v = json["__v"];
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
    _data["employeeCount"] = employeeCount;
    if(listOfEmployees != null) {
      _data["listOfEmployees"] = listOfEmployees?.map((e) => e.toJson()).toList();
    }
    _data["company"] = company;
    _data["office"] = office;
    _data["disabled"] = disabled;
    _data["__v"] = v;
    return _data;
  }
}

class ListOfEmployees {
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? address;

  ListOfEmployees({this.id, this.firstName, this.middleName, this.lastName, this.gender, this.address});

  ListOfEmployees.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    firstName = json["firstName"];
    middleName = json["middleName"];
    lastName = json["lastName"];
    gender = json["gender"];
    address = json["address"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["firstName"] = firstName;
    _data["middleName"] = middleName;
    _data["lastName"] = lastName;
    _data["gender"] = gender;
    _data["address"] = address;
    return _data;
  }
}