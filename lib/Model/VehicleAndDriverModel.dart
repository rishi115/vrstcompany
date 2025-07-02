
class VehicleAndDriverModel {
  String? id;
  String? vehicleType;
  String? vehicleModel;
  String? vehicleNumber;
  int? vehicleCapacity;
  String? status;
  String? fuelType;
  String? chassisNumber;
  Driver? driver;
  String? registrationCertificate;
  String? registrationCertificateExpiration;
  String? insurancePaper;
  String? insurancePaperExpiration;
  String? taxReceipt;
  String? permit;
  String? puc;
  String? pucExpiration;
  String? fitnessCertificate;
  String? fitnessCertificateExpiration;

  VehicleAndDriverModel({this.id, this.vehicleType, this.vehicleModel, this.vehicleNumber, this.vehicleCapacity, this.status, this.fuelType, this.chassisNumber, this.driver, this.registrationCertificate, this.registrationCertificateExpiration, this.insurancePaper, this.insurancePaperExpiration, this.taxReceipt, this.permit, this.puc, this.pucExpiration, this.fitnessCertificate, this.fitnessCertificateExpiration});

  VehicleAndDriverModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    vehicleType = json["vehicleType"];
    vehicleModel = json["vehicleModel"];
    vehicleNumber = json["vehicleNumber"];
    vehicleCapacity = json["vehicleCapacity"];
    status = json["status"];
    fuelType = json["fuelType"];
    chassisNumber = json["chassisNumber"];
    driver = json["driver"] == null ? null : Driver.fromJson(json["driver"]);
    registrationCertificate = json["registrationCertificate"];
    registrationCertificateExpiration = json["registrationCertificateExpiration"];
    insurancePaper = json["insurancePaper"];
    insurancePaperExpiration = json["insurancePaperExpiration"];
    taxReceipt = json["taxReceipt"];
    permit = json["permit"];
    puc = json["puc"];
    pucExpiration = json["pucExpiration"];
    fitnessCertificate = json["fitnessCertificate"];
    fitnessCertificateExpiration = json["fitnessCertificateExpiration"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["vehicleType"] = vehicleType;
    _data["vehicleModel"] = vehicleModel;
    _data["vehicleNumber"] = vehicleNumber;
    _data["vehicleCapacity"] = vehicleCapacity;
    _data["status"] = status;
    _data["fuelType"] = fuelType;
    _data["chassisNumber"] = chassisNumber;
    if(driver != null) {
      _data["driver"] = driver?.toJson();
    }
    _data["registrationCertificate"] = registrationCertificate;
    _data["registrationCertificateExpiration"] = registrationCertificateExpiration;
    _data["insurancePaper"] = insurancePaper;
    _data["insurancePaperExpiration"] = insurancePaperExpiration;
    _data["taxReceipt"] = taxReceipt;
    _data["permit"] = permit;
    _data["puc"] = puc;
    _data["pucExpiration"] = pucExpiration;
    _data["fitnessCertificate"] = fitnessCertificate;
    _data["fitnessCertificateExpiration"] = fitnessCertificateExpiration;
    return _data;
  }
}

class Driver {
  String? id;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? gender;
  String? status;
  String? licenseType;
  String? licenseNo;
  String? license;
  String? licenseExpiration;
  String? policeVerification;
  String? photo;

  Driver({this.id, this.firstName, this.lastName, this.contactNumber, this.gender, this.status, this.licenseType, this.licenseNo, this.license, this.licenseExpiration, this.policeVerification, this.photo});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    contactNumber = json["contactNumber"];
    gender = json["gender"];
    status = json["status"];
    licenseType = json["licenseType"];
    licenseNo = json["licenseNo"];
    license = json["license"];
    licenseExpiration = json["licenseExpiration"];
    policeVerification = json["policeVerification"];
    photo = json["photo"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["contactNumber"] = contactNumber;
    _data["gender"] = gender;
    _data["status"] = status;
    _data["licenseType"] = licenseType;
    _data["licenseNo"] = licenseNo;
    _data["license"] = license;
    _data["licenseExpiration"] = licenseExpiration;
    _data["policeVerification"] = policeVerification;
    _data["photo"] = photo;
    return _data;
  }
}