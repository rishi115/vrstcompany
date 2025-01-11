
class EmployeeListModel {
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  int? age;
  String? contactNumber;
  String? secondaryContactNumber;
  String? employeeId;
  String? secondaryId;
  String? employmentType;
  String? dateOfBirth;
  String? gender;
  String? email;
  String? joiningDate;
  String? supervisorName;
  bool? isSupervisor;
  String? rfid;
  List<String>? pickupReimbursementZone;
  List<String>? dropReimbursementZone;
  String? pickUpTime;
  List<String>? category;
  List<String>? languagesKnown;
  String? address;
  String? locality;
  double? latitude;
  double? longitude;
  String? emergencyMobile;
  String? emergencyName;
  String? emergencyRelation;
  String? status;
  List<String>? teams;
  String? disability;
  List<dynamic>? listOfTrips;
  bool? nodalPointAssigned;
  int? tripOtp;
  String? company;
  List<dynamic>? listOfRosters;
  int? v;
  String? transportInactiveDate;

  EmployeeListModel({this.id, this.firstName, this.middleName, this.lastName, this.age, this.contactNumber, this.secondaryContactNumber, this.employeeId, this.secondaryId, this.employmentType, this.dateOfBirth, this.gender, this.email, this.joiningDate, this.supervisorName, this.isSupervisor, this.rfid, this.pickupReimbursementZone, this.dropReimbursementZone, this.pickUpTime, this.category, this.languagesKnown, this.address, this.locality, this.latitude, this.longitude, this.emergencyMobile, this.emergencyName, this.emergencyRelation, this.status, this.teams, this.disability, this.listOfTrips, this.nodalPointAssigned, this.tripOtp, this.company, this.listOfRosters, this.v, this.transportInactiveDate});

  EmployeeListModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    firstName = json["firstName"];
    middleName = json["middleName"];
    lastName = json["lastName"];
    age = json["age"];
    contactNumber = json["contactNumber"];
    secondaryContactNumber = json["secondaryContactNumber"];
    employeeId = json["employeeId"];
    secondaryId = json["secondaryId"];
    employmentType = json["employmentType"];
    dateOfBirth = json["dateOfBirth"];
    gender = json["gender"];
    email = json["email"];
    joiningDate = json["joiningDate"];
    supervisorName = json["supervisorName"];
    isSupervisor = json["isSupervisor"];
    rfid = json["rfid"];
    pickupReimbursementZone = json["pickupReimbursementZone"] == null ? null : List<String>.from(json["pickupReimbursementZone"]);
    dropReimbursementZone = json["dropReimbursementZone"] == null ? null : List<String>.from(json["dropReimbursementZone"]);
    pickUpTime = json["pickUpTime"];
    category = json["category"] == null ? null : List<String>.from(json["category"]);
    languagesKnown = json["languagesKnown"] == null ? null : List<String>.from(json["languagesKnown"]);
    address = json["address"];
    locality = json["locality"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    emergencyMobile = json["emergencyMobile"];
    emergencyName = json["emergencyName"];
    emergencyRelation = json["emergencyRelation"];
    status = json["status"];
    teams = json["teams"] == null ? null : List<String>.from(json["teams"]);
    disability = json["disability"];
    listOfTrips = json["listOfTrips"] ?? [];
    nodalPointAssigned = json["nodalPointAssigned"];
    tripOtp = json["tripOtp"];
    company = json["company"];
    listOfRosters = json["listOfRosters"] ?? [];
    v = json["__v"];
    transportInactiveDate = json["transportInactiveDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["firstName"] = firstName;
    _data["middleName"] = middleName;
    _data["lastName"] = lastName;
    _data["age"] = age;
    _data["contactNumber"] = contactNumber;
    _data["secondaryContactNumber"] = secondaryContactNumber;
    _data["employeeId"] = employeeId;
    _data["secondaryId"] = secondaryId;
    _data["employmentType"] = employmentType;
    _data["dateOfBirth"] = dateOfBirth;
    _data["gender"] = gender;
    _data["email"] = email;
    _data["joiningDate"] = joiningDate;
    _data["supervisorName"] = supervisorName;
    _data["isSupervisor"] = isSupervisor;
    _data["rfid"] = rfid;
    if(pickupReimbursementZone != null) {
      _data["pickupReimbursementZone"] = pickupReimbursementZone;
    }
    if(dropReimbursementZone != null) {
      _data["dropReimbursementZone"] = dropReimbursementZone;
    }
    _data["pickUpTime"] = pickUpTime;
    if(category != null) {
      _data["category"] = category;
    }
    if(languagesKnown != null) {
      _data["languagesKnown"] = languagesKnown;
    }
    _data["address"] = address;
    _data["locality"] = locality;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["emergencyMobile"] = emergencyMobile;
    _data["emergencyName"] = emergencyName;
    _data["emergencyRelation"] = emergencyRelation;
    _data["status"] = status;
    if(teams != null) {
      _data["teams"] = teams;
    }
    _data["disability"] = disability;
    if(listOfTrips != null) {
      _data["listOfTrips"] = listOfTrips;
    }
    _data["nodalPointAssigned"] = nodalPointAssigned;
    _data["tripOtp"] = tripOtp;
    _data["company"] = company;
    if(listOfRosters != null) {
      _data["listOfRosters"] = listOfRosters;
    }
    _data["__v"] = v;
    _data["transportInactiveDate"] = transportInactiveDate;
    return _data;
  }
}