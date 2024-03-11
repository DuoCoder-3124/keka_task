
part of 'login_view.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final BuildContext context;
  RegisterCubit(super.initialState, this.context);

  void loginPressed() {
    if ((state.formKey.currentState?.validate() ?? false)) {
      // emit(state.copyWith(emailController: state.emailController,formKey: state.formKey));
      Navigator.pushNamed(context, LoginPasswordView.routeName);
    }

  }
}
