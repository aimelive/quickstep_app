import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/models/account.dart';
import 'package:quickstep_app/models/bottom_nav_item.dart';
import 'package:quickstep_app/screens/activities/activities_page.dart';
import 'package:quickstep_app/screens/components/app_bar.dart';
import 'package:quickstep_app/screens/home/home_page.dart';
import 'package:quickstep_app/screens/movements/movements_page.dart';
import 'package:quickstep_app/screens/profile/profile_page.dart';
import 'package:quickstep_app/screens/widgets/slide_fade_switcher.dart';
import 'package:quickstep_app/services/auth_service.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  late List<Widget> pages;
  int currentPage = 0;
  late Account profile;

  _onExplore() {
    if (currentPage == 2) return;
    setState(() {
      currentPage = 2;
    });
  }

  _init() {
    pages = [
      HomePage(
        onExploreMore: _onExplore,
      ),
      const ActivitiesPage(),
      const MovementsPage(),
      ProfilePage(),
    ];
    final hive = AuthService();
    profile = hive.getAuth()!;
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary,
      child: SafeArea(
        top: true,
        bottom: false,
        right: false,
        left: false,
        child: Scaffold(
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
                child: MyAppBar(gotoExplore: _onExplore),
              ),
            ),
            toolbarHeight: 100.h,
          ),
          body: SlideFadeSwitcher(
            child: pages[currentPage],
          ),
          bottomNavigationBar: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: primary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: Platform.isAndroid ? 5 : 0,
              ),
              child: SalomonBottomBar(
                currentIndex: currentPage,
                onTap: ((p0) {
                  setState(() {
                    currentPage = p0;
                  });
                  return p0;
                }),
                items: menuItems
                    .map(
                      (item) => SalomonBottomBarItem(
                        selectedColor: Colors.blue.shade200,
                        unselectedColor: veryLightGrey,
                        icon: item.index == 3
                            ? Transform.scale(
                                scale: 1.3,
                                child: CircleAvatar(
                                  backgroundColor: lightPrimary,
                                  radius: 14.r,
                                  foregroundImage: NetworkImage(
                                    profile.profilePic,

                                    // "https://cdn.pixabay.com/photo/2023/02/18/16/02/bicycle-7798227_1280.jpg",
                                  ),
                                  // child: Image.network(
                                  //   profile.profilePic,
                                  // ),
                                ),
                              )
                            : Icon(
                                item.icon,
                                size: 25.sp,
                              ),
                        title: Text(item.index == 3
                            ? cfl(
                                profile.username.length > 8
                                    ? "${profile.username.substring(0, 6)}..."
                                    : profile.username,
                              )
                            : item.text),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
