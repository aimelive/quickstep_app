import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
