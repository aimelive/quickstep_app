enum NotificationAction { join, unknown }

Map<String, NotificationAction> actions = {
  "JOIN_MOVEMENT": NotificationAction.join,
};
Map<NotificationAction, String> actionsStr = {
  NotificationAction.join: "JOIN MOVEMENT",
};

class AppNotification {
  String id;
  String message;
  NotificationAction action;
  DateTime createdAt;
  dynamic data;

  AppNotification({
    required this.id,
    required this.message,
    required this.action,
    required this.createdAt,
    required this.data,
  });

  static AppNotification fromJSON(dynamic json) {
    return AppNotification(
      id: json["_id"],
      message: json["message"],
      action: actions[json["action"]] ?? NotificationAction.unknown,
      data: json["data"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}
