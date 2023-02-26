import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickstep_app/models/self_made_walk.dart';

class Boxes {
  static const selfMadeWalksBox = "SELF_MADE_WALKS_BOX";
}

class HiveService {
  Box box = Hive.box(Boxes.selfMadeWalksBox);

  /// Getting all new saved walks
  List<SelfMadeWalk> getAllWalks() {
    try {
      final data = box.keys.map((key) {
        final value = box.get(key);
        return SelfMadeWalk.fromJSON(value, key);
      }).toList();
      return data.reversed.toList();
    } catch (e) {
      return [];
    }
  }

  /// Saving new self-made walk
  Future<bool> addWalk(SelfMadeWalk newWalk) async {
    try {
      await box.add(SelfMadeWalk.toJSON(newWalk));
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Delete self-made walk
  Future<bool> deleteWalk(int id) async {
    try {
      await box.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
