// To parse this JSON data, do
//
//     final doctorSessionsModel = doctorSessionsModelFromJson(jsonString);

import 'dart:convert';

DoctorSessionsModel doctorSessionsModelFromJson(String str) => DoctorSessionsModel.fromJson(json.decode(str));

String doctorSessionsModelToJson(DoctorSessionsModel data) => json.encode(data.toJson());

class DoctorSessionsModel {
  List<InstantSession>? instantSessions;
  List<FreeConsultation>? freeConsultations;
  List<EdSession>? scheduledSessions;
  List<EdSession>? completedSessions;

  DoctorSessionsModel({
    this.instantSessions,
    this.freeConsultations,
    this.scheduledSessions,
    this.completedSessions,
  });

  factory DoctorSessionsModel.fromJson(Map<String, dynamic> json) => DoctorSessionsModel(
    instantSessions: json["instantSessions"] == null ? [] : List<InstantSession>.from(json["instantSessions"]!.map((x) => InstantSession.fromJson(x))),
    freeConsultations: json["freeConsultations"] == null ? [] : List<FreeConsultation>.from(json["freeConsultations"]!.map((x) => FreeConsultation.fromJson(x))),
    scheduledSessions: json["scheduledSessions"] == null ? [] : List<EdSession>.from(json["scheduledSessions"]!.map((x) => EdSession.fromJson(x))),
    completedSessions: json["completedSessions"] == null ? [] : List<EdSession>.from(json["completedSessions"]!.map((x) => EdSession.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "instantSessions": instantSessions == null ? [] : List<dynamic>.from(instantSessions!.map((x) => x.toJson())),
    "freeConsultations": freeConsultations == null ? [] : List<dynamic>.from(freeConsultations!.map((x) => x.toJson())),
    "scheduledSessions": scheduledSessions == null ? [] : List<dynamic>.from(scheduledSessions!.map((x) => x.toJson())),
    "completedSessions": completedSessions == null ? [] : List<dynamic>.from(completedSessions!.map((x) => x.toJson())),
  };
}

class EdSession {
  String? id;
  DateTime? sessionDate;
  List<Beneficiary>? beneficiary;

  EdSession({
    this.id,
    this.sessionDate,
    this.beneficiary,
  });

  factory EdSession.fromJson(Map<String, dynamic> json) => EdSession(
    id: json["_id"],
    sessionDate: json["sessionDate"] == null ? null : DateTime.parse(json["sessionDate"]),
    beneficiary: json["beneficiary"] == null ? [] : List<Beneficiary>.from(json["beneficiary"]!.map((x) => Beneficiary.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sessionDate": sessionDate?.toIso8601String(),
    "beneficiary": beneficiary == null ? [] : List<dynamic>.from(beneficiary!.map((x) => x.toJson())),
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
  String? imageUrl;

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
    this.imageUrl,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    profession: json["profession"],
    homeAddress: json["homeAddress"],
    age: json["age"],
    region: json["region"],
    nationality:json["nationality"],
    gender: json["gender"],
    role: json["role"],
    sessions: json["sessions"] == null ? [] : List<String>.from(json["sessions"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "phone": phone,
    "profession": profession,
    "homeAddress": homeAddress,
    "age": age,
    "region": region,
    "nationality": nationality,
    "gender": gender,
    "role":role,
    "sessions": sessions == null ? [] : List<dynamic>.from(sessions!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
    "imageUrl": imageUrl,
  };
}

class FreeConsultation {
  bool? isGroupReady;
  String? id;
  String? category;
  String? subcategory;
  String? sessionType;
  String? description;
  DateTime? sessionDate;
  String? status;
  List<Beneficiary>? beneficiary;
  String? specialist;
  String? paymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? maxParticipants;
  DateTime? requestedDate;

  FreeConsultation({
    this.isGroupReady,
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
    this.maxParticipants,
    this.requestedDate,
  });

  factory FreeConsultation.fromJson(Map<String, dynamic> json) => FreeConsultation(
    isGroupReady: json["isGroupReady"],
    id: json["_id"],
    category: json["category"],
    subcategory: json["subcategory"],
    sessionType: json["sessionType"],
    description: json["description"],
    sessionDate: json["sessionDate"] == null ? null : DateTime.parse(json["sessionDate"]),
    status: json["status"],
    beneficiary: json["beneficiary"] == null ? [] : List<Beneficiary>.from(json["beneficiary"]!.map((x) => Beneficiary.fromJson(x))),
    specialist: json["specialist"],
    paymentStatus: json["paymentStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    maxParticipants: json["maxParticipants"],
    requestedDate: json["requestedDate"] == null ? null : DateTime.parse(json["requestedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "isGroupReady": isGroupReady,
    "_id": id,
    "category": category,
    "subcategory": subcategory,
    "sessionType": sessionType,
    "description": description,
    "sessionDate": sessionDate?.toIso8601String(),
    "status": status,
    "beneficiary": beneficiary == null ? [] : List<dynamic>.from(beneficiary!.map((x) => x.toJson())),
    "specialist": specialist,
    "paymentStatus": paymentStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "maxParticipants": maxParticipants,
    "requestedDate": requestedDate?.toIso8601String(),
  };
}

class InstantSession {
  bool? isGroupReady;
  String? id;
  String? category;
  String? subcategory;
  String? sessionType;
  String? description;
  DateTime? sessionDate;
  String? status;
  List<Beneficiary>? beneficiary;
  String? specialist;
  String? paymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? maxParticipants;
  String? sstatus;

  InstantSession({
    this.isGroupReady,
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
    this.maxParticipants,
    this.sstatus,
  });

  factory InstantSession.fromJson(Map<String, dynamic> json) => InstantSession(
    isGroupReady: json["isGroupReady"],
    id: json["_id"],
    category: json["category"],
    subcategory: json["subcategory"],
    sessionType: json["sessionType"],
    description: json["description"],
    sessionDate: json["sessionDate"] == null ? null : DateTime.parse(json["sessionDate"]),
    status: json["status"],
    beneficiary: json["beneficiary"] == null ? [] : List<Beneficiary>.from(json["beneficiary"]!.map((x) => Beneficiary.fromJson(x))),
    specialist: json["specialist"],
    paymentStatus: json["paymentStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    maxParticipants: json["maxParticipants"],
    sstatus: json["sstatus"],
  );

  Map<String, dynamic> toJson() => {
    "isGroupReady": isGroupReady,
    "_id":id,
    "category": category,
    "subcategory": subcategory,
    "sessionType": sessionType,
    "description": description,
    "sessionDate": sessionDate?.toIso8601String(),
    "status": status,
    "beneficiary": beneficiary == null ? [] : List<dynamic>.from(beneficiary!.map((x) => x.toJson())),
    "specialist": specialist,
    "paymentStatus": paymentStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "maxParticipants": maxParticipants,
    "sstatus": sstatus,
  };
}


