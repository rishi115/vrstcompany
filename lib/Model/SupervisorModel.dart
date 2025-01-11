
class SupervisorModel {
  String? id;
  String? middleName;
  String? lastName;
  String? contactNumber;
  Office? office;

  SupervisorModel({this.id, this.middleName, this.lastName, this.contactNumber, this.office});

  SupervisorModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    middleName = json["middleName"];
    lastName = json["lastName"];
    contactNumber = json["contactNumber"];
    office = json["office"] == null ? null : Office.fromJson(json["office"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["middleName"] = middleName;
    _data["lastName"] = lastName;
    _data["contactNumber"] = contactNumber;
    if(office != null) {
      _data["office"] = office?.toJson();
    }
    return _data;
  }
}

class Office {
  String? id;
  String? name;

  Office({this.id, this.name});

  Office.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    return _data;
  }
}