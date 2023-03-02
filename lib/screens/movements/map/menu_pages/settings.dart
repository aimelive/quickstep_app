import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../../widgets/app_bar_2.dart';
import 'widgets/setting_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          // backgroundColor: Colors.grey.shade800,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: primary,
            elevation: 0.0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            flexibleSpace: Hero(
              tag: "appbar-hero-custom-1",
              child: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: const AnotherCustomAppBar(
                  title: "Settings",
                ),
              ),
            ),
            toolbarHeight: 100.h,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "General".toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.5.sp,
                    color: primary.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                addVerticalSpace(15),
                Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: lightPrimary.withOpacity(0.8),
                        blurRadius: 12.r,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SettingTile(
                        icon: Icons.group_off_outlined,
                        onSwitchChanged: (value) {},
                        text: "Restrict new joiners",
                        active: true,
                        subText:
                            "Allow only your friends to discover profile when using Near Me in your location. ",
                      ),
                      SettingTile(
                        icon: Icons.directions_outlined,
                        onSwitchChanged: (value) {},
                        text: "Routes & directions",
                        active: true,
                        subText:
                            "Showing current roads members are passing through if they turned on",
                      ),
                      SettingTile(
                        icon: Icons.location_on_outlined,
                        onSwitchChanged: (value) {},
                        text: "Custom marker",
                        active: true,
                        subText:
                            "Set custom markers to actors currently moving",
                      ),
                      SettingTile(
                        icon: Icons.calendar_month,
                        onSwitchChanged: (value) {},
                        text: "End time",
                        active: true,
                        subText:
                            "Set custom markers to actors currently moving",
                      ),
                      SettingTile(
                        icon: Icons.location_off_outlined,
                        onSwitchChanged: (value) {},
                        text: "Active",
                        active: true,
                        subText:
                            "Disable other users to view your current location",
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(15),
                Text(
                  "Messaging".toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.5.sp,
                    color: primary.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                addVerticalSpace(15),
                Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: lightPrimary.withOpacity(0.8),
                        blurRadius: 12.r,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SettingTile(
                        icon: Icons.tv_off_rounded,
                        onSwitchChanged: (value) {},
                        text: "Turn off messages",
                        active: true,
                        subText:
                            "Allow only your friends to discover profile when using Near Me in your location. ",
                      ),
                      SettingTile(
                        icon: Icons.group,
                        onSwitchChanged: (value) {},
                        text: "Who can send messages",
                        active: true,
                        subText:
                            "Set custom markers to actors currently moving",
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
