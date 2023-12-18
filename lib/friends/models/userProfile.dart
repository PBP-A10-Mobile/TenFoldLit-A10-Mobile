// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<Profile> profileFromJson(String str) => List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(List<Profile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
    String username;
    dynamic profile;

    Profile({
        required this.username,
        required this.profile,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        username: json["username"],
        profile: json["profile"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "profile": profile,
    };
}
