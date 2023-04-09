import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickstep_app/controllers/movements_controller.dart';
import 'package:quickstep_app/models/user.dart';
import 'package:quickstep_app/screens/components/top_snackbar.dart';
import 'package:quickstep_app/services/db_service.dart';
import 'package:quickstep_app/utils/colors.dart';

import '../../../services/auth_service.dart';
import '../../../utils/helpers.dart';

class InviteMembers extends StatefulWidget {
  const InviteMembers({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title, description;

  @override
  State<InviteMembers> createState() => _InviteMembersState();
}

class _InviteMembersState extends State<InviteMembers> {
  List<User> selected = [];
  final _moveCnt = Get.find<MovementController>();
  final dbService = DBService();
  final profile = AuthService().getAuth();

  late bool isLoading;
  List<User> users = [];

  bool isCreating = false;

  void _init() async {
    isLoading = true;
    final profiles = await dbService.getUsers();
    if (profiles == null) return;
    for (var profile in profiles) {
      users.add(
        User(
          id: profile.userId,
          imgUrl: profile.imgUrl,
          username: profile.username,
          joinedAt: profile.email,
        ),
      );
    }
    isLoading = false;
    if (!mounted) return;
    setState(() {});
  }

  void _createMovement() async {
    setState(() {
      isCreating = true;
    });
    final movement = await dbService.createMovement(
      title: widget.title,
      description: "This movement created as ${widget.description}",
      actors: selected.map<String>((user) => user.id).toList(),
      creatorName: profile!.fullName,
    );
    if (!mounted) return;
    setState(() {
      isCreating = false;
    });
    if (movement == null) return;
    showMessage(
      message: "You created movement ${movement.title}",
      title: "Movement created successfully",
      type: MessageType.success,
    );

    _moveCnt.addMovement(movement);

    if (!mounted) return;
    popPage(context);
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Invite",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade900,
              ),
            ),
            addHorizontalSpace(5),
            Icon(
              Icons.share,
              color: Colors.grey.shade600,
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(20),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "select members".toUpperCase(),
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: primary.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      selected.length.toString(),
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
                addVerticalSpace(18),
                if (users.isEmpty)
                  Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Column(
                      children: [
                        Icon(
                          Icons.hide_source,
                          size: 40.sp,
                          color: Colors.red.shade300,
                        ),
                        addVerticalSpace(20),
                        Text(
                          "We're sorry, there is no any member in our system you can invite to your movement",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                Column(
                  children: [
                    for (int i = 0; i < users.length; i++)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: ListTile(
                          onTap: () {
                            if (selected.contains(users[i])) {
                              selected.remove(users[i]);
                            } else {
                              selected.add(users[i]);
                            }

                            setState(() {});
                          },
                          selected: selected.contains(users[i]),
                          selectedTileColor: Colors.grey.shade200,
                          selectedColor: primary,
                          leading: CircleAvatar(
                            radius: 27.r,
                            backgroundColor: primary,
                            child: CircleAvatar(
                              radius: 24.r,
                              backgroundColor: primary,
                              foregroundColor: white,
                              foregroundImage: NetworkImage(users[i].imgUrl),
                              child: Text(
                                users[i].username[0].toUpperCase(),
                              ),
                            ),
                          ),
                          title: Text(
                            users[i].username,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            users[i].joinedAt,
                            maxLines: 2,
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: lightPrimary,
                            foregroundColor: white,
                            radius: 12.r,
                            child: selected.contains(users[i])
                                ? Icon(
                                    Icons.check,
                                    size: 16.sp,
                                  )
                                : null,
                          ),
                        ),
                      ),
                  ],
                ),
                addVerticalSpace(20),
                Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: isCreating
                          ? null
                          : () {
                              if (selected.isEmpty) {
                                showMessage(
                                  message:
                                      "Please select a member to start a movement",
                                  title: "No member selected",
                                  type: MessageType.error,
                                );
                                return;
                              }
                              _createMovement();
                            },
                      icon: isCreating
                          ? LoadingAnimationWidget.inkDrop(
                              color: white, size: 18.sp)
                          : Icon(
                              Icons.share,
                              size: 24.sp,
                            ),
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: lightPrimary,
                        disabledForegroundColor: white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 7.h,
                        ),
                      ),
                      label: Text(
                        isCreating ? "  LOADING  " : "  INVITE  ",
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
