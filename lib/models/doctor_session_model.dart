// To parse this JSON data, do
//
//     final doctorSessionsModel = doctorSessionsModelFromJson(jsonString);

import 'dart:convert';

DoctorSessionsModel doctorSessionsModelFromJson(String str) => DoctorSessionsModel.fromJson(json.decode(str));

String doctorSessionsModelToJson(DoctorSessionsModel data) => json.encode(data.toJson());

class DoctorSessionsModel {
  List<Ion>? instantSessions;
  List<Ion>? freeConsultations;

  DoctorSessionsModel({
    this.instantSessions,
    this.freeConsultations,
  });

  factory DoctorSessionsModel.fromJson(Map<String, dynamic> json) => DoctorSessionsModel(
    instantSessions: json["instantSessions"] == null ? [] : List<Ion>.from(json["instantSessions"]!.map((x) => Ion.fromJson(x))),
    freeConsultations: json["freeConsultations"] == null ? [] : List<Ion>.from(json["freeConsultations"]!.map((x) => Ion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "instantSessions": instantSessions == null ? [] : List<dynamic>.from(instantSessions!.map((x) => x.toJson())),
    "freeConsultations": freeConsultations == null ? [] : List<dynamic>.from(freeConsultations!.map((x) => x.toJson())),
  };
}

class Ion {
  String? id;
  String? category;
  String? subcategory;
  String? sessionType;
  String? description;
  DateTime? sessionDate;
  String? status;
  Beneficiary? beneficiary;
  String? specialist;
  String? paymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Ion({
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

  factory Ion.fromJson(Map<String, dynamic> json) => Ion(
    id: json["_id"],
    category: json["category"],
    subcategory: json["subcategory"],
    sessionType: json["sessionType"],
    description: json["description"],
    sessionDate: json["sessionDate"] == null ? null : DateTime.parse(json["sessionDate"]),
    status: json["status"],
    beneficiary: json["beneficiary"] == null ? null : Beneficiary.fromJson(json["beneficiary"]),
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
    "beneficiary": beneficiary?.toJson(),
    "specialist": specialist,
    "paymentStatus": paymentStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
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
    sessions: json["sessions"] == null ? [] : List<String>.from(json["sessions"]!.map((x) => x)),
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
    "homeAddress": homeAddress,
    "age": age,
    "region": region,
    "nationality": nationality,
    "gender": gender,
    "role": role,
    "sessions": sessions == null ? [] : List<dynamic>.from(sessions!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };
}
