
part of 'login_view.dart';

class LoginCubit extends Cubit<LoginState> {
  final BuildContext context;
  LoginCubit(super.initialState, this.context){
    log('hdgshdg');
      // ApiService.helper.registerUser(RegisterModel());

  }

  void loginPressed() {
    if ((state.formKey.currentState?.validate() ?? false)) {
      // emit(state.copyWith(emailController: state.emailController,formKey: state.formKey));
      Navigator.pushNamed(context, LoginPasswordView.routeName);
    }

  }
}
