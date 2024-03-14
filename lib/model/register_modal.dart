class RegisterModel{

  final String userId;
  final String firstName;
  final String lastName;
  final String middleName;
  final String email;
  final String password;
  final String dob;
  final String gender;
  final String department;
  final String reportedBy;
  final String jobTitle;
  final String phoneNumber;
  final int employeeNumber;

  RegisterModel({
    this.userId="",
    this.firstName = "",
    this.lastName = "",
    this.middleName = "",
    this.email = "",
    this.password = "",
    this.dob = "",
    this.gender = "",
    this.department = "",
    this.reportedBy = "",
    this.jobTitle = "",
    this.phoneNumber = "",
    this.employeeNumber=0,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    userId: json['_id'],
      firstName: json['firstName'],
      lastName: json['secondName'],
      middleName: json['middleName'],
      email: json['email'],
      password: json['password'],
      dob: json['DOB'],
      gender: json['gender'],
      department: json['department'],
      reportedBy: json['reportedBy'],
      jobTitle: json['jobTitle'],
      phoneNumber: json['phoneNumber'],
    employeeNumber: json['employeeNumber'],
  );


  Map<String, dynamic> toJson() => {
    '_id':userId,
    'firstName':firstName,
    'secondName':lastName,
    'middleName':middleName,
    'email':email,
    'password':password,
    'DOB':dob,
    'gender':gender,
    'department':department,
    'reportedBy':reportedBy,
    'jobTitle':jobTitle,
    'phoneNumber':phoneNumber,
    'employeeNumber':employeeNumber,
  };
}
