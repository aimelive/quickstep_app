import 'package:flutter/material.dart';

enum ActivityType { add, delete }

Map<ActivityType, String> toStr = {
  ActivityType.add: "add",
  ActivityType.delete: "delete",
};

Map<String, ActivityType> fromStr = {
  "add": ActivityType.add,
  "delete": ActivityType.delete,
};

Map<ActivityType, IconData> toIcon = {
  ActivityType.add: Icons.add_alert,
  ActivityType.delete: Icons.delete_sweep,
};

class Activity {
  int id;
  String text;
  String creatorId;
  DateTime createdAt;
  ActivityType type;

  Activity({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.type,
    required this.creatorId,
  });

  static Activity fromJSON(dynamic json, int id) {
    return Activity(
      id: id,
      text: json["text"],
      createdAt: json["createdAt"],
      type: fromStr[json["type"]]!,
      creatorId: json["creatorId"],
    );
  }

  static Map<String, dynamic> toJSON(Activity activity) {
    return {
      "text": activity.text,
      "createdAt": activity.createdAt,
      "type": toStr[activity.type],
      "creatorId": activity.creatorId,
    };
  }
}
