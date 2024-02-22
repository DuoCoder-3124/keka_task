import 'package:flutter/material.dart';
import 'package:keka_task/common_attribute/common_value.dart';

class CommonElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final Color? color;
  final Widget? child;
  final ShapeBorder? shape;
  final double? elevation;

  const CommonElevatedButton({
    super.key,
    required this.onPressed,
    this.padding,
    this.height,
    this.width,
    this.color,
    this.child,
    this.shape,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      focusColor: Colors.red,
      padding: padding,
      onPressed: onPressed ?? () {},
      color: color ?? Colors.blue,
      shape: shape,
      elevation: elevation,
      child: child,
    );
  }
}
