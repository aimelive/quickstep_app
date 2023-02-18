import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';

class AnimatedButton extends StatelessWidget {
  const AnimatedButton(
      {Key? key,
      required RiveAnimationController btnAnimationController,
      required this.onPressed})
      : _btnAnimationController = btnAnimationController,
        super(key: key);

  final RiveAnimationController _btnAnimationController;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 64,
        width: 260,
        child: Stack(
          children: [
            RiveAnimation.asset(
              "assets/rive/button.riv",
              controllers: [_btnAnimationController],
            ),
            Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(CupertinoIcons.arrow_right),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Start the journey",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
