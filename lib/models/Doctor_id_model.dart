// To parse this JSON data, do
//
//     final doctorByIdModel = doctorByIdModelFromJson(jsonString);

import 'dart:convert';

DoctorByIdModel doctorByIdModelFromJson(String str) => DoctorByIdModel.fromJson(json.decode(str));

String doctorByIdModelToJson(DoctorByIdModel data) => json.encode(data.toJson());

class DoctorByIdModel {
  String? message;
  Specialist? specialist;

  DoctorByIdModel({
    this.message,
    this.specialist,
  });

  factory DoctorByIdModel.fromJson(Map<String, dynamic> json) => DoctorByIdModel(
    message: json["message"],
    specialist: json["specialist"] == null ? null : Specialist.fromJson(json["specialist"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "specialist": specialist?.toJson(),
  };
}

class Specialist {
  Files? files;
  Specialties? specialties;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
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
  String? imageUrl;
  List<String>? availableSlots;
  bool? isAvailable;
  bool? isConfirmed;
  List<String>? sessions;

  Specialist({
    this.files,
    this.specialties,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
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
    this.imageUrl,
    this.availableSlots,
    this.isAvailable,
    this.isConfirmed,
    this.sessions,
  });

  factory Specialist.fromJson(Map<String, dynamic> json) => Specialist(
    files: json["files"] == null ? null : Files.fromJson(json["files"]),
    specialties: json["specialties"] == null ? null : Specialties.fromJson(json["specialties"]),
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
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
    imageUrl: json["imageUrl"],
    availableSlots: json["availableSlots"] == null ? [] : List<String>.from(json["availableSlots"]!.map((x) => x)),
    isAvailable: json["isAvailable"],
    isConfirmed: json["isConfirmed"],
    sessions: json["sessions"] == null ? [] : List<String>.from(json["sessions"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "files": files?.toJson(),
    "specialties": specialties?.toJson(),
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
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
    "imageUrl": imageUrl,
    "availableSlots": availableSlots == null ? [] : List<dynamic>.from(availableSlots!.map((x) => x)),
    "isAvailable": isAvailable,
    "isConfirmed": isConfirmed,
    "sessions": sessions == null ? [] : List<dynamic>.from(sessions!.map((x) => x)),
  };
}

class Files {
  String? idOrPassport;
  String? resume;
  List<String>? certificates;
  String? ministryLicense;
  String? associationMembership;

  Files({
    this.idOrPassport,
    this.resume,
    this.certificates,
    this.ministryLicense,
    this.associationMembership,
  });

  factory Files.fromJson(Map<String, dynamic> json) => Files(
    idOrPassport: json["idOrPassport"],
    resume: json["resume"],
    certificates: json["certificates"] == null ? [] : List<String>.from(json["certificates"]!.map((x) => x)),
    ministryLicense: json["ministryLicense"],
    associationMembership: json["associationMembership"],
  );

  Map<String, dynamic> toJson() => {
    "idOrPassport": idOrPassport,
    "resume": resume,
    "certificates": certificates == null ? [] : List<dynamic>.from(certificates!.map((x) => x)),
    "ministryLicense": ministryLicense,
    "associationMembership": associationMembership,
  };
}

class Specialties {
  List<dynamic>? mentalHealth;
  List<dynamic>? physicalHealth;
  List<dynamic>? psychologicalDisorders;
  List<dynamic>? skillDevelopment;

  Specialties({
    this.mentalHealth,
    this.physicalHealth,
    this.psychologicalDisorders,
    this.skillDevelopment,
  });

  factory Specialties.fromJson(Map<String, dynamic> json) => Specialties(
    mentalHealth: json["mentalHealth"] == null ? [] : List<dynamic>.from(json["mentalHealth"]!.map((x) => x)),
    physicalHealth: json["physicalHealth"] == null ? [] : List<dynamic>.from(json["physicalHealth"]!.map((x) => x)),
    psychologicalDisorders: json["psychologicalDisorders"] == null ? [] : List<dynamic>.from(json["psychologicalDisorders"]!.map((x) => x)),
    skillDevelopment: json["skillDevelopment"] == null ? [] : List<dynamic>.from(json["skillDevelopment"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "mentalHealth": mentalHealth == null ? [] : List<dynamic>.from(mentalHealth!.map((x) => x)),
    "physicalHealth": physicalHealth == null ? [] : List<dynamic>.from(physicalHealth!.map((x) => x)),
    "psychologicalDisorders": psychologicalDisorders == null ? [] : List<dynamic>.from(psychologicalDisorders!.map((x) => x)),
    "skillDevelopment": skillDevelopment == null ? [] : List<dynamic>.from(skillDevelopment!.map((x) => x)),
  };
}
