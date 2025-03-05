class Employee {
   String? firstName;
   String? middleName;
   String? lastName;
   String? contactNumber;
   String? secondaryContactNumber;
   String? employeeId;
   String? secondaryId;
   String? employmentType;
   String? dateOfBirth;
   String? gender='Male';
   String? email;
   String? age;
   String? disability;
   String? office;
   String? joiningDate;
   String? supervisorName;
   bool isSupervisor;
   String? transportInactiveDate;
   String? rfid;
   List<dynamic>? pickupReimbursementZone;
   List<dynamic>? dropReimbursementZone;
   List<dynamic>? category;
   List<dynamic>? languagesKnown;
   String? address;
   String? locality;
   String? latitude;
   String? longitude;
   String? nodalPoint;

  Employee({
    this.firstName,
    this.middleName,
    this.lastName,
    this.contactNumber,
    this.secondaryContactNumber,
    this.employeeId,
    this.secondaryId,
    this.employmentType,
    this.dateOfBirth,
    this.gender,
    this.email,
    this.joiningDate,
    this.supervisorName,
    this.isSupervisor = false,
    this.transportInactiveDate,
    this.rfid,
    this.age,
    this.disability,
    this.office,
    this.pickupReimbursementZone,
    this.dropReimbursementZone,
    this.category,
    this.languagesKnown,
    this.address,
    this.locality,
    this.latitude,
    this.longitude,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      contactNumber: json['contactNumber'],
      secondaryContactNumber: json['secondaryContactNumber'],
      employeeId: json['employeeId'],
      secondaryId: json['secondaryId'],
      employmentType: json['employmentType'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      email: json['email'],
      joiningDate: json['joiningDate'],
      supervisorName: json['supervisorName'],
      isSupervisor: json['isSupervisor'],
      transportInactiveDate: json['transportInactiveDate'] != null
          ? json['transportInactiveDate']
          : null,
      rfid: json['rfid'],
      pickupReimbursementZone: json['pickupReimbursementZone'],
      dropReimbursementZone: json['dropReimbursementZone'],
      category: json['category'],
      languagesKnown: json['languagesKnown'],
      address: json['address'],
      locality: json['locality'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'contactNumber': contactNumber,
      'secondaryContactNumber': secondaryContactNumber,
      'employeeId': employeeId,
      'secondaryId': secondaryId,
      'employmentType': employmentType,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'email': email,
      'joiningDate': joiningDate,
      'supervisorName': supervisorName,
      'isSupervisor': isSupervisor,
      'transportInactiveDate': transportInactiveDate,
      'rfid': rfid,
      'pickupReimbursementZone': pickupReimbursementZone,
      'dropReimbursementZone': dropReimbursementZone,
      'category': category,
      'languagesKnown': languagesKnown,
      'address': address,
      'locality': locality,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
