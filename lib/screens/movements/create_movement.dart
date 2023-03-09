import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/screens/movements/components/invite_members.dart';
import 'package:quickstep_app/screens/movements/widgets/app_bar_2.dart';
import 'package:quickstep_app/screens/widgets/slide_fade_switcher.dart';

import '../../utils/colors.dart';
import 'components/create_movement.dart';

class CreateMovementPage extends StatefulWidget {
  const CreateMovementPage({
    super.key,
  });

  @override
  State<CreateMovementPage> createState() => _CreateMovementPageState();
}

class _CreateMovementPageState extends State<CreateMovementPage> {
  bool create = true;

  String title = "";
  String description = "";

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
                  title: "Movement",
                ),
              ),
            ),
            toolbarHeight: 100.h,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            // physics: NeverScrollableScrollPhysics(),
            child: SlideFadeSwitcher(
              child: create
                  ? CreateMovement(
                      onContinue: (name, desc) {
                        setState(() {
                          title = name;
                          description = desc;
                          create = false;
                        });
                      },
                    )
                  : InviteMembers(
                      title: title,
                      description: description,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
