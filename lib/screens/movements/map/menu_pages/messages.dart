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
              // color: lightPrimary.withOpacity(0.1),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: lightPrimary.withOpacity(0.3),
                    child: Icon(
                      Icons.mic,
                      size: 22.sp,
                      color: primary,
                    ),
                  ),
                  addHorizontalSpace(10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: lightPrimary.withOpacity(0.3),
                      ),
                      child: TextField(
                        cursorColor: lightPrimary,
                        decoration: InputDecoration(
                          // enabledBorder: InputBorder.none,
                          isDense: true,
                          hintStyle: const TextStyle(color: primary),
                          // fillColor: lightPrimary.withOpacity(0.5),
                          // filled: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 10.h,
                          ),
                          hintText: "Send a message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  addHorizontalSpace(10),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      color: lightPrimary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          " Send",
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        addHorizontalSpace(7),
                        Icon(
                          Icons.send,
                          size: 20.sp,
                          color: primary,
                        ),
                      ],
                    ),
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
