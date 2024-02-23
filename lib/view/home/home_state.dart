part of 'home_view.dart';

class HomeState extends Equatable {
  final Color color;

  ///for drop down
  final List<String> lastSeen;
  final String dropDownItemValue;

  final String currentDate;
  final String currentTime;

  final bool hourFormatOnOff;

  final List logsNRequest;
  final int logNRequestClickIndex;


  const HomeState(
      {this.color = CommonColor.blueColor,
      this.lastSeen = const ['Last Week', 'Last Month', 'Custom Range'],
      this.dropDownItemValue = 'Last Week',
      this.currentDate = "",
      this.currentTime = "",
      this.hourFormatOnOff = false,
      this.logsNRequest = const ['Attendance Log', 'Shift Schedule', 'Attendance Request'],
      this.logNRequestClickIndex = 0
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
        logNRequestClickIndex
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
      int? logNRequestClickIndex
      }) {
    return HomeState(
        color: color ?? this.color,
        lastSeen: lastSeen ?? this.lastSeen,
        dropDownItemValue: dropDownMenuItem ?? dropDownItemValue,
        currentDate: currentDate ?? this.currentDate,
        currentTime: currentTime ?? this.currentTime,
        hourFormatOnOff: hourFormatOnOff ?? this.hourFormatOnOff,
        logsNRequest: logsNRequest ?? this.logsNRequest,
        logNRequestClickIndex: logNRequestClickIndex ?? this.logNRequestClickIndex
    );
  }
}
