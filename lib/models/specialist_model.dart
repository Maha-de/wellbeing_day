// To parse this JSON data, do
//
//     final specialistModel = specialistModelFromJson(jsonString);

import 'dart:convert';

SpecialistModel specialistModelFromJson(String str) => SpecialistModel.fromJson(json.decode(str));

String specialistModelToJson(SpecialistModel data) => json.encode(data.toJson());

class SpecialistModel {
  String? message;
  List<Specialist>? specialists;

  SpecialistModel({
    this.message,
    this.specialists,
  });

  factory SpecialistModel.fromJson(Map<String, dynamic> json) => SpecialistModel(
    message: json["message"],
    specialists: json["specialists"] == null ? [] : List<Specialist>.from(json["specialists"]!.map((x) => Specialist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "specialists": specialists == null ? [] : List<dynamic>.from(specialists!.map((x) => x.toJson())),
  };
}

class Specialist {
  dynamic files;
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
  String? idOrPassword;

  Specialist({
    this.files,
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
    this.idOrPassword,
  });

  factory Specialist.fromJson(Map<String, dynamic> json) => Specialist(
    files: json["files"],
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
    idOrPassword: json["idOrPassword"],
  );

  Map<String, dynamic> toJson() => {
    "files": files,
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
    "idOrPassword": idOrPassword,
  };
}

class FileElement {
  String? idOrPassport;
  String? id;

  FileElement({
    this.idOrPassport,
    this.id,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
    idOrPassport: json["idOrPassport"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "idOrPassport": idOrPassport,
    "_id": id,
  };
}

class FilesClass {
  List<String>? certificates;
  String? idOrPassport;
  String? resume;
  String? ministryLicense;
  String? associationMembership;

  FilesClass({
    this.certificates,
    this.idOrPassport,
    this.resume,
    this.ministryLicense,
    this.associationMembership,
  });

  factory FilesClass.fromJson(Map<String, dynamic> json) => FilesClass(
    certificates: json["certificates"] == null ? [] : List<String>.from(json["certificates"]!.map((x) => x)),
    idOrPassport: json["idOrPassport"],
    resume: json["resume"],
    ministryLicense: json["ministryLicense"],
    associationMembership: json["associationMembership"],
  );

  Map<String, dynamic> toJson() => {
    "certificates": certificates == null ? [] : List<dynamic>.from(certificates!.map((x) => x)),
    "idOrPassport": idOrPassport,
    "resume": resume,
    "ministryLicense": ministryLicense,
    "associationMembership": associationMembership,
  };
}

class Specialties {
  List<String>? psychologicalDisorders;
  List<dynamic>? mentalHealth;
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
    mentalHealth: json["mentalHealth"] == null ? [] : List<dynamic>.from(json["mentalHealth"]!.map((x) => x)),
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


