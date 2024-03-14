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

    emit(state.copyWith(changeInToOutToIn: timeStartStop));

    final currentTime = DateTime.now().toIso8601String();
    DateTime constTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0);


    ///pending data enter only clock in time not clock out time
    print('bool value ====> ${state.changeInToOutToIn}');
    ApiService.helper.insertClockInData(clockInOutModal: ClockInOutModal(
      userId: '23',
      postClockIn: state.changeInToOutToIn ? currentTime : null,
      postClockOut: state.changeInToOutToIn ? null : currentTime,
      date: state.currentDate,
      effectiveHours: currentTime,
      grossHours: currentTime,
      arrival: (DateTime.now().isBefore(constTime)) ? ArrivalStatus.OnTime.name : ArrivalStatus.Late.name,
    )).then((value){
      getClockInTime();
    });

  }


  /// get In & Out time, read clock data
  Future<void> getClockInTime() async{

    print('>>>>>>>>>>>>>>>>>>>> READ DATA');

    List<dynamic> getClockData = await ApiService
        .helper.readClockInData(userId: '23');

    Duration effectiveTime = Duration();
    Duration grossTime = Duration();

    List getClockInList = getClockData[0].getClockIn;
    List getClockOutList = getClockData[0].getClockOut;
    emit(state.copyWith(arrivalStatus: getClockData[0].arrival));


    /// calculate effective hours and gross hours
    if(getClockOutList.isNotEmpty){

      for (int i = 0; i < getClockOutList.length; i++) {

        /// effective hours
        DateTime dateTime1 = DateTime.parse(getClockInList[i]);
        DateTime dateTime2 = DateTime.parse(getClockOutList[i]);
        // final time1 = DateFormat('hh:mm:ss').format(
        //     DateTime.parse(dateTime1.toIso8601String()));
        // final time2 = DateFormat('hh:mm:ss').format(
        //     DateTime.parse(dateTime2.toIso8601String()));
        effectiveTime = effectiveTime + dateTime2.difference(dateTime1);

        /// gross hours
        DateTime grossTime1 = DateTime.parse(getClockInList.first);
        DateTime grossTime2 = DateTime.parse(getClockOutList.last);
        grossTime = grossTime2.difference(grossTime1);

        print('effective hours ====> $effectiveTime');
        print('gross hours ====> $grossTime');

      }

      emit(state.copyWith(
          effectiveHours: "${effectiveTime.inHours}h ${effectiveTime
              .inMinutes % 60}m",
          grossHours: "${grossTime.inHours}h ${grossTime.inMinutes % 60}m",
      ));
    }

    ///  check if user clock in on time, same time or late
    // DateTime constTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0);
    // if((DateTime.now()).isBefore(constTime)){
    //   print('>>>>> onTime');
    // }else{
    //   print('>>>>> late');
    // }
  }


  /// getUserId
  // void getUserId() async{
  //   List<ClockInOutModal> getUserData = await ApiService.helper.getRegisterUser();
  //   print('getUserData runType ====> ${getUserData.runtimeType}');
  // }

  /// calculate effective and gross hours
  // void calculateTime({}){
  //
  // }

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
