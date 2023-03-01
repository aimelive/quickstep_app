import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/models/self_made_walk.dart';
import 'package:quickstep_app/screens/components/warn_method.dart';
import 'package:quickstep_app/services/hive_service.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../../models/activity.dart';
import '../../utils/colors.dart';
import '../movements/widgets/app_bar_2.dart';

class ClearCaches extends StatefulWidget {
  const ClearCaches({super.key});

  @override
  State<ClearCaches> createState() => _ClearCachesState();
}

class _ClearCachesState extends State<ClearCaches> {
  final _hiveDb = HiveService();

  late List<Activity> activities;
  late List<SelfMadeWalk> selfMadeWalk;

  late List<CacheItem> lens;

  _init() {
    activities = _hiveDb.getCachedActivities();
    selfMadeWalk = _hiveDb.getCachedWalks();
    lens = [
      CacheItem(
        count: activities.length,
        icon: Icons.local_activity_outlined,
        text: "Activities",
      ),
      CacheItem(
        count: selfMadeWalk.length,
        icon: Icons.explore_outlined,
        text: "Self Travels",
      ),
    ];
    setState(() {});
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
        bottom: false,
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
                child: const AnotherCustomAppBar(
                  title: "Clear Caches",
                ),
              ),
            ),
            toolbarHeight: 100.h,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.amberAccent.shade700,
                      ),
                      color: Colors.amberAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          color: Colors.amberAccent.shade700,
                          size: 30.sp,
                        ),
                        addHorizontalSpace(10),
                        Expanded(
                          child: Text(
                            "Clearing caches deletes all activities and self-made walks travels not associated with the current authenticated account",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(40),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 650 ? 4 : 3,
                      mainAxisSpacing: 18.h,
                      crossAxisSpacing: 17.w,
                    ),
                    shrinkWrap: true,
                    itemCount: lens.length,
                    itemBuilder: (context, index) {
                      return CacheCategory(item: lens[index]);
                    },
                  ),
                  if (activities.isNotEmpty && selfMadeWalk.isNotEmpty)
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final clear = await warnMethod(
                            context,
                            title: "Clear All Caches",
                            subtitle:
                                "We detected some users logged in on this device and created some activities and self-made travels, once you clear caches they will no longer see them when they're back. Click Clear All to confirm",
                            okButtonText: "Clear All",
                          );
                          if (clear == true) {
                            List<int> activityKeys =
                                activities.map((a) => a.id).toList();
                            List<int> walksKeys =
                                selfMadeWalk.map((w) => w.id).toList();
                            final resA = await _hiveDb
                                .deleteCachedActivities(activityKeys);
                            final resW =
                                await _hiveDb.deleteCachedWalks(walksKeys);
                            if (resA && resW) {
                              _init();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.shade700,
                          minimumSize: Size.zero,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 5.h,
                          ),
                          shape: const StadiumBorder(),
                        ),
                        icon: Icon(
                          Icons.delete_outline,
                          size: 22.sp,
                        ),
                        label: Text(
                          "Clear caches",
                          style: TextStyle(fontSize: 13.sp),
                        ),
                      ),
                    ),
                  if (activities.isEmpty && selfMadeWalk.isEmpty)
                    Center(
                      child: Text(
                        "No caches detected!",
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CacheItem {
  int count;
  IconData icon;
  String text;
  CacheItem({
    required this.count,
    required this.icon,
    required this.text,
  });
}

class CacheCategory extends StatelessWidget {
  const CacheCategory({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CacheItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.r),
      decoration: BoxDecoration(
        color: lightPrimary.withOpacity(0.1),
        border: Border.all(
          width: 1,
          color: lightPrimary,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            item.icon,
            size: 22.sp,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Text(
              item.count.toString(),
              style: TextStyle(
                fontSize: 14.sp,
                color: primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            item.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }
}
