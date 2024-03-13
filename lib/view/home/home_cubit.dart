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
    emit(state.copyWith(dropDownItemDefaultValue: dropDownItem));
  }

  ///retrive current date
  void getCurrentDate() {
    emit(
      state.copyWith(
        currentDate: DateFormat('E dd, MMM yyyy').format(DateTime.now()),
      ),
    );
  }

  ///retrive current time
  void getCurrentTime() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(
        state.copyWith(
          currentTime: DateFormat('hh:mm:ss a').format(DateTime.now()),
        ),
      );
    });
  }

  /// update clockIn to ClockOut OR ClockOut to clockIn
  void changeInOutText({required bool timeStartStop}) {

    String time = "xyz";

    ApiHelper.instance.insertClockInData(clockInOutModal: ClockInOutModal(
      userId: '1',
      clockIn: state.changeInToOutToIn ? [state.currentTime] : [],
      clockOut: state.changeInToOutToIn ? [] : [state.currentTime],
      date: state.currentDate,
      effectiveHours: time,
      grossHours: time,
      arrival: "1",
    ));
    print('time ===> $time');
    // emit(state.copyWith(changeInToOutToIn: timeStartStop));

  }

  ///insert Clock Record
  // void insertClockInData({required ClockInOutModal clockInOutModal}){
  //
  //   // print('cubit time ====> ${state.currentTime}');
  //
  //   // ApiHelper.instance.insertClockInData(clockInOutModal: ClockInOutModal(
  //   //   userId: '1',
  //   //   clockIn: state.changeInToOutToIn ? [state.currentTime] : [],
  //   //   clockOut: state.changeInToOutToIn ? [] : [state.currentTime],
  //   //   date: state.currentDate,
  //   //   effectiveHours: state.currentTime,
  //   //   grossHours: state.currentTime,
  //   //   arrival: "1",
  //   // ));
  // }

  /// get clock in time
  void getClockInTime() {}

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

/*void getCurrentTime({bool? timeStartStop}) {
    print('timer value ----> $timeStartStop');
      Timer.periodic(const Duration(seconds: 1), (timer) {
        emit(state.copyWith(
            currentTime: DateFormat('hh:mm:ss a').format(DateTime.now()),
            // timeStartStop: timeStartStop
        ));
        print('inside value ===> ${state.timeStartStop}');
      });

  }*/
