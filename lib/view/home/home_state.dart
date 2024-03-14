part of 'home_view.dart';

class HomeState extends Equatable {
  final Color color;

  ///for drop down
  final List<String> dropDownItems;
  final String dropDownItemDefaultValue;

  final String currentDate;
  final String currentTime;

  final bool hourFormatOnOff;
  final bool changeInToOutToIn;

  final List logsNRequest;
  final int logNRequestClickIndex;

  // final List attendanceRequestList;

  final String effectiveHours;
  final String grossHours;
  final String arrivalStatus;

  final SfRangeValues sfRangeValues;// = const SfRangeValues(0.4, 0.8);

  const HomeState(
      {this.color = CommonColor.blueColor,
      this.dropDownItems = const ['Last Week', 'Last Month', 'Custom Range'],
      this.dropDownItemDefaultValue = 'Last Week',
      this.currentDate = "",
      this.currentTime = "",
      this.hourFormatOnOff = false,
      this.logsNRequest = const ['Attendance Log', 'Shift Schedule', /*'Attendance Request'*/],
      this.logNRequestClickIndex = 0,
      this.changeInToOutToIn = false,
      this.effectiveHours = "0h 0m",
      this.grossHours = "0h 0m",
      this.arrivalStatus = "",
      // this.attendanceRequestList = const ['Last 7 days', 'Last 14 days', 'Last 30 days','Custom Range'],
      this.sfRangeValues = const SfRangeValues(0.4, 0.8)
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
        changeInToOutToIn,
        effectiveHours,
        grossHours,
        arrivalStatus,
        // attendanceRequestList,
        sfRangeValues
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
      bool? changeInToOutToIn,
      String? effectiveHours,
      String? grossHours,
      String? arrivalStatus,
      // List? attendaceRequestList,
      SfRangeValues? sfRangeValues
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
        changeInToOutToIn: changeInToOutToIn ?? this.changeInToOutToIn,
        effectiveHours: effectiveHours ?? this.effectiveHours,
        grossHours: grossHours ?? this.grossHours,
        arrivalStatus: arrivalStatus ?? this.arrivalStatus,
        // attendanceRequestList: attendaceRequestList ?? this.attendanceRequestList,
        sfRangeValues: sfRangeValues ?? this.sfRangeValues
    );
  }
}
