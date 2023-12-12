// To parse this JSON data, do
//
//     final userConnections = userConnectionsFromJson(jsonString);

import 'dart:convert';

List<UserConnections> userConnectionsFromJson(String str) => List<UserConnections>.from(json.decode(str).map((x) => UserConnections.fromJson(x)));

String userConnectionsToJson(List<UserConnections> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserConnections {
    String model;
    int pk;
    Fields fields;

    UserConnections({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory UserConnections.fromJson(Map<String, dynamic> json) => UserConnections(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    List<int> friends;

    Fields({
        required this.user,
        required this.friends,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        friends: List<int>.from(json["friends"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "friends": List<dynamic>.from(friends.map((x) => x)),
    };
}
