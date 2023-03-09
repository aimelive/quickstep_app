import 'package:quickstep_app/models/movement.dart';
import 'package:dio/dio.dart';
import 'package:quickstep_app/models/profile.dart';
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
      await dio.delete("$backendApiUrl/movements/$id");
      return true;
    } on DioError catch (e) {
      onDioError(e);
      return null;
    } catch (e) {
      onUnkownError(e);
      return null;
    }
  }
}
