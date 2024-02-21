import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CommonRichText extends StatelessWidget {

  final List<LinkTextSpan> listspan ;

  const CommonRichText({super.key, required this.listspan});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          for(var span in listspan)
            TextSpan(
              text: span.text,
              style: span.linkStyle,
              recognizer: TapGestureRecognizer()..onTap =span.onPressed,
            )
        ],
      ),
    );
  }
}

class LinkTextSpan {
  final String text;
  final VoidCallback? onPressed;
  final TextStyle? linkStyle;

  const LinkTextSpan({
    required this.text,
    this.onPressed,
    this.linkStyle,
  });
}
