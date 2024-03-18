part of 'home_view.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(super.initialState) {
    getCurrentDate();
    readAllDayClockData();
    calculateAverageHrsNOnTime();
    getMonth();
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
  Future<void> changeInOutText({bool? timeStartStop}) async {

    emit(state.copyWith(clockInOut: timeStartStop));

    /// get static date 9:00:00 for update arrival status (onTime or Late)
    final currentTime = DateTime.now().toIso8601String();
    DateTime constTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0);

    var userId=await ApiService.helper.getUserId();

    ///pending data enter only clock in time not clock out time
    ApiService.helper.insertClockInData(clockInOutModal: ClockInOutModal(
      userId: userId,
      postClockIn: state.clockInOut ? currentTime : null,
      postClockOut: state.clockInOut ? null : currentTime,
      date: state.currentDate,
      effectiveHours: state.effectiveHours, ///'${state.effectiveHours.inHours}h ${state.effectiveHours.inMinutes%60}m',
      grossHours: state.grossHours, ///'${state.grossHours.inHours}h ${state.grossHours.inMinutes%60}m',
      arrival: (DateTime.now().isBefore(constTime)) ? ArrivalStatus.OnTime.value : ArrivalStatus.Late.value,
      weekDay: (CalendarFormat.week.index)+1
    )).then((value) async {
      await readSingleDayClockData();///
      await readAllDayClockData();
      print('read Called= ====>');
    });
  }


  /// get one Day User Data
  Future<List<dynamic>> readSingleDayClockData() async {

    var userId=await ApiService.helper.getUserId();

    print('read Called== ====>');
    List<dynamic> getSingleDayClockRecord = await ApiService
        .helper.readSingleClockData(
            userId: userId??"",
            date: DateFormat("E dd, MMM yyyy").format(DateTime.now()),
    ).then((value) => readAllDayClockData());
    emit(state.copyWith(getSingleDaysClockData: getSingleDayClockRecord));
    state.clockInOut ? sinceLastLogin() : calculateEffectiveHrsNGrossHrs();
    return getSingleDayClockRecord;
  }

  /// get All Day User Data
  Future<List<dynamic>> readAllDayClockData() async {

    var userId=await ApiService.helper.getUserId();


    List<dynamic> getAllDayClockRecord = await ApiService
        .helper.readMultiClockData(
        userId: userId??'',
    );
    emit(state.copyWith(getAllDaysClockData: getAllDayClockRecord));
    return getAllDayClockRecord;
  }

  /// calculate clock in and clock data (effectiveTime & grossTime)
  Future<void> calculateEffectiveHrsNGrossHrs() async{

    Duration effectiveTime = const Duration();
    Duration grossTime = const Duration();

    List<dynamic> getClockData = state.getSingleDaysClockData;

    List<dynamic> getClockInList = List<dynamic>.from(getClockData[0].getClockIn);
    List<dynamic> getClockOutList = List<dynamic>.from(getClockData[0].getClockOut);

    emit(state.copyWith(arrivalStatus: getClockData[0].arrival));

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

        print('effective hours =====> ${effectiveTime}');
        print('gross hours =====> ${grossTime}');

      }
      changeInOutText();
    }
    emit(state.copyWith(
      effectiveHours: "${effectiveTime.inHours}h ${effectiveTime.inMinutes%60}m",
      grossHours: "${grossTime.inHours}h ${grossTime.inMinutes%60}m",
    ));
  }


  /// calculate avg hrs & on time depending on last week & last month
  void calculateAverageHrsNOnTime() async{
    List<dynamic> addArrivalStatus = [];
    List<dynamic> addHours = [];
    int totalPresentState = 0;
    List<dynamic> getClockData = state.getAllDaysClockData;
    print('List of data ====> ${state.getAllDaysClockData}');

    /// for onTime
    for(int i=0; i < getClockData.length; i++){
     if(((CalendarFormat.week.index)+1) == (getClockData[i].weekDay)){

        /// add arrivalTime
        addArrivalStatus.add(getClockData[i].arrival);
        if(getClockData[i].arrival == "OnTime") {
          totalPresentState = totalPresentState + 1;
        }

        ///add time
        addHours.add(getClockData[i].grossHours);
     }
    }

    print('hello');
    ///calculate avg onTime
    final totalPercentOfArrival = (100/5)*totalPresentState;
    print('int ====> ${totalPercentOfArrival}');

    ///calculate avg hrs
    // print('datatype in ${addHours[0].runtimeType}');
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
    List<dynamic> getClockData = state.getSingleDaysClockData;
    List<dynamic> getClockInData = List<dynamic>.from(getClockData[0].getClockIn);
    DateTime getLastInTime = DateTime.parse(getClockInData.last);
    print('getClockInData ====> $getClockInData');
    print('last time  ====> $getLastInTime');

    Timer.periodic(const Duration(minutes: 1), (timer) {
      Duration sinceLastLogin = (DateTime.now()).difference(getLastInTime);
      print('since login time ====> ${sinceLastLogin.inHours}h ${sinceLastLogin.inMinutes%60}m');
      emit(state.copyWith(sinceLastLogin: '${sinceLastLogin.inHours}h ${sinceLastLogin.inMinutes%60}m'));
    });
  }

  /// get 30 Days and last 3-month
  void getMonth(){
    DateTime getCurrentMonth = DateTime.now();
    List getLastMonth = ['30 Days'];
    for(int i=1; i<=3 ; i++){
      final dateTime = DateFormat('MMM').format(DateTime.parse(DateTime(getCurrentMonth.year, getCurrentMonth.month-i).toIso8601String()));
      getLastMonth.add(dateTime);
    }
    emit(state.copyWith(getLastMonth: getLastMonth));
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
