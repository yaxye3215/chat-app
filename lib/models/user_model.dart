import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String msg;
  final String token;
  final String id;
  final String name;
  final String email;
  final String profilePic;

  UserModel({
    required this.msg,
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    required this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        msg: json["msg"],
        token: json["token"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        profilePic: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "token": token,
        "_id": id,
        "name": name,
        "email": email,
        "profile_pic": profilePic,
      };
}
