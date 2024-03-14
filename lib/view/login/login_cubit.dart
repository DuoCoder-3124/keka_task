
part of 'login_view.dart';

class LoginCubit extends Cubit<LoginState> {
  final BuildContext context;
  LoginCubit(super.initialState, this.context);

  void loginPressed() {
    if ((state.formKey.currentState?.validate() ?? false)) {
      Navigator.pushNamed(context, LoginPasswordView.routeName,arguments: state.emailController.text);
    }
  }
}
