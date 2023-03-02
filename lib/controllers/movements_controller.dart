import 'package:get/get.dart';
import 'package:quickstep_app/models/movement.dart';

class MovementController extends GetxController
    with StateMixin<List<Movement>> {
  List<Movement> movements = RxList<Movement>([]);

  @override
  void onInit() {
    getMovements();
    super.onInit();
  }

  getMovements() {
    movements = dummyMovements;
    change(movements, status: RxStatus.success());
  }

  addMovement(Movement movement) {
    change(movements, status: RxStatus.loading());
    movements.add(movement);
    change(movements, status: RxStatus.success());
  }
}
