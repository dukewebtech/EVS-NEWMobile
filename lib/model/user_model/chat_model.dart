// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({
    this.data,
  });

  List<Chats>? data;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    data: List<Chats>.from(json["data"].map((x) => Chats.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Chats {
  Chats({
    this.messageId,
    this.message,
    this.attachment,
    this.direction,
    this.sender,
    this.recipient,
    this.sentAt,
  });

  dynamic messageId;
  dynamic message;
  Attachment? attachment;
  dynamic direction;
  dynamic sender;
  dynamic recipient;
  DateTime? sentAt;

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
    messageId: json["message_id"],
    message: json["message"],
    attachment: json["attachment"] == null ? null : Attachment.fromJson(json["attachment"]),
    direction: json["direction"],
    sender: json["sender"],
    recipient: json["recipient"],
    sentAt: DateTime.parse(json["sent_at"]),
  );

  Map<String, dynamic> toJson() => {
    "message_id": messageId,
    "message": message,
    "attachment": attachment == null ? null : attachment!.toJson(),
    "direction": direction,
    "sender": sender,
    "recipient": recipient,
    "sent_at": sentAt!.toIso8601String(),
  };
}

class Attachment {
  Attachment({
    this.file,
  });

  String? file;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "file": file,
  };
}
