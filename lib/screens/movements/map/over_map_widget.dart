import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/controllers/movements_controller.dart';
import 'package:quickstep_app/screens/movements/map/data.dart';
import 'package:quickstep_app/screens/movements/map/menu_pages/messages.dart';
import 'package:quickstep_app/screens/widgets/slide_fade_switcher.dart';

import '../../../utils/colors.dart';
import '../../../utils/helpers.dart';
import '../../widgets/icon_shadow_button.dart';
import 'widgets/warn_dialog.dart';

class OverMapWidget extends StatefulWidget {
  const OverMapWidget(
      {Key? key,
      required this.membersLength,
      required this.cnt,
      required this.onSendMessage})
      : super(key: key);
  final int membersLength;
  final MovementController cnt;
  final void Function(String message) onSendMessage;

  @override
  State<OverMapWidget> createState() => _OverMapWidgetState();
}

class _OverMapWidgetState extends State<OverMapWidget> {
  bool showMenu = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconShadowButton(
                removeShadow: true,
                onPress: () async {
                  final leave = await showDialog<bool>(
                    context: context,
                    builder: ((context) {
                      return const WarnDialogWidget(
                        title: "Leave movement",
                        subtitle:
                            "Are you sure do you want to leave this movement?",
                        okButtonText: "Leave",
                      );
                    }),
                  );
                  if (leave == true) {
                    if (!mounted) return;
                    popPage(context);
                  }
                },
                icon: Icons.arrow_back,
              ),
              IconShadowButton(
                removeShadow: true,
                onPress: () {
                  setState(() {
                    showMenu = !showMenu;
                  });
                },
                icon: showMenu ? Icons.close : Icons.menu,
              ),
            ],
          ),
        ),
        SlideFadeSwitcher(
          duration: const Duration(milliseconds: 250),
          child: !showMenu
              ? Container()
              : Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: lightPrimary.withOpacity(0.7),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(right: 20.w),
                    width: 210.w,
                    child: Column(
                      children: [
                        for (int i = 0; i < MapMenu.items.length; i++)
                          Material(
                            color: white,
                            borderRadius: BorderRadius.circular(8.r),
                            child: InkWell(
                              onTap: () async {
                                final data = await pushPage(
                                  context,
                                  to: MapMenu.items[i].id == 1
                                      ? MessagesPage(
                                          onSendMessage: widget.onSendMessage,
                                        )
                                      : MapMenu.items[i].page,
                                );
                                if (data == "LEAVE" && mounted) {
                                  popPage(context);
                                } else {
                                  setState(() {
                                    showMenu = false;
                                  });
                                }
                              },
                              child: Ink(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15.h,
                                  horizontal: 20.w,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      MapMenu.items[i].icon,
                                      color: primary,
                                      size: 25.sp,
                                    ),
                                    addHorizontalSpace(20),
                                    Text(
                                      MapMenu.items[i].text,
                                      style: TextStyle(
                                        color: primary,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                    if (MapMenu.items[i].text != "Settings")
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primary,
                                          borderRadius:
                                              BorderRadius.circular(25.r),
                                        ),
                                        child: Text(
                                          MapMenu.items[i].text == "Members"
                                              ? "${widget.membersLength}+"
                                              : "${widget.cnt.chatMessages.length}+",
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
        ),
        Expanded(child: Container())
      ],
    );
  }
}
