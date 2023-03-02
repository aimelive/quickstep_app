import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../../../../models/user.dart';
import '../../widgets/app_bar_2.dart';

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

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
                  title: "Members",
                ),
              ),
            ),
            toolbarHeight: 100.h,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "members".toUpperCase(),
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: primary.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      123.toString(),
                      style: TextStyle(
                        fontSize: 15.sp,
                        // color: primary.withOpacity(1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    addHorizontalSpace(10),
                    const Icon(Icons.group)
                  ],
                ),
                addVerticalSpace(10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 20.sp,
                              color: Colors.amberAccent,
                            ),
                            Text(
                              " Active",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.amberAccent.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        addVerticalSpace(20),
                        for (int i = 0; i < dummyUsers.length; i++)
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: ListTile(
                              onTap: () {},
                              leading: CircleAvatar(
                                radius: 27.r,
                                backgroundColor: primary,
                                child: CircleAvatar(
                                  radius: 24.r,
                                  backgroundColor: primary,
                                  foregroundColor: white,
                                  foregroundImage: AssetImage(
                                    "assets/images/${dummyUsers[i].imgUrl}",
                                  ),
                                  child: Text(
                                    dummyUsers[i].username[0].toUpperCase(),
                                  ),
                                ),
                              ),
                              title: Text(
                                dummyUsers[i].username,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                dummyUsers[i].caption,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 20.sp,
                              color: Colors.amberAccent,
                            ),
                            Text(
                              " Watchers",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.amberAccent.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        addVerticalSpace(20),
                        for (int i = 0; i < dummyUsers.length - 2; i++)
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: ListTile(
                              onTap: () {},
                              leading: CircleAvatar(
                                radius: 27.r,
                                backgroundColor: primary,
                                child: CircleAvatar(
                                  radius: 24.r,
                                  backgroundColor: primary,
                                  foregroundColor: white,
                                  foregroundImage: AssetImage(
                                    "assets/images/${dummyUsers[i].imgUrl}",
                                  ),
                                  child: Text(
                                    dummyUsers[i].username[0].toUpperCase(),
                                  ),
                                ),
                              ),
                              title: Text(
                                dummyUsers[i].username,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                dummyUsers[i].caption,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 20.sp,
                              color: Colors.amberAccent,
                            ),
                            Text(
                              " Admin",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.amberAccent.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        addVerticalSpace(20),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: ListTile(
                            onTap: () {},
                            leading: CircleAvatar(
                              radius: 27.r,
                              backgroundColor: primary,
                              child: CircleAvatar(
                                radius: 24.r,
                                backgroundColor: primary,
                                foregroundColor: white,
                                foregroundImage: AssetImage(
                                  "assets/images/${dummyUsers[0].imgUrl}",
                                ),
                                child: Text(
                                  dummyUsers[0].username[0].toUpperCase(),
                                ),
                              ),
                            ),
                            title: Text(
                              dummyUsers[0].username,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              dummyUsers[0].caption,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
