part of 'home_view.dart';

class HomeState extends Equatable {
  final Color color;

  ///for drop down
  final List<String> dropDownItems;
  final String dropDownItemDefaultValue;

  final String currentDate;
  final String currentTime;

  final bool hourFormatOnOff;
  final bool clockInOut;

  final List logsNRequest;
  final int logNRequestClickIndex;

  final String effectiveHours;
  final String grossHours;

  final int arrivalStatus;

  final int totalPercentOfWeekArrival;
  final Duration totalAvgHours;

  final String sinceLastLogin;

  final List<dynamic> getSingleDaysClockData;
  final List<dynamic> getAllDaysClockData;
  final List<dynamic> getLastMonth;

  final SfRangeValues sfRangeValues;// = const SfRangeValues(0.4, 0.8);

  const HomeState(
      {this.color = CommonColor.blueColor,
      this.dropDownItems = const ['Last Week', 'Last Month', 'Custom Range'],
      this.dropDownItemDefaultValue = 'Last Week',
      this.currentDate = "",
      this.currentTime = "",
      this.hourFormatOnOff = false, // 24 hour format
      this.logsNRequest = const ['Attendance Log', 'Shift Schedule', /*'Attendance Request'*/],
      this.logNRequestClickIndex = 0,
      this.clockInOut = false,
      this.effectiveHours ="0h 0m",
      this.grossHours = "0h 0m",
      this.arrivalStatus = 0,
      this.totalPercentOfWeekArrival = 0,
      this.sinceLastLogin = "0h 0m",
      required this.totalAvgHours,
      this.getAllDaysClockData = const [],
      this.getSingleDaysClockData = const [],
      this.getLastMonth = const [],
      // this.isReadWholeData = false,
      this.sfRangeValues = const SfRangeValues(0.4, 0.8),
        // this.attendanceRequestList = const ['Last 7 days', 'Last 14 days', 'Last 30 days','Custom Range'],
      });

  @override
  List<Object?> get props => [
        color,
        dropDownItems,
        dropDownItemDefaultValue,
        currentDate,
        currentTime,
        hourFormatOnOff,
        logsNRequest,
        logNRequestClickIndex,
        clockInOut,
        effectiveHours,
        grossHours,
        arrivalStatus,
        totalPercentOfWeekArrival,
        sfRangeValues,
        sinceLastLogin,
        totalAvgHours,
        getAllDaysClockData,
        getSingleDaysClockData,
        getLastMonth
        // attendanceRequestList,
      ];

  HomeState copyWith(
      {Color? color,
      List<String>? dropDownItems,
      String? dropDownItemDefaultValue,
      String? currentDate,
      String? currentTime,
      bool? onOff,
      bool? hourFormatOnOff,
      List? logsNRequest,
      int? logNRequestClickIndex,
      bool? clockInOut,
      String? effectiveHours,
      String? grossHours,
      int? arrivalStatus,
      int? totalPercentOfWeekArrival,
      Duration? totalAvgHours,
      String? sinceLastLogin,
      SfRangeValues? sfRangeValues,
      List? getAllDaysClockData,
      List? getSingleDaysClockData,
      List? getLastMonth,
      }) {
    return HomeState(
        color: color ?? this.color,
        dropDownItems: dropDownItems ?? this.dropDownItems,
        dropDownItemDefaultValue: dropDownItemDefaultValue ?? this.dropDownItemDefaultValue,
        currentDate: currentDate ?? this.currentDate,
        currentTime: currentTime ?? this.currentTime,
        hourFormatOnOff: hourFormatOnOff ?? this.hourFormatOnOff,
        logsNRequest: logsNRequest ?? this.logsNRequest,
        logNRequestClickIndex: logNRequestClickIndex ?? this.logNRequestClickIndex,
        clockInOut: clockInOut ?? this.clockInOut,
        effectiveHours: effectiveHours ?? this.effectiveHours,
        grossHours: grossHours ?? this.grossHours,
        arrivalStatus: arrivalStatus ?? this.arrivalStatus,
        totalPercentOfWeekArrival: totalPercentOfWeekArrival ?? this.totalPercentOfWeekArrival,
        totalAvgHours: totalAvgHours ?? this.totalAvgHours,
        sinceLastLogin: sinceLastLogin ?? this.sinceLastLogin,
        getAllDaysClockData: getAllDaysClockData ?? this.getAllDaysClockData,
      getSingleDaysClockData: getSingleDaysClockData ?? this.getSingleDaysClockData,
        getLastMonth: getLastMonth ?? this.getLastMonth,
        // attendanceRequestList: attendaceRequestList ?? this.attendanceRequestList,
        sfRangeValues: sfRangeValues ?? this.sfRangeValues,
    );
  }
}
