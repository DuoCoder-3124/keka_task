part of 'home_view.dart';

class HomeState extends Equatable {
  final Color color;

  ///for drop down
  final List<String> lastSeen;
  final String dropDownItemValue;

  const HomeState({
    this.color = CommonColor.blueColor,
    this.lastSeen = const ['Last Week', 'Last Month', 'Custom Range'],
    this.dropDownItemValue = 'Last Week',
  });

  @override
  List<Object?> get props =>
      [color, lastSeen, dropDownItemValue, ];

  HomeState copyWith({
    Color? color,
    List<String>? lastSeen,
    String? dropDownItem,
  }) {
    return HomeState(
      color: color ?? this.color,
      lastSeen: lastSeen ?? this.lastSeen,
      dropDownItemValue: dropDownItem ?? this.dropDownItemValue,
    );
  }
}
