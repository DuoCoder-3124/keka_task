import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keka_task/common_widget/enum.dart';
import 'package:keka_task/view/main_view/main_state.dart';

class MainCubit extends Cubit<MainState>{
  MainCubit(super.initialState);

  ///when i tap on home widget than change it's color, below web clock-out
  colorChange({Color? color}){
      color = Colors.green;
      emit(state.copyWith(color: color));
  }

  ///change drop down button item
  dropDownItemUpdate({String? dropDownItem}){
    emit(state.copyWith(dropDownItem: dropDownItem));
    print('out valu ----> $dropDownItem');
  }

  void onTabChange(BottomNavigationOption value) {
    emit(state.copyWith(navigationOption:  value));
  }

}