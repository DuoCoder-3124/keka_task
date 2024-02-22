part of 'home_view.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit(super.initialState){
    getCurrentDate();
  }

  void colorChange({Color? color}){
    color = Colors.green;
    emit(state.copyWith(color: color));
  }

  ///change drop down button item
  void dropDownItemUpdate({String? dropDownItem}){
    emit(state.copyWith(dropDownMenuItem: dropDownItem));
  }

  ///retrive current date
  void getCurrentDate(){
    // String date = DateFormat('E dd, MMM yyyy').format(DateTime.now());
    emit(state.copyWith(currentDate: DateFormat('E dd, MMM yyyy').format(DateTime.now())));
  }

  ///retrive current time
  getCurrentTime(){
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // String time = DateFormat('hh:MM:ss a').format(DateTime.now());
      emit(state.copyWith(currentTime: DateFormat('hh:MM:ss a').format(DateTime.now())));
    });
  }


  hourFormatOnOff({isHourFormatOn}){
    emit(state.copyWith(hourFormatOnOff: isHourFormatOn));
  }

}
