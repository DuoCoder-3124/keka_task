import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_password_state.dart';

class LoginPasswordCubit extends Cubit<LoginPasswordState>{
  LoginPasswordCubit(super.initialState);

  void changeVisibility(){
    emit(state.copyWith(isVisible: !state.isVisible));
  }
}