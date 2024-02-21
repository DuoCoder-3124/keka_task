import 'package:flutter/material.dart';
import 'package:keka_task/common_widget/common_text.dart';

class CommonTextButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final Widget? child;

  const CommonTextButton({
    super.key, this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: CommonText()
    );
  }
}
