import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keka_task/view/login_password/login_password_view.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit(super.initialState);

  void loginPressed(context){
    if(state.formKey.currentState!.validate() || state.emailController.text.isNotEmpty) {
      Navigator.pushNamed(context, LoginPasswordView.routeName);
    }
  }
}