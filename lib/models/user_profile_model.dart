// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
  String? firstName;
  String? lastName;
  int? age;
  String? gender;
  String? nationality;
  String? profession;
  String? imageUrl;
  List<dynamic>? scheduledSessions;
  List<dynamic>? completedSessions;

  UserProfileModel({
    this.firstName,
    this.lastName,
    this.age,
    this.gender,
    this.nationality,
    this.profession,
    this.imageUrl,
    this.scheduledSessions,
    this.completedSessions,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    firstName: json["firstName"],
    lastName: json["lastName"],
    age: json["age"],
    gender: json["gender"],
    nationality: json["nationality"],
    profession: json["profession"],
    imageUrl: json["imageUrl"],
    scheduledSessions: json["scheduledSessions"] == null ? [] : List<dynamic>.from(json["scheduledSessions"]!.map((x) => x)),
    completedSessions: json["completedSessions"] == null ? [] : List<dynamic>.from(json["completedSessions"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "age": age,
    "gender": gender,
    "nationality": nationality,
    "profession": profession,
    "imageUrl": imageUrl,
    "scheduledSessions": scheduledSessions == null ? [] : List<dynamic>.from(scheduledSessions!.map((x) => x)),
    "completedSessions": completedSessions == null ? [] : List<dynamic>.from(completedSessions!.map((x) => x)),
  };
}
