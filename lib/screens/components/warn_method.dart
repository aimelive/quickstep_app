import 'package:flutter/material.dart';

import '../movements/map/widgets/warn_dialog.dart';

Future<bool?> warnMethod(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String okButtonText,
}) {
  return showDialog<bool>(
    context: context,
    barrierColor: Colors.black26,
    builder: ((context) {
      return WarnDialogWidget(
        title: title,
        subtitle: subtitle,
        okButtonText: okButtonText,
      );
    }),
  );
}
