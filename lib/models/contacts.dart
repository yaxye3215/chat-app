
import 'dart:convert';

List<Contacts> contactsFromJson(String str) => List<Contacts>.from(json.decode(str).map((x) => Contacts.fromJson(x)));

String contactsToJson(List<Contacts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contacts {
    final String id;
    final String name;
    final String email;
    final String status;
    final String profilePicture;

    Contacts({
        required this.id,
        required this.name,
        required this.email,
        required this.status,
        required this.profilePicture,
    });

    factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        status: json["status"],
        profilePicture: json["profilePicture"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "status": status,
        "profilePicture": profilePicture,
    };
}
