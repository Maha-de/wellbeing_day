// To parse this JSON data, do
//
//     final doctorByCategoryModel = doctorByCategoryModelFromJson(jsonString);

import 'dart:convert';

DoctorByCategoryModel doctorByCategoryModelFromJson(String str) => DoctorByCategoryModel.fromJson(json.decode(str));

String doctorByCategoryModelToJson(DoctorByCategoryModel data) => json.encode(data.toJson());

class DoctorByCategoryModel {
  String? message;
  List<Specialists>? specialists;

  DoctorByCategoryModel({
    this.message,
    this.specialists,
  });

  factory DoctorByCategoryModel.fromJson(Map<String, dynamic> json) => DoctorByCategoryModel(
    message: json["message"],
    specialists: json["specialists"] == null ? [] : List<Specialists>.from(json["specialists"]!.map((x) => Specialists.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "specialists": specialists == null ? [] : List<dynamic>.from(specialists!.map((x) => x.toJson())),
  };
}

class Specialists {
  Specialties? specialties;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  String? nationality;
  String? work;
  String? workAddress;
  String? homeAddress;
  String? bio;
  int? sessionPrice;
  int? yearsExperience;
  int? sessionDuration;
  int? v;
  List<String>? availableSlots;

  Specialists({
    this.specialties,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.nationality,
    this.work,
    this.workAddress,
    this.homeAddress,
    this.bio,
    this.sessionPrice,
    this.yearsExperience,
    this.sessionDuration,
    this.v,
    this.availableSlots,
  });

  factory Specialists.fromJson(Map<String, dynamic> json) => Specialists(
    specialties: json["specialties"] == null ? null : Specialties.fromJson(json["specialties"]),
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    nationality: json["nationality"],
    work: json["work"],
    workAddress: json["workAddress"],
    homeAddress: json["homeAddress"],
    bio: json["bio"],
    sessionPrice: json["sessionPrice"],
    yearsExperience: json["yearsExperience"],
    sessionDuration: json["sessionDuration"],
    v: json["__v"],
    availableSlots: json["availableSlots"] == null ? [] : List<String>.from(json["availableSlots"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "specialties": specialties?.toJson(),
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "phone": phone,
    "nationality": nationality,
    "work": work,
    "workAddress": workAddress,
    "homeAddress": homeAddress,
    "bio": bio,
    "sessionPrice": sessionPrice,
    "yearsExperience": yearsExperience,
    "sessionDuration": sessionDuration,
    "__v": v,
    "availableSlots": availableSlots == null ? [] : List<dynamic>.from(availableSlots!.map((x) => x)),
  };
}

class Specialties {
  List<String>? psychologicalDisorders;
  List<String>? mentalHealth;
  List<String>? physicalHealth;
  List<String>? skillDevelopment;

  Specialties({
    this.psychologicalDisorders,
    this.mentalHealth,
    this.physicalHealth,
    this.skillDevelopment,
  });

  factory Specialties.fromJson(Map<String, dynamic> json) => Specialties(
    psychologicalDisorders: json["psychologicalDisorders"] == null ? [] : List<String>.from(json["psychologicalDisorders"]!.map((x) => x)),
    mentalHealth: json["mentalHealth"] == null ? [] : List<String>.from(json["mentalHealth"]!.map((x) => x)),
    physicalHealth: json["physicalHealth"] == null ? [] : List<String>.from(json["physicalHealth"]!.map((x) => x)),
    skillDevelopment: json["skillDevelopment"] == null ? [] : List<String>.from(json["skillDevelopment"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "psychologicalDisorders": psychologicalDisorders == null ? [] : List<dynamic>.from(psychologicalDisorders!.map((x) => x)),
    "mentalHealth": mentalHealth == null ? [] : List<dynamic>.from(mentalHealth!.map((x) => x)),
    "physicalHealth": physicalHealth == null ? [] : List<dynamic>.from(physicalHealth!.map((x) => x)),
    "skillDevelopment": skillDevelopment == null ? [] : List<dynamic>.from(skillDevelopment!.map((x) => x)),
  };
}
