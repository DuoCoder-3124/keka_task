part of 'register_view.dart';

class RegisterState extends Equatable {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController reportedByController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();

  GlobalKey<FormState> formKey;

  RegisterState({
    required this.firstNameController,
    required this.middleNameController,
    required this.lastNameController,
    required this.phoneNumberController,
    required this.emailController,
    required this.passwordController,
    required this.departmentController,
    required this.genderController,
    required this.dobController,
    required this.reportedByController,
    required this.jobTitleController,
    required this.formKey,
  });

  @override
  List<Object?> get props => [
        emailController,
        formKey,
        firstNameController,
        middleNameController,
        lastNameController,
        phoneNumberController,
        passwordController,
        departmentController,
        genderController,
        dobController,
        jobTitleController,
      ];

  RegisterState copyWith({
    TextEditingController? firstNameController,
    TextEditingController? middleNameController,
    TextEditingController? lastNameController,
    TextEditingController? phoneNumberController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? departmentController,
    TextEditingController? genderController,
    TextEditingController? dobController,
    TextEditingController? reportedByController,
    TextEditingController? jobTitleController,
    GlobalKey<FormState>? formKey,
  }) {
    return RegisterState(
      firstNameController: firstNameController ?? this.firstNameController,
      middleNameController: middleNameController ?? this.middleNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      phoneNumberController: phoneNumberController ?? this.phoneNumberController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      departmentController: departmentController ?? this.departmentController,
      genderController: genderController ?? this.genderController,
      dobController: dobController ?? this.dobController,
      reportedByController: reportedByController ?? this.reportedByController,
      jobTitleController: jobTitleController ?? this.jobTitleController,
      formKey: formKey ?? this.formKey,
    );
  }
}
