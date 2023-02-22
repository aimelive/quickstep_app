import 'package:flutter/material.dart';
import 'package:quickstep_app/utils/helpers.dart';

import 'widgets/icon_shadow_button.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconShadowButton(
                  onPress: () => popPage(context),
                  icon: Icons.arrow_back,
                ),
                IconShadowButton(
                  onPress: () {},
                  icon: Icons.menu,
                ),
              ],
            ),
          ),
          const Center(
            child: Text(
              "We've got to list all notifications here.",
            ),
          ),
          Row(
            children: const [
              Text("You've recieved a notification"),
            ],
          )
        ],
      ),
    );
  }
}
