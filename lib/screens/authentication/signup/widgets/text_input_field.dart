import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({
    Key? key,
    required this.hintText,
    this.obsecureText = false,
    this.onChanged,
  }) : super(key: key);

  final String hintText;
  final bool obsecureText;
  final void Function(String value)? onChanged;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool showPwd = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      style: const TextStyle(
        color: primary,
        fontWeight: FontWeight.w600,
      ),
      cursorColor: lightPrimary,
      obscureText: widget.obsecureText && !showPwd,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        hintText: "Enter ${widget.hintText}",
        hintStyle: TextStyle(
          color: grey400,
        ),
        suffixIcon: widget.obsecureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showPwd = !showPwd;
                  });
                },
                icon: Icon(
                  showPwd
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 14.h,
        ),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            width: 2,
            color: grey400,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            width: 2,
            color: lightPrimary,
          ),
        ),
      ),
    );
  }
}
