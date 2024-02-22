import 'package:flutter/material.dart';
import 'package:keka_task/common_attribute/common_value.dart';

class CommonElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Color? color;
  final double? borderRadius;
  final Widget? child;

  const CommonElevatedButton({
    super.key,
    required this.onPressed,
    this.padding,
    this.height,
    this.width,
    this.textStyle,
    this.color,
    this.borderRadius, this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      focusColor: Colors.red,
      onPressed: onPressed ?? () {},
      color: color ?? Colors.blue,
      padding: padding,
      // style: ElevatedButton.styleFrom(
      //     backgroundColor: color,
      //     padding: padding ?? const EdgeInsetsDirectional.symmetric(horizontal: Spacing.normal),
      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius??Spacing.large))),
      child: child,
    );
  }
}

