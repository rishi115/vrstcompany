
class OfficeModel {
  String? id;
  String? name;
  double? latitude;
  double? longitude;
  String? address;
  String? supervisorId;
  String? company;
  bool? disabled;
  List<dynamic>? listOfGuards;
  String? createdAt;
  String? updatedAt;
  int? v;

  OfficeModel({this.id, this.name, this.latitude, this.longitude, this.address, this.supervisorId, this.company, this.disabled, this.listOfGuards, this.createdAt, this.updatedAt, this.v});

  OfficeModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    address = json["address"];
    supervisorId = json["supervisorId"];
    company = json["company"];
    disabled = json["disabled"];
    listOfGuards = json["listOfGuards"] ?? [];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["address"] = address;
    _data["supervisorId"] = supervisorId;
    _data["company"] = company;
    _data["disabled"] = disabled;
    if(listOfGuards != null) {
      _data["listOfGuards"] = listOfGuards;
    }
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}