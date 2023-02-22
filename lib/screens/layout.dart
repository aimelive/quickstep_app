import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quickstep_app/models/bottom_nav_item.dart';
import 'package:quickstep_app/routes/router.gr.dart';
import 'package:quickstep_app/screens/components/app_bar.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary,
      child: SafeArea(
        top: true,
        bottom: false,
        right: false,
        left: false,
        child: AutoTabsScaffold(
          // extendBody: true,
          appBarBuilder: (_, tabsRouter) {
            return AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: primary,
              elevation: 0.0,
              centerTitle: true,
              leading: const AutoLeadingButton(
                color: white,
              ),
              flexibleSpace: const MyAppBar(),
              toolbarHeight: 100,
            );
          },
          routes: const [
            HomeRouter(),
            ActivitiesRouter(),
            GroupsRouter(),
            LivesRouter(),
            ProfileRouter()
          ],
          bottomNavigationBuilder: (_, tabsRouter) {
            return SafeArea(
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
                  currentIndex: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
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
            );
          },
        ),
      ),
    );
  }
}
