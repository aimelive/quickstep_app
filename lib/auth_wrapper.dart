import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickstep_app/services/auth_service.dart';

import 'controllers/auth.dart';
import 'screens/authentication/welcome.dart';
import 'screens/layout.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final auth = Get.put(AuthState());

  final _hiveDb = AuthService();

  _init() {
    final account = _hiveDb.getAuth();
    if (account != null) {
      auth.isSignedIn.value = true;
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => auth.isSignedIn.value ? const LayoutPage() : const WelcomeScreen(),
    );
  }
}
