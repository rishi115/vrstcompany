
class ShiftModel {
  String? id;
  String? loginTime;
  String? logoutTime;
  String? tripType;
  String? company;
  int? v;

  ShiftModel({this.id, this.loginTime, this.logoutTime, this.tripType, this.company, this.v});

  ShiftModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    loginTime = json["loginTime"];
    logoutTime = json["logoutTime"];
    tripType = json["tripType"];
    company = json["company"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["loginTime"] = loginTime;
    _data["logoutTime"] = logoutTime;
    _data["tripType"] = tripType;
    _data["company"] = company;
    _data["__v"] = v;
    return _data;
  }
}