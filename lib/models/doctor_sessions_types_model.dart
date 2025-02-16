// To parse this JSON data, do
//
//     final doctorSessionsModel = doctorSessionsModelFromJson(jsonString);

import 'dart:convert';

DoctorSessionsTypesModel doctorSessionsTypesModelFromJson(String str) => DoctorSessionsTypesModel.fromJson(json.decode(str));

String doctorSessionsTypesModelToJson(DoctorSessionsTypesModel data) => json.encode(data.toJson());

class DoctorSessionsTypesModel {
  List<EdSession>? scheduledSessions;
  List<EdSession>? completedSessions;

  DoctorSessionsTypesModel({
    this.scheduledSessions,
    this.completedSessions,
  });

  factory DoctorSessionsTypesModel.fromJson(Map<String, dynamic> json) => DoctorSessionsTypesModel(
    scheduledSessions: json["scheduledSessions"] == null ? [] : List<EdSession>.from(json["scheduledSessions"]!.map((x) => EdSession.fromJson(x))),
    completedSessions: json["completedSessions"] == null ? [] : List<EdSession>.from(json["completedSessions"]!.map((x) => EdSession.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "scheduledSessions": scheduledSessions == null ? [] : List<dynamic>.from(scheduledSessions!.map((x) => x.toJson())),
    "completedSessions": completedSessions == null ? [] : List<dynamic>.from(completedSessions!.map((x) => x.toJson())),
  };
}

class EdSession {
  String? id;
  DateTime? sessionDate;
  Beneficiary? beneficiary;

  EdSession({
    this.id,
    this.sessionDate,
    this.beneficiary,
  });

  factory EdSession.fromJson(Map<String, dynamic> json) => EdSession(
    id: json["_id"],
    sessionDate: json["sessionDate"] == null ? null : DateTime.parse(json["sessionDate"]),
    beneficiary: json["beneficiary"] == null ? null : Beneficiary.fromJson(json["beneficiary"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sessionDate": sessionDate?.toIso8601String(),
    "beneficiary": beneficiary?.toJson(),
  };
}

class Beneficiary {
  String? id;
  String? firstName;
  String? lastName;
  String? profession;
  int? age;
  String? nationality;
  String? gender;

  Beneficiary({
    this.id,
    this.firstName,
    this.lastName,
    this.profession,
    this.age,
    this.nationality,
    this.gender,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    profession: json["profession"],
    age: json["age"],
    nationality: json["nationality"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "profession":profession,
    "age": age,
    "nationality": nationality,
    "gender": gender,
  };
}


