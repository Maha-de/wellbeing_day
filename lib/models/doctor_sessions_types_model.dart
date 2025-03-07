// To parse this JSON data, do
//
//     final doctorSessionsTypesModel = doctorSessionsTypesModelFromJson(jsonString);

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
  String? email;
  String? password;
  String? phone;
  String? profession;
  String? homeAddress;
  int? age;
  String? region;
  String? nationality;
  String? gender;
  String? role;
  List<String>? sessions;
  DateTime? createdAt;
  int? v;

  Beneficiary({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.profession,
    this.homeAddress,
    this.age,
    this.region,
    this.nationality,
    this.gender,
    this.role,
    this.sessions,
    this.createdAt,
    this.v,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
    id: json["_id"],
    firstName:json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    profession: json["profession"],
    homeAddress: json["homeAddress"],
    age: json["age"],
    region: json["region"],
    nationality: json["nationality"],
    gender:json["gender"],
    role: json["role"],
    sessions: json["sessions"] == null ? [] : List<String>.from(json["sessions"].map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "phone": phone,
    "profession": profession,
    "homeAddress":homeAddress,
    "age": age,
    "region": region,
    "nationality": nationality,
    "gender": gender,
    "role": role,
    "sessions": sessions == null ? [] : List<dynamic>.from(sessions!.map((x) => id)),
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };
}

