part of 'register_view.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final BuildContext context;
  final UpdateArgumentPass updateArgumentPass;

  RegisterCubit(super.initialState, {required this.context,required this.updateArgumentPass}){
    if(updateArgumentPass.isNew==false){
      emit(state.copyWith(
        firstNameController: TextEditingController(text:updateArgumentPass.registerModel?.firstName??''),
        middleNameController: TextEditingController(text:updateArgumentPass.registerModel?.middleName??''),
        lastNameController: TextEditingController(text:updateArgumentPass.registerModel?.lastName??''),
        emailController: TextEditingController(text:updateArgumentPass.registerModel?.email??''),
        phoneNumberController: TextEditingController(text:updateArgumentPass.registerModel?.phoneNumber??''),
        departmentController: TextEditingController(text:updateArgumentPass.registerModel?.department??''),
        genderController: TextEditingController(text:updateArgumentPass.registerModel?.gender??''),
        dobController: TextEditingController(text:updateArgumentPass.registerModel?.dob??''),
        reportedByController: TextEditingController(text:updateArgumentPass.registerModel?.reportedBy??''),
        jobTitleController: TextEditingController(text:updateArgumentPass.registerModel?.jobTitle??''),
      ));
    }
  }

  void changeVisibility() {
    emit(state.copyWith(isVisible: !state.isVisible));
  }


  Future<void> updatePressed() async {
    if ((state.formKey.currentState?.validate() ?? false)) {
      // emit(state.copyWith(emailController: state.emailController,formKey: state.formKey));

      var userId=await ApiService.helper.getUserId();

      ApiService.helper.updateUser(
        registerModel:  RegisterModel(
          userId: userId??'',
          firstName: state.firstNameController.text,
          middleName: state.middleNameController.text,
          lastName: state.lastNameController.text,
          phoneNumber: state.phoneNumberController.text,
          department: state.departmentController.text,
          dob: state.dobController.text,
          gender: state.genderController.text,
          jobTitle: state.jobTitleController.text,
          reportedBy: state.reportedByController.text,
        ),
      ).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User updated successfully')));
        Navigator.pushNamedAndRemoveUntil(context, BottomNavBarView.routeName, (route) => false);
      });

    }
  }

  void registerPressed({registerModel}) {
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
          lastName: state.lastNameController.text,
        ),
      ).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User registered successfully')));
        Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName, (route) => false);
      });

    }
  }
}
