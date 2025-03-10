// To parse this JSON data, do
//
//     final getGroupThreapyModel = getGroupThreapyModelFromJson(jsonString);

import 'dart:convert';

GetGroupThreapyModel getGroupThreapyModelFromJson(String str) => GetGroupThreapyModel.fromJson(json.decode(str));

String getGroupThreapyModelToJson(GetGroupThreapyModel data) => json.encode(data.toJson());

class GetGroupThreapyModel {
  List<Session>? sessions;

  GetGroupThreapyModel({
    this.sessions,
  });

  factory GetGroupThreapyModel.fromJson(Map<String, dynamic> json) => GetGroupThreapyModel(
    sessions: json["sessions"] == null ? [] : List<Session>.from(json["sessions"]!.map((x) => Session.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sessions": sessions == null ? [] : List<dynamic>.from(sessions!.map((x) => x.toJson())),
  };
}

class Session {
  String? id;
  String? sessionType;
  String? category;
  String? subcategory;
  String? description;
  String? sessionDate;
  String? status;
  List<Specialist>? beneficiary;
  Specialist? specialist;
  bool? isGroupReady;
  String? paymentStatus;
  int? maxParticipants;
  String? createdAt;
  String? updatedAt;
  int? v;

  Session({
    this.id,
    this.sessionType,
    this.category,
    this.subcategory,
    this.description,
    this.sessionDate,
    this.status,
    this.beneficiary,
    this.specialist,
    this.isGroupReady,
    this.paymentStatus,
    this.maxParticipants,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    id: json["_id"],
    sessionType: json["sessionType"],
    category: json["category"],
    subcategory: json["subcategory"],
    description: json["description"],
    sessionDate: json["sessionDate"] ,
    status: json["status"],
    beneficiary: json["beneficiary"] == null ? [] : List<Specialist>.from(json["beneficiary"]!.map((x) => Specialist.fromJson(x))),
    specialist: json["specialist"] == null ? null : Specialist.fromJson(json["specialist"]),
    isGroupReady: json["isGroupReady"],
    paymentStatus: json["paymentStatus"],
    maxParticipants: json["maxParticipants"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"] ,
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sessionType": sessionType,
    "category": category,
    "subcategory": subcategory,
    "description": description,
    "sessionDate": sessionDate,
    "status": status,
    "beneficiary": beneficiary == null ? [] : List<dynamic>.from(beneficiary!.map((x) => x.toJson())),
    "specialist": specialist?.toJson(),
    "isGroupReady": isGroupReady,
    "paymentStatus": paymentStatus,
    "maxParticipants": maxParticipants,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}

class Specialist {
  String? id;
  String? email;

  Specialist({
    this.id,
    this.email,
  });

  factory Specialist.fromJson(Map<String, dynamic> json) => Specialist(
    id: json["_id"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
  };
}
