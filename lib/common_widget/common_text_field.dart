  import 'package:flutter/material.dart';


  class CommonTextField extends StatelessWidget {

    final Widget? suffixIcon;
    final TextInputType? keyboardType;
    final bool? isVisiblePassword;
    final String? hintText;
    final TextEditingController? controller;
    final FormFieldValidator<String>? validator;
    final ValueChanged? onChanged;
    final int? maxLength;


    const CommonTextField({
      super.key, this.suffixIcon, this.keyboardType, this.isVisiblePassword,
      this.hintText, this.controller, this.validator, this.maxLength,this.onChanged});

    @override
    Widget build(BuildContext context) {
      return TextFormField(
        maxLength: maxLength,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: isVisiblePassword??false,
        obscuringCharacter: '*',
        cursorColor: const Color(0xff787878),
        decoration: InputDecoration(
          counterText: '',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xff787878), width: 1.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff787878), width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: suffixIcon,
          hintText: hintText,
          hoverColor: const Color(0xff787878),
          hintStyle: const TextStyle(
              fontFamily: 'Proxima Nova',
              color: Color(0xff787878),
              fontWeight: FontWeight.w400,
              fontSize: 14.0,),
        ),
      );
    }
  }

