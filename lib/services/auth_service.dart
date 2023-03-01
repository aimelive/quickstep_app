import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickstep_app/services/hive_service.dart';

import '../models/account.dart';

class AuthService {
  Box authBox = Hive.box(Boxes.authBox);

  Account? getAuth() {
    try {
      final data = authBox.keys.map((key) {
        final value = authBox.get(key);
        DateTime expiredAt = value["expiredAt"];
        if (!expiredAt.isAfter(DateTime.now())) {
          removeAuth();
          throw Exception("Token expired");
        }
        return Account.fromMap(value["account"]);
      }).toList();
      return data.reversed.toList().single;
    } catch (e) {
      return null;
    }
  }

  Future<bool> addAuth(String token, Account account) async {
    try {
      await authBox.add(
        {
          "authToken": token,
          "expiredAt": DateTime.now().add(const Duration(days: 5)),
          "account": Account.toMap(account),
        },
      );
      return true;
    } catch (e) {
      // print("Sign in failed: ");
      return false;
    }
  }

  Future<bool> removeAuth() async {
    try {
      await authBox.clear();
      return true;
    } catch (e) {
      return false;
    }
  }
}
