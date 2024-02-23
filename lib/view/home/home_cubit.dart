part of 'home_view.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(super.initialState) {
    getCurrentDate();
  }

  void colorChange({Color? color}) {
    color = Colors.green;
    emit(state.copyWith(color: color));
  }

  ///change drop down button item
  void dropDownItemUpdate({String? dropDownItem}) {
    emit(state.copyWith(dropDownMenuItem: dropDownItem));
  }

  ///retrive current date
  void getCurrentDate() {
    // String date = DateFormat('E dd, MMM yyyy').format(DateTime.now());
    emit(state.copyWith(
        currentDate: DateFormat('E dd, MMM yyyy').format(DateTime.now())));
  }

  ///retrive current time
  void getCurrentTime({timeStartStop}) {
    print('timer value ----> $timeStartStop');

    if (timeStartStop == true) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        emit(state.copyWith(
            currentTime: DateFormat('hh:MM:ss a').format(DateTime.now()),
            timeStartStop: timeStartStop
        ));
        print('inside value ===> ${state.timeStartStop}');
      });
    }
    else{
      emit(state.copyWith(
          currentTime: DateFormat('hh:MM:ss a').format(DateTime.now()),
          timeStartStop: timeStartStop
      ));
    }

  }

  ///24 hour format on off
  void hourFormatOnOff({isHourFormatOn}) {
    emit(state.copyWith(hourFormatOnOff: isHourFormatOn));
  }

  ///get index when i click attendance log, shift schedule and attendance request
  void getIndex({index}) {
    emit(state.copyWith(logNRequestClickIndex: index));
    print(index);
  }
}

/*  void getCurrentTime(){
    Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(state.copyWith(currentTime: DateFormat('hh:MM:ss a').format(DateTime.now())));
    });
  }
*/
