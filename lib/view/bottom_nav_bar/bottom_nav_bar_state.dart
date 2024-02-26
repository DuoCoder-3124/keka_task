import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_widget/enum.dart';

class BottomNavBarState extends Equatable {

  ///for drop down
  final BottomNavigationOption navigationOption;

  const BottomNavBarState({
    required this.navigationOption,
  });

  @override
  List<Object?> get props => [navigationOption];

  BottomNavBarState copyWith({
    BottomNavigationOption? navigationOption,
  }) {
    return BottomNavBarState(
      navigationOption: navigationOption ?? this.navigationOption,
    );
  }
}
