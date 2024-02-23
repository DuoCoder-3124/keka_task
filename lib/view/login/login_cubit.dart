import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keka_task/view/login_password/login_password_view.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final BuildContext context;

  LoginCubit(super.initialState, this.context);

  void loginPressed() {
    if ((state.formKey.currentState?.validate() ?? false)) {
      // emit(state.copyWith(emailController: state.emailController,formKey: state.formKey));
      Navigator.pushNamed(context, LoginPasswordView.routeName);
    }

  }
}
