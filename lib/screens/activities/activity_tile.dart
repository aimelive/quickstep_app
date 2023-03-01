import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/activity.dart';
import '../../utils/colors.dart';
import '../../utils/helpers.dart';
import '../components/warn_method.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({
    Key? key,
    required this.activity,
    required this.onDelete,
  }) : super(key: key);
  final Activity activity;
  final Future<bool> Function(int id) onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(activity.id),
      background: Container(),
      secondaryBackground: Container(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        final delete = await warnMethod(context,
          title: "Move Activity to Trash",
          subtitle: "Are you sure do you want to delete this activity?",
          okButtonText: "Delete",
        );
        if (delete == true) {
          return await onDelete(activity.id);
        }
        return false;
      },
      child: Container(
        // width: double.infinity,
        margin: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 2.w,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 15.w,
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: lightPrimary.withOpacity(0.4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              toIcon[activity.type],
              size: 30.sp,
              color: lightPrimary.withOpacity(0.8),
            ),
            addHorizontalSpace(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timeago.format(activity.createdAt),
                    style: TextStyle(
                      color: lightPrimary,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 13.sp,
                    ),
                  ),
                  addVerticalSpace(4),
                  Text(
                    activity.text,
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
