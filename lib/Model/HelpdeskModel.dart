
class HelpdeskModel {
  RaisedBy? raisedBy;
  String? id;
  String? priority;
  String? subject;
  String? status;
  String? createdAt;

  HelpdeskModel({this.raisedBy, this.id, this.priority, this.subject, this.status, this.createdAt});

  HelpdeskModel.fromJson(Map<String, dynamic> json) {
    raisedBy = json["raisedBy"] == null ? null : RaisedBy.fromJson(json["raisedBy"]);
    id = json["_id"];
    priority = json["priority"];
    subject = json["subject"];
    status = json["status"];
    createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(raisedBy != null) {
      _data["raisedBy"] = raisedBy?.toJson();
    }
    _data["_id"] = id;
    _data["priority"] = priority;
    _data["subject"] = subject;
    _data["status"] = status;
    _data["createdAt"] = createdAt;
    return _data;
  }
}

class RaisedBy {
  String? id;
  String? role;
  String? name;
  String? company;

  RaisedBy({this.id, this.role, this.name, this.company});

  RaisedBy.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    role = json["role"];
    name = json["name"];
    company = json["company"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["role"] = role;
    _data["name"] = name;
    _data["company"] = company;
    return _data;
  }
}