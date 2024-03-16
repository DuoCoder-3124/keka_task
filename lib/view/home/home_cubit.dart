part of 'home_view.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(super.initialState) {
    getCurrentDate();
    readAllDayClockData();
  }

  void colorChange({Color? color}) {
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
  void getCurrentTime(){
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

    /// get static date 9:00:00 for update arrival status (onTime or Late)
    final currentTime = DateTime.now().toIso8601String();
    DateTime constTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0);

    ///pending data enter only clock in time not clock out time
    ApiService.helper.insertClockInData(clockInOutModal: ClockInOutModal(
      userId: '33',
      postClockIn: state.updateClockInName ? currentTime : null,
      postClockOut: state.updateClockInName ? null : currentTime,
      date: state.currentDate,
      effectiveHours: state.effectiveHours,
      grossHours: state.grossHours,
      arrival: (DateTime.now().isBefore(constTime)) ? ArrivalStatus.OnTime.value : ArrivalStatus.Late.value,
      weekDay: (CalendarFormat.week.index)+1
    )).then((value) async {
      calculateAverageHrsNOnTime();
      // readSingleDayClockData(isReadWholeData: true);
      readAllDayClockData();
      // add : readSingleDayClockData();  and remove : readAllDayClockData();///
    });
  }


  /// get one Day User Data
  Future<List> readSingleDayClockData() async {
    List<dynamic> getSingleDayClockRecord = await ApiService
        .helper.readSingleClockData(
            userId: '33',
            date: DateFormat("E dd, MMM yyyy").format(DateTime.now()),
    );
    calculateEffectiveHrsNGrossHrs();
    // add : sinceLastLogin();
    return getSingleDayClockRecord;
  }


  /// get All Day User Data
  Future<List> readAllDayClockData() async {
    List<dynamic> getAllDayClockRecord = await ApiService
        .helper.readMultiClockData(
        userId: '33',
    );
    emit(state.copyWith(getClockData: getAllDayClockRecord)); // remove
    sinceLastLogin(); // remove
    calculateEffectiveHrsNGrossHrs(); //remove
    return getAllDayClockRecord;
  }

  /// calculate clock in and clock data (effectiveTime & grossTime)
  Future<void> calculateEffectiveHrsNGrossHrs() async{

    Duration effectiveTime = const Duration();
    Duration grossTime = const Duration();

    List<dynamic> getClockData = await readSingleDayClockData();

    List getClockInList = List<dynamic>.from(getClockData[0].getClockIn);
    List getClockOutList = List<dynamic>.from(getClockData[0].getClockOut);

    emit(state.copyWith(arrivalStatus: state.getClockData[0].arrival)); // remove this line
    // add : emit(state.copyWith(arrivalStatus: getClockData[0].arrival));


    /// calculate effective hours and gross hours
    if(getClockOutList.isNotEmpty){
      for (int i = 0; i < getClockOutList.length; i++) {

        /// effective hours
        DateTime dateTime1 = DateTime.parse(getClockInList[i]);
        DateTime dateTime2 = DateTime.parse(getClockOutList[i]);
        effectiveTime = effectiveTime + dateTime2.difference(dateTime1);

        /// gross hours
        DateTime grossTime1 = DateTime.parse(getClockInList.first);
        DateTime grossTime2 = DateTime.parse(getClockOutList.last);
        grossTime = grossTime2.difference(grossTime1);

        print('effective hours ====> $effectiveTime');
        print('gross hours ====> $grossTime');

      }
    }
    emit(state.copyWith(
      effectiveHours: "${effectiveTime.inHours}h ${effectiveTime
          .inMinutes % 60}m",
      grossHours: "${grossTime.inHours}h ${grossTime.inMinutes % 60}m",
    ));

  }


  /// calculate avg hrs & on time depending on last week & last month
  void calculateAverageHrsNOnTime() async{
    List<dynamic> addArrivalStatus = [];
    List<dynamic> addHours = [];
    int totalPresentState = 0;
    List<dynamic> getClockData = await readSingleDayClockData(); ///remove and add: readAllDayClockData()
    // emit(state.copyWith(isReadWholeData: true));
    // print('List of data ====> ${state.getClockData}');

    /// for onTime
    for(int i=0; i < getClockData.length; i++){
     if(((CalendarFormat.week.index)+1) == (getClockData[i].weekDay)){

        /// add arrivalTime
        addArrivalStatus.add(getClockData[i].arrival);
        if(getClockData[i].arrival == 1) {
          totalPresentState = totalPresentState + 1;
        }

        ///add time
        // addHours.add(getClockData[i].grossHours);
     }
    }


    ///calculate avg onTime
    final totalPercentOfArrival = (100/5)*totalPresentState;
    print('int ====> ${totalPercentOfArrival}');

    ///calculate avg hrs
    // List<DateTime> allDate = addHours.map((dates) => DateTime.parse(dates)).toList();
    // Duration duration = allDate.fold(Duration.zero, (a, b) => a + b.difference(DateTime(0)));
    // int dateLength = allDate.length;
    // Duration avgDuration = duration ~/ dateLength;
    // DateTime avgDate = DateTime(0).add(avgDuration).toLocal();
    // // String avgTime = DateFormat('hhH mmM').format(DateTime.parse(avgDate.toIso8601String()));
    // print('date => ${avgDate.hour}H ');
    //
    emit(state.copyWith(
        totalPercentOfWeekArrival: (totalPercentOfArrival.toInt()),
        // totalAvgHours: avgDuration
    ));
  }


  /// since last login
  void sinceLastLogin() async{
    List<dynamic> getClockData = await readSingleDayClockData();
    print('since login data =====> ${getClockData[0].getClockIn}');
    List<dynamic> getClockIn = List<dynamic>.from(getClockData[0].getClockIn);
    print('since login data length 22=====> ${getClockIn}');
    DateTime lastIndexDate = DateTime.parse(getClockIn.last);
    print('since last login last date =====> ${getClockIn.last}');

    print('since last Login =====> $sinceLastLogin');

    Timer.periodic(const Duration(minutes: 1), (timer) {
      Duration sinceLastLogin = (DateTime.now()).difference(lastIndexDate);
      print('since login time ====> ${sinceLastLogin.inHours}h ${sinceLastLogin.inMinutes%60}m');
      emit(state.copyWith(sinceLastLogin: '${sinceLastLogin.inHours}h ${sinceLastLogin.inMinutes%60}m'));
    });
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
