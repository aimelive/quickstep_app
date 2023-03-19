import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickstep_app/screens/profile/caches.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../../controllers/auth.dart';
import '../../models/account.dart';
import '../../services/auth_service.dart';
import '../movements/map/widgets/warn_dialog.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final auth = Get.put(AuthState());
  final _hiveDb = AuthService();

  @override
  Widget build(BuildContext context) {
    final Account profile = _hiveDb.getAuth()!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          ListTile(
            title: Text(
              profile.fullName,
              style: TextStyle(fontSize: 14.sp),
            ),
            subtitle: Text(
              "Member since ${months[profile.createdAt.month - 1]} ${profile.createdAt.day}, ${profile.createdAt.year}",
              style: TextStyle(fontSize: 12.sp),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(
                  width: 3.r,
                  color: lightPrimary,
                ),
              ),
              child: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 24.r,
                  foregroundImage: NetworkImage(
                    profile.profilePic,
                    // "https://cdn.pixabay.com/photo/2023/02/18/16/02/bicycle-7798227_1280.jpg",
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "personal info".toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.mail_outline_outlined,
                    size: 25.sp,
                  ),
                  title: Text(
                    "Email",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  subtitle: Text(
                    profile.email,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Text(
                  "general".toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // ListTile(
                //   leading: Icon(Icons.run_circle_outlined, size: 25.sp),
                //   title: Text(
                //     "Inactive",
                //     style: TextStyle(fontSize: 14.sp),
                //   ),
                //   subtitle: Text(
                //     "Set your self as away",
                //     style: TextStyle(fontSize: 12.sp),
                //   ),
                //   onTap: () {},
                // ),
                ListTile(
                  leading: Icon(
                    Icons.cached,
                    size: 25.sp,
                  ),
                  title: Text(
                    "Clear caches",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  subtitle: Text(
                    "Cleaning caches from your device",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  onTap: () => pushPage(
                    context,
                    to: const ClearCaches(),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 24.sp,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.logout, size: 25.sp),
                  title: Text(
                    "Logout",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  subtitle: Text(
                    "Signed in as ${profile.username}",
                    style: TextStyle(fontSize: 12.sp),
                  ),
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
                    if (logout != true) return;
                    final res = await _hiveDb.removeAuth();
                    if (res != true) return;
                    auth.isSignedIn.value = false;
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Transform.scale(
            scale: .7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  color: primary,
                  size: 60.sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Step",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    addVerticalSpace(5),
                    Text(
                      "Live location tracking made easy",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 14.sp,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          addVerticalSpace(25)
        ],
      ),
    );
  }
}
