import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/models/user.dart';
import 'package:quickstep_app/utils/colors.dart';

import '../../../utils/helpers.dart';

class InviteMembers extends StatefulWidget {
  const InviteMembers({
    Key? key,
    required this.onContinue,
  }) : super(key: key);
  final VoidCallback onContinue;

  @override
  State<InviteMembers> createState() => _InviteMembersState();
}

class _InviteMembersState extends State<InviteMembers> {
  List<User> selected = [];
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
                Column(
                  children: [
                    for (int i = 0; i < dummyUsers.length; i++)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: ListTile(
                          onTap: () {
                            if (selected.contains(dummyUsers[i])) {
                              selected.remove(dummyUsers[i]);
                            } else {
                              selected.add(dummyUsers[i]);
                            }

                            setState(() {});
                          },
                          selected: selected.contains(dummyUsers[i]),
                          selectedTileColor: Colors.grey.shade200,
                          selectedColor: primary,
                          leading: CircleAvatar(
                            radius: 30.r,
                            backgroundColor: primary,
                            child: Padding(
                              padding: EdgeInsets.all(1.5.r),
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
                          trailing: CircleAvatar(
                            backgroundColor: lightPrimary,
                            foregroundColor: white,
                            radius: 12.r,
                            child: selected.contains(dummyUsers[i])
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
                      onPressed: () {
                        widget.onContinue();
                      },
                      icon: Icon(
                        Icons.share,
                        size: 24.sp,
                      ),
                      label: Text(
                        "  INVITE  ",
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
