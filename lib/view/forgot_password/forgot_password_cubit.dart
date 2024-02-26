import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:keka_task/view/login/login_view.dart';
part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState>{

  final BuildContext context;


  ForgotPasswordCubit(super.initialState,this.context);

  void loginPasswordPressed(){
    if((state.formKey.currentState?.validate()??false)) {
      // log('message');
      // Navigator.pushNamed(context, BottomNavBarView.routeName);
      Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName, (route) => false);

    }
  }

}