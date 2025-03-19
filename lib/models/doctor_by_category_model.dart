// To parse this JSON data, do
//
//     final doctorByCategoryModel = doctorByCategoryModelFromJson(jsonString);

import 'dart:convert';

DoctorByCategoryModel doctorByCategoryModelFromJson(String str) => DoctorByCategoryModel.fromJson(json.decode(str));

String doctorByCategoryModelToJson(DoctorByCategoryModel data) => json.encode(data.toJson());

class DoctorByCategoryModel {
  String? message;
  List<Specialist>? specialists;

  DoctorByCategoryModel({
    this.message,
    this.specialists,
  });

  factory DoctorByCategoryModel.fromJson(Map<String, dynamic> json) => DoctorByCategoryModel(
    message: json["message"],
    specialists: json["specialists"] == null ? [] : List<Specialist>.from(json["specialists"]!.map((x) => Specialist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "specialists": specialists == null ? [] : List<dynamic>.from(specialists!.map((x) => x.toJson())),
  };
}

class Specialist {
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
  bool? isAvailable;
  bool? isConfirmed;
  List<String>? sessions;
  String? imageUrl;
  List<String>? language;
  List<String>? reviews;

  Specialist({
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
    this.isAvailable,
    this.isConfirmed,
    this.sessions,
    this.imageUrl,
    this.language,
    this.reviews,
  });

  factory Specialist.fromJson(Map<String, dynamic> json) => Specialist(
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
    isAvailable: json["isAvailable"],
    isConfirmed: json["isConfirmed"],
    sessions: json["sessions"] == null ? [] : List<String>.from(json["sessions"]!.map((x) => x)),
    imageUrl: json["imageUrl"],
    language: json["language"] == null ? [] : List<String>.from(json["language"]!.map((x) => x)),
    reviews: json["reviews"] == null ? [] : List<String>.from(json["reviews"]!.map((x) => x)),
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
    "isAvailable": isAvailable,
    "isConfirmed": isConfirmed,
    "sessions": sessions == null ? [] : List<dynamic>.from(sessions!.map((x) => x)),
    "imageUrl": imageUrl,
    "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
  };
}

class Specialties {
  List<String>? mentalHealth;
  List<String>? physicalHealth;
  List<String>? psychologicalDisorders;
  List<String>? skillsDevelopment;
  List<dynamic>? skillDevelopment;

  Specialties({
    this.mentalHealth,
    this.physicalHealth,
    this.psychologicalDisorders,
    this.skillsDevelopment,
    this.skillDevelopment,
  });

  factory Specialties.fromJson(Map<String, dynamic> json) => Specialties(
    mentalHealth: json["mentalHealth"] == null ? [] : List<String>.from(json["mentalHealth"]!.map((x) => x)),
    physicalHealth: json["physicalHealth"] == null ? [] : List<String>.from(json["physicalHealth"]!.map((x) => x)),
    psychologicalDisorders: json["psychologicalDisorders"] == null ? [] : List<String>.from(json["psychologicalDisorders"]!.map((x) => x)),
    skillsDevelopment: json["skillsDevelopment"] == null ? [] : List<String>.from(json["skillsDevelopment"]!.map((x) => x)),
    skillDevelopment: json["skillDevelopment"] == null ? [] : List<dynamic>.from(json["skillDevelopment"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "mentalHealth": mentalHealth == null ? [] : List<dynamic>.from(mentalHealth!.map((x) => x)),
    "physicalHealth": physicalHealth == null ? [] : List<dynamic>.from(physicalHealth!.map((x) => x)),
    "psychologicalDisorders": psychologicalDisorders == null ? [] : List<dynamic>.from(psychologicalDisorders!.map((x) => x)),
    "skillsDevelopment": skillsDevelopment == null ? [] : List<dynamic>.from(skillsDevelopment!.map((x) => x)),
    "skillDevelopment": skillDevelopment == null ? [] : List<dynamic>.from(skillDevelopment!.map((x) => x)),
  };
}
