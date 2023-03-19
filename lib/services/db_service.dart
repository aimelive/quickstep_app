import 'package:quickstep_app/models/movement.dart';
import 'package:dio/dio.dart';
import 'package:quickstep_app/models/notification.dart';
import 'package:quickstep_app/models/profile.dart';
import 'package:quickstep_app/screens/components/top_snackbar.dart';
import 'package:quickstep_app/utils/keys.dart';

import 'auth_service.dart';

class DBService {
  final dio = Dio();
  final authService = AuthService();

  Future<List<Movement>?> getMovements() async {
    try {
      dio.options.headers["Authorization"] =
          "Bearer ${authService.getAuthToken()}";
      final res = await dio.get("$backendApiUrl/movements");
      List<Movement> movements = [];

      for (var movement in res.data["data"]) {
        movements.add(Movement.fromJSON(movement));
      }
      // print(movements.length);
      return movements;
    } on DioError catch (e) {
      onDioError(e);
      return null;
    } catch (e) {
      onUnkownError(e);
      return null;
    }
  }

  Future<Movement?> getOneMovement(String id) async {
    try {
      dio.options.headers["Authorization"] =
          "Bearer ${authService.getAuthToken()}";
      final res = await dio.get("$backendApiUrl/movements/$id");
      return Movement.fromJSON(res.data["data"]);
    } on DioError catch (e) {
      onDioError(e);
      return null;
    } catch (e) {
      onUnkownError(e);
      return null;
    }
  }

  Future<bool> leaveMovement(String id) async {
    try {
      dio.options.headers["Authorization"] =
          "Bearer ${authService.getAuthToken()}";
      final res = await dio.patch("$backendApiUrl/movements/$id");
      showMessage(message: res.data["message"], title: res.data["data"]);
      return true;
    } on DioError catch (e) {
      onDioError(e);
      return false;
    } catch (e) {
      onUnkownError(e);
      return false;
    }
  }

  Future<List<Profile>?> getUsers() async {
    try {
      dio.options.headers["Authorization"] =
          "Bearer ${authService.getAuthToken()}";
      final res = await dio.get("$backendApiUrl/accounts");
      List<Profile> users = [];

      for (var profile in res.data["data"]) {
        users.add(Profile.fromJson(profile));
      }
      // print(movements.length);
      return users;
    } on DioError catch (e) {
      onDioError(e);
      return null;
    } catch (e) {
      onUnkownError(e);
      return null;
    }
  }

  Future<Movement?> createMovement({
    required String title,
    required String description,
    required String creatorName,
    required List<String> actors,
  }) async {
    try {
      dio.options.headers["Authorization"] =
          "Bearer ${authService.getAuthToken()}";
      final res = await dio.post("$backendApiUrl/movements/create", data: {
        "title": title,
        "description": description,
        "creator": creatorName,
        "actors": actors,
      });
      return Movement.fromJSON(res.data["movement"]);
    } on DioError catch (e) {
      onDioError(e);
      return null;
    } catch (e) {
      onUnkownError(e);
      return null;
    }
  }

  Future<bool?> deleteMovement(String id) async {
    try {
      dio.options.headers["Authorization"] =
          "Bearer ${authService.getAuthToken()}";
      final res = await dio.delete("$backendApiUrl/movements/$id");
      onSuccess(
        title: "Movement deleted",
        message: res.data["message"],
      );
      return true;
    } on DioError catch (e) {
      onDioError(e);
      return null;
    } catch (e) {
      onUnkownError(e);
      return null;
    }
  }

  Future<List<AppNotification>?> getNotifications() async {
    try {
      dio.options.headers["Authorization"] =
          "Bearer ${authService.getAuthToken()}";
      final res = await dio.get("$backendApiUrl/notifications");

      List<AppNotification> notis = [];

      for (var notification in res.data["notifications"]) {
        notis.add(AppNotification.fromJSON(notification));
      }

      return notis;
    } on DioError catch (e) {
      onDioError(e);
      return null;
    } catch (e) {
      onUnkownError(e);
      return null;
    }
  }

  Future<bool> deleteNotification(String id) async {
    try {
      dio.options.headers["Authorization"] =
          "Bearer ${authService.getAuthToken()}";
      await dio.delete("$backendApiUrl/notifications/$id");
      return true;
    } on DioError catch (e) {
      onDioError(e);
      return false;
    } catch (e) {
      onUnkownError(e);
      return false;
    }
  }
}
