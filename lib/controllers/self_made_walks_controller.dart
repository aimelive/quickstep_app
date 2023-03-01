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

  Future<void> addWalk(SelfMadeWalk walk) async {
    currentState.value = StateAction.loading;
    await _hiveService.addWalk(walk);
    walks.add(walk);
    currentState.value = StateAction.added;
  }

  Future<void> removeWalk(SelfMadeWalk walk) async {
    currentState.value = StateAction.loading;
    await _hiveService.deleteWalk(walk);
    walks.removeWhere((walkA) => walkA.id == walk.id);
    currentState.value = StateAction.removed;
  }
}
