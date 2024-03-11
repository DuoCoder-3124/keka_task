part of 'home_view.dart';

class HomeState extends Equatable {
  final Color color;

  ///for drop down
  final List<String> lastSeen;
  final String dropDownItemValue;

  final String currentDate;
  final String currentTime;

  final bool hourFormatOnOff;
  final bool timeStartStop;

  final List logsNRequest;
  final int logNRequestClickIndex;

  final List attendaceRequestList;

  final SfRangeValues sfRangeValues;// = const SfRangeValues(0.4, 0.8);



  const HomeState(
      {this.color = CommonColor.blueColor,
      this.lastSeen = const ['Last Week', 'Last Month', 'Custom Range'],
      this.dropDownItemValue = 'Last Week',
      this.currentDate = "",
      this.currentTime = "",
      this.hourFormatOnOff = false,
      this.logsNRequest = const ['Attendance Log', 'Shift Schedule', 'Attendance Request'],
      this.logNRequestClickIndex = 0,
      this.timeStartStop = false,
      this.attendaceRequestList = const ['Last 7 days', 'Last 14 days', 'Last 30 days','Custom Range'],
      this.sfRangeValues = const SfRangeValues(0.4, 0.8)
      });

  @override
  List<Object?> get props => [
        color,
        lastSeen,
        dropDownItemValue,
        currentDate,
        currentTime,
        hourFormatOnOff,
        logsNRequest,
        logNRequestClickIndex,
        timeStartStop,
        attendaceRequestList,
        sfRangeValues
      ];

  HomeState copyWith(
      {Color? color,
      List<String>? lastSeen,
      String? dropDownMenuItem,
      String? currentDate,
      String? currentTime,
      bool? onOff,
      bool? hourFormatOnOff,
      List? logsNRequest,
      int? logNRequestClickIndex,
      bool? timeStartStop,
      List? attendaceRequestList,
      SfRangeValues? sfRangeValues
      }) {
    return HomeState(
        color: color ?? this.color,
        lastSeen: lastSeen ?? this.lastSeen,
        dropDownItemValue: dropDownMenuItem ?? dropDownItemValue,
        currentDate: currentDate ?? this.currentDate,
        currentTime: currentTime ?? this.currentTime,
        hourFormatOnOff: hourFormatOnOff ?? this.hourFormatOnOff,
        logsNRequest: logsNRequest ?? this.logsNRequest,
        logNRequestClickIndex: logNRequestClickIndex ?? this.logNRequestClickIndex,
        timeStartStop: timeStartStop ?? this.timeStartStop,
        attendaceRequestList: attendaceRequestList ?? this.attendaceRequestList,
        sfRangeValues: sfRangeValues ?? this.sfRangeValues
    );
  }
}
