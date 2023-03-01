import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickstep_app/models/self_made_walk.dart';
import 'package:quickstep_app/services/auth_service.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../models/activity.dart';

class Boxes {
  static const selfMadeWalksBox = "SELF_MADE_WALKS_BOX";
  static const activitiesBox = "ACTIVITIES_BOX";
  static const authBox = "AUTH_BOX";
}

class HiveService {
  Box walksBox = Hive.box(Boxes.selfMadeWalksBox);
  Box activitiesBox = Hive.box(Boxes.activitiesBox);
  final profile = AuthService().getAuth();

  /// Getting all new saved walks
  List<SelfMadeWalk> getAllWalks() {
    try {
      final data = walksBox.keys.map((key) {
        final value = walksBox.get(key);
        return SelfMadeWalk.fromJSON(value, key);
      }).toList();
      return data.reversed
          .where(
            (walk) => walk.creatorId == profile!.userId,
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Saving new self-made walk
  Future<bool> addWalk(SelfMadeWalk newWalk) async {
    try {
      await walksBox.add(SelfMadeWalk.toJSON(newWalk));
      addActivity(
        Activity(
            id: newWalk.id,
            text:
                "You have successfully travelled new walk. ${newWalk.title}, It took you ${getTimer(newWalk.createdAt, newWalk.endedAt)} to travel",
            createdAt: DateTime.now(),
            type: ActivityType.add,
            creatorId: newWalk.creatorId),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Delete self-made walk
  Future<bool> deleteWalk(SelfMadeWalk walk) async {
    try {
      await walksBox.delete(walk.id);
      addActivity(
        Activity(
          id: walk.id,
          text: "You have successfully deleted the walk. ${walk.title}",
          createdAt: DateTime.now(),
          creatorId: walk.creatorId,
          type: ActivityType.delete,
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Getting all activities
  List<Activity> getAllActivities() {
    try {
      final data = activitiesBox.keys.map((key) {
        final value = activitiesBox.get(key);
        return Activity.fromJSON(value, key);
      }).toList();
      return data.reversed
          .where(
            (activity) => activity.creatorId == profile!.userId,
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Saving new activity
  Future<bool> addActivity(Activity newActivity) async {
    try {
      await activitiesBox.add(Activity.toJSON(newActivity));
      return true;
    } catch (e) {
      // print(e);
      return false;
    }
  }

  /// Delete activity
  Future<bool> deleteActivity(int id) async {
    try {
      await activitiesBox.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Delete all activities
  Future<bool> deleteAllActivity() async {
    try {
      await activitiesBox.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// CACHES
  /// Getting all activities
  List<Activity> getCachedActivities() {
    try {
      final data = activitiesBox.keys.map((key) {
        final value = activitiesBox.get(key);
        return Activity.fromJSON(value, key);
      }).toList();
      return data.reversed
          .where(
            (activity) => activity.creatorId != profile!.userId,
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Getting all new saved walks
  List<SelfMadeWalk> getCachedWalks() {
    try {
      final data = walksBox.keys.map((key) {
        final value = walksBox.get(key);
        return SelfMadeWalk.fromJSON(value, key);
      }).toList();
      return data.reversed
          .where(
            (walk) => walk.creatorId != profile!.userId,
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  //deleteCachedWalks
  Future<bool> deleteCachedWalks(List<int> keys) async {
    try {
      await walksBox.deleteAll(keys);
      return true;
    } catch (e) {
      return false;
    }
  }

  //deleteCachedWalks
  Future<bool> deleteCachedActivities(List<int> keys) async {
    try {
      await activitiesBox.deleteAll(keys);
      return true;
    } catch (e) {
      return false;
    }
  }
}
