import 'package:flutter/material.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_value.dart';

class CommonContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final EdgeInsetsDirectional? padding;
  final Color? color;

  const CommonContainer(
      {super.key, this.width, this.height, this.child, this.borderColor, this.padding, this.borderWidth, this.borderRadius, this.color, });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: borderColor ?? Colors.white,
          width: borderWidth ?? 0,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 0)
      ),
      child: child,
    );
  }
}
