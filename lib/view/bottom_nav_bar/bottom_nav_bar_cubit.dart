import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keka_task/common_widget/enum.dart';
import 'package:keka_task/view/bottom_nav_bar/bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState>{
  BottomNavBarCubit(super.initialState);

  // ///when i tap on home widget than change it's color, below web clock-out
  // colorChange({Color? color}){
  //     color = Colors.green;
  //     emit(state.copyWith(color: color));
  // }
  //
  // ///change drop down button item
  // dropDownItemUpdate({String? dropDownItem}){
  //   emit(state.copyWith(dropDownItem: dropDownItem));
  //   print('out valu ----> $dropDownItem');
  // }

  void onTabChange(BottomNavigationOption value) {
    emit(state.copyWith(navigationOption:  value));
  }

}