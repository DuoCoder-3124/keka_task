part of 'register_view.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final BuildContext context;
  RegisterCubit(super.initialState, this.context);

  void registerPressed() {
    if ((state.formKey.currentState?.validate() ?? false)) {
      // emit(state.copyWith(emailController: state.emailController,formKey: state.formKey));
      Navigator.pushNamedAndRemoveUntil(context, LoginPasswordView.routeName,(route) => false);
    }
  }
}
