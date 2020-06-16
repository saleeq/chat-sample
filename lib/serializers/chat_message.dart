import 'dart:convert';

/***
 * Serialzer for chat messages being sent by users
 */
class ChatMessage {
  ChatMessage({
    this.id,
    this.message,
    this.image,
    this.fromId,
    this.toId,
    this.date,
    this.isImage,
  });

  String id;
  String message;
  String image;
  int fromId;
  int toId;
  String date;
  bool isImage;

  factory ChatMessage.fromRawJson(String str) => ChatMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json["id"],
    message: json["message"],
    image: json["image"],
    fromId: json["fromId"],
    toId: json["toId"],
    date: json["date"],
    isImage: json["isImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "image": image,
    "fromId": fromId,
    "toId": toId,
    "date": date,
    "isImage": isImage,
  };
}
