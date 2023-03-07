import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/colors.dart';

class OTPNumberBoxWidget extends StatelessWidget {
  const OTPNumberBoxWidget({
    super.key,required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.r,
      width: 54.r,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.r),
      decoration: BoxDecoration(
        color: lightPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: lightPrimary,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        cursorColor: lightPrimary,
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: TextStyle(
          height: 1.5,
          color: primary,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1)
        ],
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: lightPrimary, width: 2),
          ),
        ),
      ),
    );
  }
}
