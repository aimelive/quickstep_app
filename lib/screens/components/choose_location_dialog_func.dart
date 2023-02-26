import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'choose_location_dialog.dart';

Future<Map<String, LatLng>?> chooseLocationDialog(BuildContext context) {
  return showGeneralDialog<Map<String, LatLng>>(
    barrierLabel: "choose-location",
    context: context,
    barrierColor: Colors.black26,
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: ((context, animation, secondaryAnimation, child) {
      final tween = Tween(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      );
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      );
    }),
    pageBuilder: ((context, _, __) {
      return const ChooseLocationDialog();
    }),
  );
}
