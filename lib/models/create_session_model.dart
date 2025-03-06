// To parse this JSON data, do
//
//     final createSessionModel = createSessionModelFromJson(jsonString);

import 'dart:convert';

CreateSessionModel createSessionModelFromJson(String str) => CreateSessionModel.fromJson(json.decode(str));

String createSessionModelToJson(CreateSessionModel data) => json.encode(data.toJson());

class CreateSessionModel {
  String? message;
  Session? session;

  CreateSessionModel({
    this.message,
    this.session,
  });

  factory CreateSessionModel.fromJson(Map<String, dynamic> json) => CreateSessionModel(
    message: json["message"],
    session: json["session"] == null ? null : Session.fromJson(json["session"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "session": session?.toJson(),
  };
}

class Session {
  String? category;
  String? subcategory;
  String? sessionType;
  String? description;
  DateTime? sessionDate;
  String? status;
  String? beneficiary;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Session({
    this.category,
    this.subcategory,
    this.sessionType,
    this.description,
    this.sessionDate,
    this.status,
    this.beneficiary,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    category: json["category"],
    subcategory: json["subcategory"],
    sessionType: json["sessionType"],
    description: json["description"],
    sessionDate: json["sessionDate"] == null ? null : DateTime.parse(json["sessionDate"]),
    status: json["status"],
    beneficiary: json["beneficiary"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "subcategory": subcategory,
    "sessionType": sessionType,
    "description": description,
    "sessionDate": sessionDate?.toIso8601String(),
    "status": status,
    "beneficiary": beneficiary,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
