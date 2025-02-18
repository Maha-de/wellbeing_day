// To parse this JSON data, do
//
//     final deleteDoctorModel = deleteDoctorModelFromJson(jsonString);

import 'dart:convert';

DeleteDoctorModel deleteDoctorModelFromJson(String str) => DeleteDoctorModel.fromJson(json.decode(str));

String deleteDoctorModelToJson(DeleteDoctorModel data) => json.encode(data.toJson());

class DeleteDoctorModel {
  String? message;
  Data? data;

  DeleteDoctorModel({
    this.message,
    this.data,
  });

  factory DeleteDoctorModel.fromJson(Map<String, dynamic> json) => DeleteDoctorModel(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Files? files;
  Specialties? specialties;
  bool? isConfirmed;
  bool? isAvailable;
  List<dynamic>? sessions;
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
  String? imageUrl;

  Data({
    this.files,
    this.specialties,
    this.isConfirmed,
    this.isAvailable,
    this.sessions,
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
    this.imageUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    files: json["files"] == null ? null : Files.fromJson(json["files"]),
    specialties: json["specialties"] == null ? null : Specialties.fromJson(json["specialties"]),
    isConfirmed: json["isConfirmed"],
    isAvailable: json["isAvailable"],
    sessions: json["sessions"] == null ? [] : List<dynamic>.from(json["sessions"]!.map((x) => x)),
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
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "files": files?.toJson(),
    "specialties": specialties?.toJson(),
    "isConfirmed": isConfirmed,
    "isAvailable": isAvailable,
    "sessions": sessions == null ? [] : List<dynamic>.from(sessions!.map((x) => x)),
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
    "imageUrl": imageUrl,
  };
}

class Files {
  List<dynamic>? certificates;

  Files({
    this.certificates,
  });

  factory Files.fromJson(Map<String, dynamic> json) => Files(
    certificates: json["certificates"] == null ? [] : List<dynamic>.from(json["certificates"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "certificates": certificates == null ? [] : List<dynamic>.from(certificates!.map((x) => x)),
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
