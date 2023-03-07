import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

enum MessageType { normal, success, error }

SnackbarController showMessage({
  required String message,
  required String title,
  MessageType type = MessageType.normal,
}) {
  return Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 4),
    backgroundColor: type == MessageType.normal
        ? primary
        : type == MessageType.error
            ? Colors.pink.shade900
            : Colors.green.shade400,
    colorText: white,
  );
}
