import 'dart:convert';

/***
 * Serializer for contacts displayed in chat list
 */
class Contact {
  Contact({
    this.id,
    this.name,
    this.image,
    this.isOnline,
  });

  int id;
  String name;
  String image;
  bool isOnline;

  factory Contact.fromRawJson(String str) => Contact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    isOnline: json["isOnline"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "isOnline": isOnline,
  };
}
