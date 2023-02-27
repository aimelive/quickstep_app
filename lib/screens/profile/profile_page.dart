import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../../controllers/auth.dart';
import '../movements/map/widgets/warn_dialog.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final auth = Get.put(AuthState());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          ListTile(
            title: const Text("Aime Ndayambaje"),
            subtitle: const Text("Member since 12 Feb, 2022"),
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                border: Border.all(
                  width: 3,
                  color: lightPrimary,
                ),
              ),
              child: GestureDetector(
                onTap: () {},
                child: const CircleAvatar(
                  radius: 25,
                  foregroundImage: AssetImage("assets/images/aime.png"),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.run_circle_outlined),
                  title: const Text("Inactive"),
                  subtitle: const Text("Set your self as away"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  subtitle: const Text("Signed in as Aimelive"),
                  onTap: () async {
                    final logout = await showDialog<bool>(
                      context: context,
                      barrierColor: Colors.black26,
                      builder: ((context) {
                        return const WarnDialogWidget(
                          title: "Sign Out?",
                          subtitle:
                              "Are you sure do you want to log out this application?",
                          okButtonText: "Log Out",
                        );
                      }),
                    );
                    if (logout == true) {
                      auth.isSignedIn.value = false;
                    }
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.map,
                color: primary,
                size: 60,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Step",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  addVerticalSpace(5),
                  Text(
                    "Live location tracking made easy",
                    style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                  )
                ],
              ),
            ],
          ),
          addVerticalSpace(50)
        ],
      ),
    );
  }
}
