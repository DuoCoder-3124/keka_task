part of 'register_view.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final BuildContext context;

  RegisterCubit(super.initialState, this.context);

  void registerPressed() {
    if ((state.formKey.currentState?.validate() ?? false)) {
      // emit(state.copyWith(emailController: state.emailController,formKey: state.formKey));

      ApiService.helper.registerUser(
        RegisterModel(
          email: state.emailController.text,
          password: state.passwordController.text,
          department: state.departmentController.text,
          dob: state.dobController.text,
          firstName: state.firstNameController.text,
          gender: state.genderController.text,
          jobTitle: state.jobTitleController.text,
          middleName: state.middleNameController.text,
          phoneNumber: state.phoneNumberController.text,
          reportedBy: state.reportedByController.text,
          secondName: state.lastNameController.text,
        ),
      );

      Navigator.pushNamedAndRemoveUntil(context, LoginPasswordView.routeName, (route) => false);
    }
  }
}
