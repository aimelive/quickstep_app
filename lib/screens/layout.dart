import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quickstep_app/models/bottom_nav_item.dart';
import 'package:quickstep_app/screens/activities/activities_page.dart';
import 'package:quickstep_app/screens/components/app_bar.dart';
import 'package:quickstep_app/screens/home/home_page.dart';
import 'package:quickstep_app/screens/movements/movements_page.dart';
import 'package:quickstep_app/screens/profile/profile_page.dart';
import 'package:quickstep_app/screens/widgets/slide_fade_switcher.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final pages = [
    const HomePage(),
    const ActivitiesPage(),
    const MovementsPage(),
    const ProfilePage(),
  ];
  int currentPage = 0;

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
            // leading: const AutoLeadingButton(
            //   color: white,
            // ),
            flexibleSpace: const MyAppBar(),
            toolbarHeight: 100,
          ),
          body: SlideFadeSwitcher(child: pages[currentPage]),
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
                        icon: Icon(
                          item.icon,
                          size: 30,
                        ),
                        title: Text(item.text),
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
