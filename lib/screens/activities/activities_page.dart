import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/models/activity.dart';
import 'package:quickstep_app/services/hive_service.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../movements/map/widgets/warn_dialog.dart';
import 'activity_tile.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final _hiveDb = HiveService();
  late List<Activity> activities;

  _init() {
    setState(() {
      activities = _hiveDb.getAllActivities();
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return activities.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_amber,
                  size: 30.sp,
                  color: lightPrimary,
                ),
                const Text(
                  "No activities detected yet!",
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Activities".toUpperCase(),
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: primary),
                    ),
                    if (activities.length > 20)
                      GestureDetector(
                        onTap: () async {
                          final delete = await showDialog<bool>(
                            context: context,
                            barrierColor: Colors.black26,
                            builder: ((context) {
                              return const WarnDialogWidget(
                                title: "Move All Activities to Trash",
                                subtitle:
                                    "Are you sure do you want to delete all activities history?",
                                okButtonText: "Delete All",
                              );
                            }),
                          );
                          if (delete == true) {
                            await _hiveDb.deleteAllActivity();
                            _init();
                          }
                        },
                        child: Icon(
                          Icons.delete_outline,
                          size: 24.sp,
                          color: primary,
                        ),
                      ),
                  ],
                ),
                addVerticalSpace(5),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: activities
                          .map(
                            (activity) => ActivityTile(
                              activity: activity,
                              onDelete: (id) async {
                                final res = await _hiveDb.deleteActivity(id);
                                if (!res) return false;
                                _init();
                                return true;
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
