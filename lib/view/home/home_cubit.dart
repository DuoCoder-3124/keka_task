part of 'home_view.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit(super.initialState);

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
