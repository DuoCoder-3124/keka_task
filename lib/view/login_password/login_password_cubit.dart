import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bottom_nav_bar/bottom_nav_bar_view.dart';
part 'login_password_state.dart';

class LoginPasswordCubit extends Cubit<LoginPasswordState>{

  final BuildContext context;


  LoginPasswordCubit(super.initialState, this.context);

  void changeVisibility(){
    emit(state.copyWith(isVisible: !state.isVisible));
  }

  void loginPasswordPressed(){
    if((state.formKey.currentState?.validate()??false) ) {
      // log('message');
      // Navigator.pushNamed(context, BottomNavBarView.routeName);
      Navigator.pushNamedAndRemoveUntil(context, BottomNavBarView.routeName, (route) => false);
    }
  }
}