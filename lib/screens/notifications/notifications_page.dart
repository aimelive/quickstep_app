import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../widgets/icon_shadow_button.dart';
import 'widgets/notification_tile.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;

  @override
  void initState() {
    animation = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 350,
      ),
      // upperBound: 0.0,
      // lowerBound: 1.0,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animation.dispose();
  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconShadowButton(
                onPress: () => popPage(context),
                icon: Icons.arrow_back,
              ),
              IconShadowButton(
                onPress: () {
                  if (animation.isCompleted) {
                    animation.reverse();
                  } else {
                    animation.forward();
                  }
                },
                icon: animation.value > 0 ? Icons.menu : Icons.close,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(10),
                  Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  addVerticalSpace(10),
                  const SectionTitle("Today"),
                  for (int i = 0; i < 2; i++) const NotificationTile(),
                  const SectionTitle("Yesterday"),
                  for (int i = 0; i < 2; i++) const NotificationTile(),
                  const SectionTitle("This week"),
                  for (int i = 0; i < 2; i++) const NotificationTile(),
                  const SectionTitle("This month"),
                  for (int i = 0; i < 2; i++) const NotificationTile(),
                ],
              ),
            ),
          ),
          Positioned(
            // top: -240.w * animation.value,
            right: -240.w * animation.value,
            child: Container(
              // height: 200,
              margin: EdgeInsets.only(right: 20.w),
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
              width: 220.w,
              child: Column(
                children: [
                  addVerticalSpace(5),
                  for (int i = 0; i < MenuItem.items.length; i++)
                    Material(
                      color: white,
                      child: ListTile(
                        leading: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Icon(
                            MenuItem.items[i].icon,
                            size: 24.sp,
                          ),
                        ),
                        onTap: () {
                          // animation.forward();
                        },
                        iconColor: primary.withOpacity(1 - animation.value),
                        textColor: primary.withOpacity(1 - animation.value),
                        // contentPadding: EdgeInsets.symmetric(vertical: 2.h),
                        title: Text(
                          MenuItem.items[i].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  addVerticalSpace(5),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MenuItem {
  IconData icon;
  String title;
  VoidCallback onClick;

  MenuItem({
    required this.icon,
    required this.title,
    required this.onClick,
  });
  static List<MenuItem> items = [
    MenuItem(
      icon: Icons.visibility_outlined,
      title: "Mark all as read",
      onClick: () {},
    ),
    MenuItem(
      icon: Icons.visibility_off_outlined,
      title: "Mark all as unread",
      onClick: () {},
    ),
    MenuItem(
      icon: Icons.notifications_off,
      title: "Turn off",
      onClick: () {},
    ),
    MenuItem(
      icon: Icons.delete,
      title: "Clear All",
      onClick: () {},
    ),
  ];
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: primary.withOpacity(0.9),
        fontSize: 14.5.sp,
      ),
    );
  }
}
