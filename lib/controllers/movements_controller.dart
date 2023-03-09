import 'package:get/get.dart';
import 'package:quickstep_app/models/movement.dart';
import 'package:quickstep_app/services/db_service.dart';

class MovementController extends GetxController
    with StateMixin<List<Movement>> {
  List<Movement> movements = RxList<Movement>([]);
  final dbService = DBService();

  @override
  void onInit() {
    getMovements();
    super.onInit();
  }

  getMovements() async {
    // movements = dummyMovements;
    change(movements, status: RxStatus.loading());
    final moves = await dbService.getMovements();
    change(moves, status: RxStatus.success());
  }

  addMovement(Movement movement) {
    movements.add(movement);
    change(movements, status: RxStatus.success());
  }
}
