class RegisterModel{

  final String userId;
  final String firstName;
  final String secondName;
  final String middleName;
  final String email;
  final String password;
  final String dob;
  final String gender;
  final String department;
  final String reportedBy;
  final String jobTitle;
  final String phoneNumber;

  RegisterModel({
    this.userId="",
    this.firstName = "",
    this.secondName = "",
    this.middleName = "",
    this.email = "",
    this.password = "",
    this.dob = "",
    this.gender = "",
    this.department = "",
    this.reportedBy = "",
    this.jobTitle = "",
    this.phoneNumber = "",
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    userId: json['_id'],
      firstName: json['firstName'],
      secondName: json['secondName'],
      middleName: json['middleName'],
      email: json['email'],
      password: json['password'],
      dob: json['DOB'],
      gender: json['gender'],
      department: json['department'],
      reportedBy: json['reportedBy'],
      jobTitle: json['jobTitle'],
      phoneNumber: json['phoneNumber']
  );


  Map<String, dynamic> toJson() => {
    '_id':userId,
    'firstName':firstName,
    'secondName':secondName,
    'middleName':middleName,
    'email':email,
    'password':password,
    'DOB':dob,
    'gender':gender,
    'department':department,
    'reportedBy':reportedBy,
    'jobTitle':jobTitle,
    'phoneNumber':phoneNumber
  };


}
