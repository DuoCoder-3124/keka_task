import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bottom_nav_bar/bottom_nav_bar_view.dart';
part 'login_password_state.dart';

class LoginPasswordCubit extends Cubit<LoginPasswordState>{



  LoginPasswordCubit(super.initialState);

  void changeVisibility(){
    emit(state.copyWith(isVisible: !state.isVisible));
  }

  void loginPasswordPressed(context){
    if(state.formKey.currentState!.validate() || (state.passwordController.text.isNotEmpty && state.passwordController.text.isNotEmpty )) {
      Navigator.pushNamed(context, BottomNavBarView.routeName);
    }
  }
}