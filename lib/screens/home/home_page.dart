import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../components/choose_location_dialog_func.dart';
import 'components/self_made_walks_listview.dart';
import 'components/start_walk_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onExploreMore});
  final VoidCallback onExploreMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hey 👋,\nExplore what's new today?",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 160.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: ((context, index) {
                  return Container(
                    width: 115.w,
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 10.w,
                    ),
                    decoration: BoxDecoration(
                      color: lightPrimary,
                      image: const DecorationImage(
                        image: AssetImage("assets/images/map.jpeg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.linearToSrgbGamma(),
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: primary.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: const [
                              BoxShadow(
                                color: veryLightGrey,
                                blurRadius: 50,
                                offset: Offset(-2, -2),
                              )
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 1.5.h,
                          ),
                          child: Text(
                            "On going",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: white,
                            ),
                          ),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: primary,
                          foregroundColor: white,
                          child: Text(
                            "Q",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        const Text(
                          "Quality",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: white,
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 12.h),
            Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: onExploreMore,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Explore more"),
                ),
              ),
            ),
            addVerticalSpace(10),
            Text(
              "Self-made Walks",
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SelfMadeWalksWidget(),
            addVerticalSpace(10),
            const StartWalkingButton(),
          ],
        ),
      ),
    );
  }
}
