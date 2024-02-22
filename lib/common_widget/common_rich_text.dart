import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';

class CommonRichText extends StatelessWidget {

  final List<LinkTextSpan> listSpan ;

  const CommonRichText({super.key, required this.listSpan});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          for(var span in listSpan)
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
