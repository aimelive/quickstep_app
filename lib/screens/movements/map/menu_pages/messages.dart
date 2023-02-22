import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 10,
        // foregroundColor: primary,
        title: const Text("Messages"),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text("No messages yet"),
            ),
          ),
          SafeArea(
            child: Container(
              color: white,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Row(
                children: [
                  Icon(
                    Icons.mic,
                    size: 26.sp,
                    color: primary,
                  ),
                  addHorizontalSpace(10),
                  Expanded(
                    child: TextField(
                      cursorColor: lightPrimary,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.r),
                          borderSide: BorderSide(
                            color: primary,
                            width: 2.w,
                          ),
                        ),
                        isDense: true,
                        hintStyle: const TextStyle(color: primary),
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 10.h,
                        ),
                        hintText: "Enter a message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                    ),
                  ),
                  addHorizontalSpace(10),
                  Icon(
                    Icons.send,
                    size: 26.sp,
                    color: primary,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
