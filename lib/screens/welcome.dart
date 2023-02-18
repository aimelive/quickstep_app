import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'components/signin_form.dart';
import 'widgets/animated_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        child: AnimatedPositioned(
          top: isSignDialogShow ? -50 : 0,
          duration: Duration(milliseconds: 240),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
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
        ),
      ),
    );
  }

  Future<Object?> customSignInDialog(BuildContext context,
      {required ValueChanged isClosed}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Sign in",
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: ((context, animation, secondaryAnimation, child) {
        Tween<Offset> tween;
        tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      }),
      pageBuilder: ((context, animation, secondaryAnimation) {
        return Center(
          child: Container(
            height: 620,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.94),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(fontSize: 34),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text("Get access to your account",
                            textAlign: TextAlign.center, style: TextStyle()),
                      ),
                      const SignInForm(),
                      Row(
                        children: const [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "OR",
                              style: TextStyle(
                                color: Colors.black26,
                              ),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Sign up with Email, Apple or Google",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      // Row(children: [
                      //   IconButton(onPressed: (){}, icon: icon)
                      // ],)
                    ],
                  ),
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: -48,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    ).then(isClosed);
  }
}
