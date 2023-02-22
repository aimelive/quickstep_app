import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'components/signin/signin_dialog.dart';
// ignore: unused_import
import 'components/signin/signin_form.dart';
import 'widgets/animated_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late RiveAnimationController _btnAnimationController;
  bool isSignDialogShow = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      // autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Footstep App',
                style: Theme.of(context).textTheme.headline4,
              ),
              AnimatedButton(
                btnAnimationController: _btnAnimationController,
                onPressed: () {
                  _btnAnimationController.isActive = true;
                  Future.delayed(
                      const Duration(
                        milliseconds: 800,
                      ), () {
                    setState(() {
                      isSignDialogShow = true;
                    });
                    customSignInDialog(context, isClosed: (_) {
                      setState(() {
                        isSignDialogShow = false;
                      });
                    });
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
