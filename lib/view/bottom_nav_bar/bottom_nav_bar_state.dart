import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_widget/enum.dart';

class BottomNavBarState extends Equatable {
  final Color color;

  ///for drop down
  final List<String> lastSeen;
  final String dropDownItemValue;
  final BottomNavigationOption navigationOption;

  const BottomNavBarState({
    this.color = CommonColor.blueColor,
    this.lastSeen = const ['Last Week', 'Last Month', 'Custom Range'],
    this.dropDownItemValue = 'Last Week',
    required this.navigationOption,
  });

  @override
  List<Object?> get props =>
      [color, lastSeen, dropDownItemValue, navigationOption];

  BottomNavBarState copyWith({
    Color? color,
    List<String>? lastSeen,
    String? dropDownItem,
    BottomNavigationOption? navigationOption,
  }) {
    return BottomNavBarState(
      color: color ?? this.color,
      lastSeen: lastSeen ?? this.lastSeen,
      dropDownItemValue: dropDownItem ?? this.dropDownItemValue,
      navigationOption: navigationOption ?? this.navigationOption,
    );
  }
}
