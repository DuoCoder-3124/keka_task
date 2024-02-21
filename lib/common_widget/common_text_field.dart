  import 'package:flutter/material.dart';
import 'package:keka_task/common_widget/common_padding.dart';


  class CommonTextField extends StatelessWidget {

    final Widget? child;
    final TextInputType? inputType;
    final bool? isVisiblePassword;
    final String? fieldTxt;
    final TextEditingController? textEditingController;
    final FormFieldValidator<String>? validator;
    final ValueChanged? onChanged;
    final textLength;


    const CommonTextField({
      super.key, this.child, this.inputType, this.isVisiblePassword,
      this.fieldTxt, this.textEditingController, this.validator, this.textLength,this.onChanged});

    @override
    Widget build(BuildContext context) {
      return TextFormField(
        maxLength: textLength,
        controller: textEditingController,
        validator: validator,
        onChanged: onChanged,
        keyboardType: inputType,
        obscureText: isVisiblePassword!,
        obscuringCharacter: '*',
        cursorColor: const Color(0xff787878),
        decoration: InputDecoration(
          counterText: '',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(115),
              borderSide: const BorderSide(color: Color(0xff787878), width: 1.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff787878), width: 1.0),
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: child,
          hintText: fieldTxt,
          hoverColor: const Color(0xff787878),
          hintStyle: const TextStyle(
              fontFamily: 'Proxima Nova',
              color: Color(0xff787878),
              fontWeight: FontWeight.w400,
              fontSize: 14.0),
        ),
      );
    }
  }
