import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keka_task/services/api_helper.dart';
import 'package:keka_task/view/admin/admin_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:keka_task/view/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:keka_task/view/forgot_password/forgot_password_view.dart';

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

  Future<void> navigateToForgot() async {
    await ApiService.helper.getTokenByEmail(userEmail).then((value) {
      Navigator.pushNamed(context, ForgotPasswordView.routeName,
          arguments: TokenArgumentPass(email: userEmail, otp: value['otp'], token: value['token']));
    });
  }

  Future<void> loginPasswordPressed() async {
    if ((state.formKey.currentState?.validate() ?? false)) {
      await ApiService.helper.loginUser(email: userEmail, password: state.passwordController.text).then((value) {
        if (value == 'user') {
          userLogin();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User login')));
          Navigator.pushNamedAndRemoveUntil(context, BottomNavBarView.routeName, (route) => false);
        } else if (value == 'admin') {
          adminLogin();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Admin Login')));
          Navigator.pushNamedAndRemoveUntil(context, AdminView.routeName, (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login fail')));
        }
      });
    }
  }

  Future<void> userLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('whichUser', 'user');
  }

  Future<void> adminLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('whichUser', 'admin');
  }
}
