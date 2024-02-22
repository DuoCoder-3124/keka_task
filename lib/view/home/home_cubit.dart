import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keka_task/view/home/home_state.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit(super.initialState);

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

}