import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const CommonText({
    super.key,this.text, this.fontSize, this.fontWeight, this.color, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        style: TextStyle(color: color, fontSize: fontSize,
            fontWeight: fontWeight, fontFamily: 'Proxima Nova'),
            textAlign: textAlign,
    );
  }



}
