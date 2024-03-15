import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keka_task/services/api_helper.dart';
import 'package:keka_task/view/forgot_password/forgot_password_view.dart';

import 'package:keka_task/view/login/login_view.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final BuildContext context;
  final TokenArgumentPass tokenArgumentPass;

  ForgotPasswordCubit(super.initialState, {required this.context, required this.tokenArgumentPass}) {
    emit(state.copyWith(otp: tokenArgumentPass.otp));
  }

  void changeVisibility1() {
    emit(state.copyWith(isVisible1: !state.isVisible1));
  }

  void changeVisibility2() {
    emit(state.copyWith(isVisible2: !state.isVisible2));
  }

  Future<void> loginPasswordPressed() async {
    if ((state.formKey.currentState?.validate() ?? false)) {
      if (state.passwordController.text == state.confirmPasswordController.text) {
        await ApiService.helper
            .verifyOtp(
              otp: tokenArgumentPass.otp ?? '',
              token: tokenArgumentPass.token ?? '',
              password: state.passwordController.text,
            )
            .then((value) => Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName, (route) => false));
      } else {
        Fluttertoast.showToast(msg: 'password and confirm password are not same');
      }
    }
  }
}
