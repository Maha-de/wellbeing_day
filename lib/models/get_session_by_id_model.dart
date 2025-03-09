// To parse this JSON data, do
//
//     final getSessionByIdModel = getSessionByIdModelFromJson(jsonString);

import 'dart:convert';

GetSessionByIdModel getSessionByIdModelFromJson(String str) => GetSessionByIdModel.fromJson(json.decode(str));

String getSessionByIdModelToJson(GetSessionByIdModel data) => json.encode(data.toJson());

class GetSessionByIdModel {
  String? message;
  Session? session;

  GetSessionByIdModel({
    this.message,
    this.session,
  });

  factory GetSessionByIdModel.fromJson(Map<String, dynamic> json) => GetSessionByIdModel(
    message: json["message"],
    session: json["session"] == null ? null : Session.fromJson(json["session"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "session": session?.toJson(),
  };
}

class Session {
  bool? isGroupReady;
  String? paymentStatus;
  String? id;
  String? category;
  String? subcategory;
  String? sessionType;
  String? description;
  DateTime? sessionDate;
  String? status;
  List<Beneficiary>? beneficiary;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? maxParticipants;

  Session({
    this.isGroupReady,
    this.paymentStatus,
    this.id,
    this.category,
    this.subcategory,
    this.sessionType,
    this.description,
    this.sessionDate,
    this.status,
    this.beneficiary,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.maxParticipants,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    isGroupReady: json["isGroupReady"],
    paymentStatus: json["paymentStatus"],
    id: json["_id"],
    category: json["category"],
    subcategory: json["subcategory"],
    sessionType: json["sessionType"],
    description: json["description"],
    sessionDate: json["sessionDate"] == null ? null : DateTime.parse(json["sessionDate"]),
    status: json["status"],
    beneficiary: json["beneficiary"] == null ? [] : List<Beneficiary>.from(json["beneficiary"]!.map((x) => Beneficiary.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    maxParticipants: json["maxParticipants"],
  );

  Map<String, dynamic> toJson() => {
    "isGroupReady": isGroupReady,
    "paymentStatus": paymentStatus,
    "_id": id,
    "category": category,
    "subcategory": subcategory,
    "sessionType": sessionType,
    "description": description,
    "sessionDate": sessionDate?.toIso8601String(),
    "status": status,
    "beneficiary": beneficiary == null ? [] : List<dynamic>.from(beneficiary!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "maxParticipants": maxParticipants,
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
  DateTime? createdAt;
  int? v;
  List<String>? sessions;

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
    this.createdAt,
    this.v,
    this.sessions,
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
    nationality: json["nationality"],
    gender: json["gender"],
    role: json["role"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
    sessions: json["sessions"] == null ? [] : List<String>.from(json["sessions"]!.map((x) => x)),
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
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
    "sessions": sessions == null ? [] : List<dynamic>.from(sessions!.map((x) => x)),
  };
}
