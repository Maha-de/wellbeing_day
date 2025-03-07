class SpecialistsResponse {
  final String? message;
  final List<Specialists>? items;
  final int? totalPages;
  final int? totalItems;
  final int? page;

  SpecialistsResponse({
    this.message,
    this.items,
    this.totalPages,
    this.totalItems,
    this.page,
  });

  factory SpecialistsResponse.fromJson(Map<String, dynamic> json) {
    return SpecialistsResponse(
      message: json['message'] as String?,
      items: (json['data'] as List<dynamic>?)
          ?.map((item) => Specialists.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalPages: json['totalPages'] as int?,
      totalItems: json['totalItems'] as int?,
      page: json['page'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': items?.map((item) => item.toJson()).toList(),
      'totalPages': totalPages,
      'totalItems': totalItems,
      'page': page,
    };
  }
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
  final String? imageUrl;
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
    this.imageUrl,
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
    imageUrl: json['imageUrl'],
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

class Files {
  final String? idOrPassport;
  final String? resume;
  final List<String>? certificates;
  final String? ministryLicense;
  final String? associationMembership;

  Files({
    this.idOrPassport,
    this.resume,
    this.certificates,
    this.ministryLicense,
    this.associationMembership,
  });

  factory Files.fromJson(Map<String, dynamic> json) {
    return Files(
      idOrPassport: json['idOrPassport'] as String?,
      resume: json['resume'] as String?,
      certificates: (json['certificates'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ministryLicense: json['ministryLicense'] as String?,
      associationMembership: json['associationMembership'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idOrPassport': idOrPassport,
      'resume': resume,
      'certificates': certificates,
      'ministryLicense': ministryLicense,
      'associationMembership': associationMembership,
    };
  }
}
