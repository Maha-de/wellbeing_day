// To parse this JSON data, do
//
//     final beneficiarySessionModel = beneficiarySessionModelFromJson(jsonString);

import 'dart:convert';

BeneficiarySessionModel beneficiarySessionModelFromJson(String str) => BeneficiarySessionModel.fromJson(json.decode(str));

String beneficiarySessionModelToJson(BeneficiarySessionModel data) => json.encode(data.toJson());

class BeneficiarySessionModel {
  int? totalSessions;
  List<Session>? scheduledSessions;
  List<Session>? completedSessions;
  List<Session>? canceledSessions;
  List<Session>? upcomingSessions;

  BeneficiarySessionModel({
    this.totalSessions,
    this.scheduledSessions,
    this.completedSessions,
    this.canceledSessions,
    this.upcomingSessions,
  });

  factory BeneficiarySessionModel.fromJson(Map<String, dynamic> json) => BeneficiarySessionModel(
    totalSessions: json["totalSessions"],
    scheduledSessions: json["scheduledSessions"] == null ? [] : List<Session>.from(json["scheduledSessions"]!.map((x) => Session.fromJson(x))),
    completedSessions: json["completedSessions"] == null ? [] : List<Session>.from(json["completedSessions"]!.map((x) => Session.fromJson(x))),
    canceledSessions: json["canceledSessions"] == null ? [] : List<Session>.from(json["canceledSessions"]!.map((x) => Session.fromJson(x))),
    upcomingSessions: json["upcomingSessions"] == null ? [] : List<Session>.from(json["upcomingSessions"]!.map((x) => Session.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalSessions": totalSessions,
    "scheduledSessions": scheduledSessions == null ? [] : List<dynamic>.from(scheduledSessions!.map((x) => x.toJson())),
    "completedSessions": completedSessions == null ? [] : List<dynamic>.from(completedSessions!.map((x) => x.toJson())),
    "canceledSessions": canceledSessions == null ? [] : List<dynamic>.from(canceledSessions!.map((x) => x.toJson())),
    "upcomingSessions": upcomingSessions == null ? [] : List<dynamic>.from(upcomingSessions!.map((x) => x.toJson())),
  };
}

class Session {
  String? id;
  String? category;
  String? subcategory;
  String? sessionType;
  String? description;
  DateTime? sessionDate;
  String? status;
  List<String>? beneficiary; // تعديل هنا
  String? specialist;
  String? paymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Session({
    this.id,
    this.category,
    this.subcategory,
    this.sessionType,
    this.description,
    this.sessionDate,
    this.status,
    this.beneficiary,
    this.specialist,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    id: json["_id"],
    category: json["category"],
    subcategory: json["subcategory"],
    sessionType: json["sessionType"],
    description: json["description"],
    sessionDate: json["sessionDate"] == null ? null : DateTime.parse(json["sessionDate"]),
    status: json["status"],
    beneficiary: json["beneficiary"] == null ? [] : List<String>.from(json["beneficiary"].map((x) => x.toString())), // تعديل هنا
    specialist: json["specialist"],
    paymentStatus: json["paymentStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category": category,
    "subcategory": subcategory,
    "sessionType": sessionType,
    "description": description,
    "sessionDate": sessionDate?.toIso8601String(),
    "status": status,
    "beneficiary": beneficiary == null ? [] : List<dynamic>.from(beneficiary!.map((x) => x)), // تعديل هنا
    "specialist": specialist,
    "paymentStatus": paymentStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}


