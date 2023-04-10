import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickstep_app/controllers/movements_controller.dart';
import 'package:quickstep_app/models/movement.dart';
import 'package:quickstep_app/services/auth_service.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:quickstep_app/utils/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../widgets/app_bar_2.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  final moveController = Get.find<MovementController>();
  final auth = AuthService().getAuth();

  Movement? movement;

  init() {
    movement = moveController.movements.cast<Movement?>().firstWhere(
          (move) => moveController.currentMovementId.value == move?.id,
          orElse: () => null,
        );
  }

  @override
  void initState() {
    init();
    super.initState();
  }

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
                    if (movement != null)
                      Text(
                        movement!.members.toString(),
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
                              " Creator",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.amberAccent.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        addVerticalSpace(5),
                        if (movement != null)
                          ListTile(
                            leading: CircleAvatar(
                              radius: 24.r,
                              backgroundColor: lightPrimary,
                              foregroundColor: white,
                              child: Text(
                                movement!.creator[0].toUpperCase(),
                              ),
                            ),
                            title: Text(
                              auth?.fullName == movement!.creator
                                  ? "You"
                                  : movement!.creator,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              "Created this movement ${timeago.format(movement!.createdAt)}",
                              maxLines: 2,
                            ),
                          ),
                        addVerticalSpace(20),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 20.sp,
                              color: Colors.green.shade400,
                            ),
                            Text(
                              " Active",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.green.shade400,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        addVerticalSpace(20),
                        for (int i = 0;
                            i < moveController.currentMoveMembers.length;
                            i++)
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: ListTile(
                              onTap: () =>
                                  moveController.currentMovingUserId.value =
                                      moveController.currentMoveMembers[i].id,
                              leading: CircleAvatar(
                                radius: 27.r,
                                backgroundColor: lightPrimary,
                                child: CircleAvatar(
                                  radius: 22.r,
                                  backgroundColor: primary,
                                  foregroundColor: white,
                                  foregroundImage: NetworkImage(moveController
                                      .currentMoveMembers[i].imgUrl),
                                  child: Text(
                                    moveController
                                        .currentMoveMembers[i].username[0]
                                        .toUpperCase(),
                                  ),
                                ),
                              ),
                              title: Text(
                                auth?.userId ==
                                        moveController.currentMoveMembers[i].id
                                    ? "You"
                                    : moveController
                                        .currentMoveMembers[i].username,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Joined ${timeago.format(moveController.currentMoveMembers[i].joinedAt)}",
                                maxLines: 2,
                              ),
                              trailing: Obx(() {
                                return CircleAvatar(
                                  radius: 9.r,
                                  backgroundColor: moveController
                                              .currentMovingUserId.value ==
                                          moveController
                                              .currentMoveMembers[i].id
                                      ? Colors.green.shade400
                                      : lightPrimary,
                                );
                              }),
                            ),
                          ),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 20.sp,
                              color: Colors.redAccent.shade700,
                            ),
                            Text(
                              " Inactive",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.redAccent.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        addVerticalSpace(20),
                        // Padding(
                        //   padding: EdgeInsets.only(bottom: 10.h),
                        //   child: ListTile(
                        //     onTap: () {},
                        //     leading: CircleAvatar(
                        //       radius: 27.r,
                        //       backgroundColor: primary,
                        //       child: CircleAvatar(
                        //         radius: 24.r,
                        //         backgroundColor: primary,
                        //         foregroundColor: white,
                        //         foregroundImage: AssetImage(
                        //           "assets/images/${dummyUsers[0].imgUrl}",
                        //         ),
                        //         child: Text(
                        //           dummyUsers[0].username[0].toUpperCase(),
                        //         ),
                        //       ),
                        //     ),
                        //     title: Text(
                        //       dummyUsers[0].username,
                        //       style: TextStyle(
                        //         fontSize: 16.sp,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //     subtitle: Text(
                        //       dummyUsers[0].caption,
                        //       maxLines: 2,
                        //     ),
                        //   ),
                        // ),
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
