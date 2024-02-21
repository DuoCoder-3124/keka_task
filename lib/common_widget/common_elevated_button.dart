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

class CustomAppButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Color? color;

  const CustomAppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding,
    this.height,
    this.width,
    this.textStyle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: padding ?? const EdgeInsetsDirectional.symmetric(horizontal: Spacing.normal),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.large))),
        child: Text(
          text ?? "",
          style: textStyle ?? const TextStyle(color: Colors.white, fontSize: TextSize.label),
        ),
      ),
    );
  }
}
