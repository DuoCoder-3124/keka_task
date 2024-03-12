import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keka_task/services/api_helper.dart';
import 'package:uuid/uuid.dart';

import '../bottom_nav_bar/bottom_nav_bar_view.dart';

part 'login_password_state.dart';

class LoginPasswordCubit extends Cubit<LoginPasswordState> {
  final BuildContext context;
  final String userEmail;

  LoginPasswordCubit(super.initialState, {required this.context, required this.userEmail}) {
    buildCaptcha();
  }

  void buildCaptcha() {
    final captcha = const Uuid().v4().substring(1, 5).toUpperCase();
    emit(state.copyWith(captcha: captcha));
  }

  void refreshCaptcha() {
    final captcha = const Uuid().v4().substring(1, 5).toUpperCase();
    emit(state.copyWith(captcha: captcha));
  }

  void changeVisibility() {
    emit(state.copyWith(isVisible: !state.isVisible));
  }

  Future<void> loginPasswordPressed() async {
    if ((state.formKey.currentState?.validate() ?? false)) {
      await ApiService.helper.loginUser(email: userEmail, password: state.passwordController.text).then((value) {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User login')));
          Navigator.pushNamedAndRemoveUntil(context, BottomNavBarView.routeName, (route) => false);
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login fail')));
        }
      });
    }
  }
}
