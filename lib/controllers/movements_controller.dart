import 'package:get/get.dart';
import 'package:quickstep_app/models/movement.dart';
import 'package:quickstep_app/models/user.dart';
import 'package:quickstep_app/services/db_service.dart';

class MovementController extends GetxController
    with StateMixin<List<Movement>> {
  List<Movement> movements = RxList<Movement>([]);
  final dbService = DBService();
  var currentMovementId = "".obs;
  List<User> currentMoveMembers = RxList<User>([]);
  List<ChatMessage> chatMessages = RxList<ChatMessage>([]);
  var currentMovingUserId = "".obs;

  @override
  void onInit() {
    getMovements();
    super.onInit();
  }

  getMovements() async {
    // movements = dummyMovements;
    if (isClosed) return;
    // change(movements, status: RxStatus.loading());
    final moves = await dbService.getMovements();
    if (moves != null) {
      movements = moves;
    }
    change(moves, status: RxStatus.success());
  }

  addMovement(Movement movement) {
    getMovements();
  }

  removeMovement(String id) {
    getMovements();
  }

  Future<bool> leaveMovement() async {
    final res = await dbService.leaveMovement(currentMovementId.value);
    if (res == true) {
      getMovements();
    }
    return res;
  }

  addMessage(ChatMessage message) {
    chatMessages.add(message);
  }

  void markAsSeen(ChatMessage message) {
    try {
      final index = chatMessages.indexWhere((element) =>
          element.user.id == message.user.id &&
          element.message == message.message);
      chatMessages[index] = message;
    } catch (e) {
      return;
    }
  }

  @override
  void onClose() {
    currentMoveMembers.clear();
    currentMovementId.value = "";
    currentMovingUserId.value = "";
    chatMessages.clear();
    super.onClose();
  }
}
