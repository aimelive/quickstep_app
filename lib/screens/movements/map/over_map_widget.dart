import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/screens/movements/map/data.dart';

import '../../../utils/colors.dart';
import '../../../utils/helpers.dart';
import '../../widgets/icon_shadow_button.dart';

class OverMapWidget extends StatefulWidget {
  const OverMapWidget({
    Key? key,
  }) : super(key: key);

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
                onPress: () => popPage(context),
                icon: Icons.arrow_back,
              ),
              IconShadowButton(
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
        if (showMenu)
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: lightPrimary.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              margin: EdgeInsets.only(right: 20.w),
              width: 200.w,
              child: Column(
                children: [
                  for (int i = 0; i < MapMenu.items.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showMenu = false;
                        });

                        pushPage(context, to: MapMenu.items[0].page);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 20.w),
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
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        Expanded(child: Container())
      ],
    );
  }
}
