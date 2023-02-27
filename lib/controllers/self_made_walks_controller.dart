import 'package:get/get.dart';
import 'package:quickstep_app/models/self_made_walk.dart';
import 'package:quickstep_app/services/hive_service.dart';

enum StateAction { idle, loading, added, removed }

class WalksController extends GetxController {
  List<SelfMadeWalk> walks = RxList(<SelfMadeWalk>[]);
  var currentState = StateAction.idle.obs;
  final HiveService _hiveService = HiveService();

  void getWalks() {
    walks = _hiveService.getAllWalks();
  }

  void addWalk(SelfMadeWalk walk) {
    currentState.value = StateAction.loading;
    _hiveService.addWalk(walk);
    walks.add(walk);
    currentState.value = StateAction.added;
  }

  void removeWalk(int id) {
    currentState.value = StateAction.loading;
    _hiveService.deleteWalk(id);
    walks.removeWhere((walk) => walk.id == id);
    currentState.value = StateAction.removed;
  }
}
