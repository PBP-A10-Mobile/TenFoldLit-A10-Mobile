// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    int userConnectionId;
    int userId;
    String password;
    DateTime? lastLogin;
    String username;
    String email;

    User({
        required this.userConnectionId,
        required this.userId,
        required this.password,
        required this.lastLogin,
        required this.username,
        required this.email,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userConnectionId: json["user_connection_id"],
        userId: json["user_id"],
        password: json["password"],
        lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
        username: json["username"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "user_connection_id": userConnectionId,
        "user_id": userId,
        "password": password,
        "last_login": lastLogin?.toIso8601String(),
        "username": username,
        "email": email,
    };
}
