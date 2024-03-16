part of 'home_view.dart';

class HomeState extends Equatable {

  ///for drop down
  final List<String> dropDownItems;
  final String dropDownItemDefaultValue;
  final Color color;

  final String currentDate;
  final String currentTime;

  final bool hourFormatOnOff;
  final bool updateClockInName;

  final List logsNRequest;
  final int logNRequestClickIndex;

  // final List attendanceRequestList;

  final String effectiveHours;
  final String grossHours;
  final int arrivalStatus;
  final int totalPercentOfWeekArrival;
  final Duration totalAvgHours;
  final String sinceLastLogin;
  // final bool isReadWholeData;

  final List<dynamic> getClockData;

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
        this.updateClockInName = false,
        this.effectiveHours = "0h 0m",
        this.grossHours = "0h 0m",
        this.arrivalStatus = 0,
        this.totalPercentOfWeekArrival = 0,
        this.sinceLastLogin = "0h 0m",
        required this.totalAvgHours,
        this.getClockData = const [],
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
    updateClockInName,
    effectiveHours,
    grossHours,
    arrivalStatus,
    totalPercentOfWeekArrival,
    sfRangeValues,
    sinceLastLogin,
    totalAvgHours,
    // isReadWholeData,
    getClockData
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
        bool? updateClockInName,
        String? effectiveHours,
        String? grossHours,
        int? arrivalStatus,
        int? totalPercentOfWeekArrival,
        Duration? totalAvgHours,
        String? sinceLastLogin,
        // bool? isReadWholeData,
        // List? attendaceRequestList,
        SfRangeValues? sfRangeValues,
        List? getClockData
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
      updateClockInName: updateClockInName ?? this.updateClockInName,
      effectiveHours: effectiveHours ?? this.effectiveHours,
      grossHours: grossHours ?? this.grossHours,
      arrivalStatus: arrivalStatus ?? this.arrivalStatus,
      totalPercentOfWeekArrival: totalPercentOfWeekArrival ?? this.totalPercentOfWeekArrival,
      totalAvgHours: totalAvgHours ?? this.totalAvgHours,
      sinceLastLogin: sinceLastLogin ?? this.sinceLastLogin,
      getClockData: getClockData ?? this.getClockData,
      // isReadWholeData: isReadWholeData ?? this.isReadWholeData,
      // attendanceRequestList: attendaceRequestList ?? this.attendanceRequestList,
      sfRangeValues: sfRangeValues ?? this.sfRangeValues,
    );
  }
}
