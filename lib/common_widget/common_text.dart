import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {

  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const CommonText({super.key, this.text, this.color, this.fontSize, this.fontWeight, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
      ),
      textAlign: textAlign,
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

