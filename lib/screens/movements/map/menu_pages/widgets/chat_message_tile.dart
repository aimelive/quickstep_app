import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/models/user.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatMessageTile extends StatefulWidget {
  const ChatMessageTile(
      {super.key, required this.message, required this.isSender});

  final ChatMessage message;
  final bool isSender;

  @override
  State<ChatMessageTile> createState() => _ChatMessageTileState();
}

class _ChatMessageTileState extends State<ChatMessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment:
            widget.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!widget.isSender)
            CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.grey.shade400,
              foregroundImage: NetworkImage(widget.message.user.imgUrl),
            ),
          addHorizontalSpace(8),
          if (!widget.isSender)
            Container(
              width: 4,
              height: 4,
              color: lightPrimary,
            ),
          Container(
            width: 200.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: widget.isSender ? primary : lightPrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.isSender ? 15.r : 0.r),
                topRight: Radius.circular(widget.isSender ? 0.r : 15.r),
                bottomRight: Radius.circular(15.r),
                bottomLeft: Radius.circular(15.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: widget.isSender
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!widget.isSender)
                  Text(
                    widget.message.user.username,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.5.h),
                  child: Text(
                    widget.message.message,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: widget.isSender ? white : Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${timeago.format(widget.message.sentAt)} ${(widget.message.seen == true) && widget.isSender ? ". seen" : ""}",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: widget.isSender ? grey400 : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.isSender)
            Container(
              width: 4,
              height: 4,
              color: primary,
            ),
        ],
      ),
    );
  }
}
