
import 'dart:convert';

SpecialistModel specialistModelFromJson(String str) => SpecialistModel.fromJson(json.decode(str));

String specialistModelToJson(SpecialistModel data) => json.encode(data.toJson());

class SpecialistModel {
  String message;
  Specialist specialist;

  SpecialistModel({
    required this.message,
    required this.specialist,
  });

  factory SpecialistModel.fromJson(Map<String, dynamic> json) => SpecialistModel(
    message: json["message"] ?? "",
    specialist: Specialist.fromJson(json["specialist"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "specialist": specialist.toJson(),
  };
}

class Specialist {
  Files files;
  Specialties specialties;
  String id;
  String firstName;
  String lastName;
  String email;
  String password;
  String phone;
  String nationality;
  String work;
  String workAddress;
  String homeAddress;
  String bio;
  int sessionPrice;
  int yearsExperience;
  int sessionDuration;
  int v;
  List<String> availableSlots;

  Specialist({
    required this.files,
    required this.specialties,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.nationality,
    required this.work,
    required this.workAddress,
    required this.homeAddress,
    required this.bio,
    required this.sessionPrice,
    required this.yearsExperience,
    required this.sessionDuration,
    required this.v,
    required this.availableSlots,
  });

  factory Specialist.fromJson(Map<String, dynamic> json) => Specialist(
    files: Files.fromJson(json["files"] ?? {}),
    specialties: Specialties.fromJson(json["specialties"] ?? {}),
    id: json["_id"] ?? "",
    firstName: json["firstName"] ?? "",
    lastName: json["lastName"] ?? "",
    email: json["email"] ?? "",
    password: json["password"] ?? "",
    phone: json["phone"] ?? "",
    nationality: json["nationality"] ?? "",
    work: json["work"] ?? "",
    workAddress: json["workAddress"] ?? "",
    homeAddress: json["homeAddress"] ?? "",
    bio: json["bio"] ?? "",
    sessionPrice: json["sessionPrice"] ?? 0,
    yearsExperience: json["yearsExperience"] ?? 0,
    sessionDuration: json["sessionDuration"] ?? 0,
    v: json["__v"] ?? 0,
    availableSlots: (json["availableSlots"] as List?)?.map((x) => x.toString()).toList() ?? [],
  );

  Map<String, dynamic> toJson() => {
    "files": files.toJson(),
    "specialties": specialties.toJson(),
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
    "availableSlots": List<dynamic>.from(availableSlots.map((x) => x)),
  };
}

class Files {
  List<dynamic> certificates;

  Files({
    required this.certificates,
  });

  factory Files.fromJson(Map<String, dynamic> json) => Files(
    certificates: (json["certificates"] as List?)?.map((x) => x).toList() ?? [],
  );

  Map<String, dynamic> toJson() => {
    "certificates": List<dynamic>.from(certificates.map((x) => x)),
  };
}

class Specialties {
  List<String> psychologicalDisorders;
  List<String> mentalHealth;
  List<String> physicalHealth;
  List<String> skillDevelopment;

  Specialties({
    required this.psychologicalDisorders,
    required this.mentalHealth,
    required this.physicalHealth,
    required this.skillDevelopment,
  });

  factory Specialties.fromJson(Map<String, dynamic> json) => Specialties(
    psychologicalDisorders: (json["psychologicalDisorders"] as List?)?.map((x) => x.toString()).toList() ?? [],
    mentalHealth: (json["mentalHealth"] as List?)?.map((x) => x.toString()).toList() ?? [],
    physicalHealth: (json["physicalHealth"] as List?)?.map((x) => x.toString()).toList() ?? [],
    skillDevelopment: (json["skillDevelopment"] as List?)?.map((x) => x.toString()).toList() ?? [],
  );

  Map<String, dynamic> toJson() => {
    "psychologicalDisorders": List<dynamic>.from(psychologicalDisorders.map((x) => x)),
    "mentalHealth": List<dynamic>.from(mentalHealth.map((x) => x)),
    "physicalHealth": List<dynamic>.from(physicalHealth.map((x) => x)),
    "skillDevelopment": List<dynamic>.from(skillDevelopment.map((x) => x)),
  };
}




