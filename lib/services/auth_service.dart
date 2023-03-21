import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickstep_app/screens/components/top_snackbar.dart';
import 'package:quickstep_app/services/hive_service.dart';
import 'package:quickstep_app/utils/keys.dart';

import '../models/account.dart';

class AuthService {
  Box authBox = Hive.box(Boxes.authBox);
  final dio = Dio();

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

  String? getAuthToken() {
    try {
      final data = authBox.keys.map((key) {
        final value = authBox.get(key);
        DateTime expiredAt = value["expiredAt"];
        if (!expiredAt.isAfter(DateTime.now())) {
          removeAuth();
          throw Exception("Token expired");
        }
        return value["authToken"];
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

  Future<dynamic> createAccount(
    String fullName,
    String email,
    String pwd,
  ) async {
    try {
      final uri = "$backendApiUrl/accounts/create";
      final result = await dio.post(uri, data: {
        "fullName": fullName,
        "email": email,
        "password": pwd,
      });
      return result.data;
    } on DioError catch (e) {
      onDioError(e);
    } catch (e) {
      onUnkownError(e);
    }
  }

  //Login to account
  Future<dynamic> login(
    String email,
    String pwd,
  ) async {
    try {
      final uri = "$backendApiUrl/accounts/login";
      final result = await dio.post(uri, data: {
        "email": email,
        "password": pwd,
      });
      return result.data;
    } on DioError catch (e) {
      onDioError(e);
    } catch (e) {
      onUnkownError(e);
    }
  }

  //Getting user profile informations
  Future<dynamic> getProfile(String token) async {
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      final result = await dio.get(
        "$backendApiUrl/profile",
      );
      return result.data;
    } on DioError catch (e) {
      onDioError(e);
    } catch (e) {
      onUnkownError(e);
    }
  }

  Future<dynamic> resendOTP(
    String email,
  ) async {
    try {
      final uri = "$backendApiUrl/accounts/resend-otp";
      final result = await dio.post(uri, data: {
        "email": email,
      });
      return result.data;
    } on DioError catch (e) {
      onDioError(e);
    } catch (e) {
      onUnkownError(e);
    }
  }

  Future<dynamic> verifyOTP(String email, int otp) async {
    try {
      final uri = "$backendApiUrl/accounts/verify-account";
      final result = await dio.post(uri, data: {
        "email": email,
        "otp": otp,
      });
      return result.data;
    } on DioError catch (e) {
      onDioError(e);
    } catch (e) {
      onUnkownError(e);
    }
  }

  Future<dynamic> createProfile(
      String email, String username, File profilePic, String token) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'username': username,
        'profilePic': await MultipartFile.fromFile(profilePic.path)
      });
      dio.options.headers["Authorization"] = "Bearer $token";

      final response =
          await dio.post('$backendApiUrl/profile/create', data: formData);
      return response.data;
    } on DioError catch (e) {
      onDioError(e);
    } catch (e) {
      onUnkownError(e);
    }
  }
}

void onDioError(DioError e) {
  if (e.response != null) {
    final data = e.response?.data;
    try {
      showMessage(
        message: data["message"],
        title: data["data"] ?? "Something went wrong",
        type: MessageType.error,
      );
    } catch (e) {
      showMessage(
        message:
            "Something went wrong | Unknown error occured, try again later or contact admin",
        title: "Internal Server Error",
        type: MessageType.error,
      );
    }
  } else {
    String msg = e.message ?? "Unkown error";
    if (DioErrorType.receiveTimeout == e.type ||
        DioErrorType.sendTimeout == e.type) {
      msg =
          "Server is not reachable. Please verify your internet connection and try again";
    } else
    // if (e.type != DioErrorType.unknown)
    {
      msg = "Problem connecting to the server. Please try again.";
    }
    showMessage(
      message: msg,
      title: "Something went wrong",
      type: MessageType.error,
    );
  }
}

void onUnkownError(Object e) {
  showMessage(
    message: e.toString(),
    title: "Something went wrong",
    type: MessageType.error,
  );
}

void onSuccess({required String title, required String message}) {
  showMessage(
    message: message,
    title: title,
    type: MessageType.success,
  );
}
