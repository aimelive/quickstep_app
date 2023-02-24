import 'package:flutter/material.dart';

class SlideFadeSwitcher extends StatelessWidget {
  final Widget child;
  const SlideFadeSwitcher({
    super.key,
    required this.child,
    this.duration,
  });

  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: ((child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(animation);

        final fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.5, 1.0),
          ),
        );
        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: offsetAnimation,
            child: child,
          ),
        );
      }),
      duration: duration ?? const Duration(milliseconds: 700),
      child: child,
    );
  }
}
