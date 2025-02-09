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
  List<FileElement>? files;
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
  });

  factory Specialist.fromJson(Map<String, dynamic> json) => Specialist(
    files: json["files"] != null
        ? (json["files"] as List<dynamic>)
        .map((item) => FileElement.fromJson(item as Map<String, dynamic>))
        .toList()
        : [],
    specialties: json["specialties"] != null ? Specialties.fromJson(json["specialties"]) : Specialties(),
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
  );

  Map<String, dynamic> toJson() => {
    "files": files?.map((x) => x.toJson()).toList(),
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
  };
}

class FileElement {
  dynamic? idOrPassport;
  dynamic? id;

  FileElement({
    this.idOrPassport,
    this.id,
  });

  factory FileElement.fromJson(Map<dynamic, dynamic> json) => FileElement(
    idOrPassport: json["idOrPassport"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "idOrPassport": idOrPassport,
    "_id": id,
  };
}

class Specialties {
  List<dynamic>? psychologicalDisorders;
  List<dynamic>? mentalHealth;
  List<dynamic>? physicalHealth;
  List<dynamic>? skillDevelopment;

  Specialties({
    this.psychologicalDisorders,
    this.mentalHealth,
    this.physicalHealth,
    this.skillDevelopment,
  });

  factory Specialties.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return Specialties(
        psychologicalDisorders: json["psychologicalDisorders"] is List
            ? List<dynamic>.from(json["psychologicalDisorders"])
            : [],
        mentalHealth: json["mentalHealth"] is List ? List<dynamic>.from(json["mentalHealth"]) : [],
        physicalHealth: json["physicalHealth"] is List ? List<dynamic>.from(json["physicalHealth"]) : [],
        skillDevelopment: json["skillDevelopment"] is List ? List<dynamic>.from(json["skillDevelopment"]) : [],
      );
    } else {
      return Specialties(); // Return an empty object if json is not a valid Map
    }
  }

  Map<String, dynamic> toJson() => {
    "psychologicalDisorders": psychologicalDisorders ?? [],
    "mentalHealth": mentalHealth ?? [],
    "physicalHealth": physicalHealth ?? [],
    "skillDevelopment": skillDevelopment ?? [],
  };
}
