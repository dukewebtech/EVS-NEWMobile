import 'dart:convert';

List<NotificationModelApi> notificationModelFromJson(String str) => List<NotificationModelApi>.from(json.decode(str).map((x) => NotificationModelApi.fromJson(x)));

String notificationModelToJson(List<NotificationModelApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModelApi {
  NotificationModelApi({
    this.id,
    this.userId,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.link,
  });

  dynamic id;
  dynamic userId;
  dynamic message;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic link;

  factory NotificationModelApi.fromJson(Map<String, dynamic> json) => NotificationModelApi(
    id: json["id"],
    userId: json["user_id"],
    message: json["message"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "message": message,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "link": link,
  };
}

