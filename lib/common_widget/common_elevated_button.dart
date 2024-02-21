import 'package:flutter/material.dart';
import 'package:keka_task/common_attribute/common_value.dart';


class CommonElevatedButton extends StatelessWidget {
  final Widget? text;
  final double? buttonHeight;
  final double? buttonWidth;
  final EdgeInsetsDirectional? buttonOuterPadding;
  final EdgeInsetsDirectional? buttonInnerPadding;
  final Color? buttonColor;
  final VoidCallback? onClick;

  const CommonElevatedButton(
      {super.key,
      this.text,
      this.buttonHeight,
      this.buttonWidth,
      this.buttonOuterPadding,
      this.buttonInnerPadding,
      this.buttonColor,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      // height: buttonHeight,
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(backgroundColor: buttonColor, padding: buttonInnerPadding),
        child: text,
      ),
    );
  }
}


