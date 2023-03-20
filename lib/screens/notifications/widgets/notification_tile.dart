import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickstep_app/controllers/movements_controller.dart';
import 'package:quickstep_app/models/notification.dart';
import 'package:quickstep_app/screens/components/warn_method.dart';
import 'package:quickstep_app/services/db_service.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationTile extends StatefulWidget {
  const NotificationTile({
    Key? key,
    required this.notification,
    required this.onDeleted,
    required this.dbService,
  }) : super(key: key);

  final AppNotification notification;
  final VoidCallback onDeleted;
  final DBService dbService;

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool isDeleting = false;
  bool isDeclining = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: lightPrimary.withOpacity(0.7),
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -20,
            left: -20,
            child: CircleAvatar(
              radius: 25.sp,
              backgroundColor: primary,
              foregroundColor: white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 18.w,
              top: 12.h,
              right: 12.w,
              bottom: 12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "      ${timeago.format(widget.notification.createdAt)}",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade500,
                  ),
                ),
                addVerticalSpace(5),
                Text(
                  actionsStr[widget.notification.action] ?? "UNKNOWN ACTION",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800,
                  ),
                ),
                addVerticalSpace(8),
                Text(widget.notification.message),
                addVerticalSpace(10),
                if (widget.notification.action == NotificationAction.join)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.arrow_back,
                            size: 20.sp,
                          ),
                          onPressed: isDeleting || isDeclining
                              ? null
                              : () async {
                                  final movement =
                                      await widget.dbService.getOneMovement(
                                    widget.notification.data["movementId"],
                                  );
                                  if (movement == null || !mounted) return;
                                  popPage(context, data: movement);
                                },
                          style: ElevatedButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: Size.zero,
                            backgroundColor: primary,
                            disabledBackgroundColor: lightPrimary,
                            disabledForegroundColor: white,
                            padding: EdgeInsets.symmetric(
                              vertical: 2.5.h,
                              horizontal: 15.w,
                            ),
                          ),
                          label: Text(
                            "Join movement",
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: isDeclining || isDeleting
                            ? null
                            : () async {
                                final wantDecline = await warnMethod(
                                  context,
                                  title: "Decline Movement",
                                  subtitle:
                                      "Are you sure do you want to decline joining the movement?",
                                  okButtonText: "Decline",
                                );
                                if (wantDecline != true) return;
                                setState(() {
                                  isDeclining = true;
                                });
                                final left =
                                    await widget.dbService.leaveMovement(
                                  widget.notification.data["movementId"],
                                );
                                setState(() {
                                  isDeclining = left;
                                });
                                if (!left) return;
                                final notificitionDeleted =
                                    await widget.dbService.deleteNotification(
                                  widget.notification.id,
                                );
                                setState(() {
                                  isDeclining = notificitionDeleted;
                                });
                                if (notificitionDeleted) {
                                  Get.put(MovementController()).getMovements();
                                  widget.onDeleted();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: Size.zero,
                          disabledBackgroundColor: Colors.red.shade800,
                          padding: EdgeInsets.symmetric(
                            vertical: 2.5.h,
                            horizontal: 15.w,
                          ),
                        ),
                        child: Text(
                          isDeclining ? "Canceling.." : "Decline",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: white,
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: isDeleting || isDeclining
                  ? null
                  : () async {
                      final wantDelete = await warnMethod(
                        context,
                        title: "Clear Notification",
                        subtitle:
                            "Are you sure do you clear this notification?",
                        okButtonText: "Clear",
                      );
                      if (wantDelete != true) return;
                      setState(() {
                        isDeleting = true;
                      });
                      final res = await widget.dbService.deleteNotification(
                        widget.notification.id,
                      );
                      setState(() {
                        isDeleting = false;
                      });
                      if (res) {
                        widget.onDeleted();
                      }
                    },
              child: CircleAvatar(
                radius: 15.sp,
                backgroundColor: primary,
                foregroundColor: white,
                child: isDeleting
                    ? LoadingAnimationWidget.hexagonDots(
                        color: white,
                        size: 17.sp,
                      )
                    : Icon(
                        Icons.close,
                        size: 22.sp,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
