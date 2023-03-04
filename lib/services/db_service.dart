import 'package:quickstep_app/models/movement.dart';
import 'package:dio/dio.dart';
import 'package:quickstep_app/utils/keys.dart';

class DBService {
  final dio = Dio();

  Future<List<Movement>> getMovements() async {
    try {
      final res = await dio.get("$backendApiUrl/movements");

      List<Movement> movements = [];

      for (var movement in res.data["data"]) {
        movements.add(Movement.fromJSON(movement));
      }
      // print(movements.length);
      return movements;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
