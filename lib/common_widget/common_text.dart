import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {

  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CommonText({super.key, this.text, this.color, this.fontSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
      ),
    );
  }
}



/*
Text(
'Since Last Login',
style: TextStyle(
color: CommonColor.grey,
fontSize: TextSize.content),
)
*/

