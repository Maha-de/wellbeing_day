// To parse this JSON data, do
//
//     final treatmentProgramsModel = treatmentProgramsModelFromJson(jsonString);

import 'dart:convert';

TreatmentProgramsModel treatmentProgramsModelFromJson(String str) => TreatmentProgramsModel.fromJson(json.decode(str));

String treatmentProgramsModelToJson(TreatmentProgramsModel data) => json.encode(data.toJson());

class TreatmentProgramsModel {
  List<Program>? programs;

  TreatmentProgramsModel({
    this.programs,
  });

  factory TreatmentProgramsModel.fromJson(Map<String, dynamic> json) => TreatmentProgramsModel(
    programs: json["programs"] == null ? [] : List<Program>.from(json["programs"]!.map((x) => Program.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "programs": programs == null ? [] : List<dynamic>.from(programs!.map((x) => x.toJson())),
  };
}

class Program {
  String? id;
  String? name;
  String? importance;
  String? treatmentPlan;
  String? goals;
  List<String>? stages;
  List<String>? techniques;
  List<String>? skillTraining;
  dynamic sessions;
  String? beneficiary;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Program({
    this.id,
    this.name,
    this.importance,
    this.treatmentPlan,
    this.goals,
    this.stages,
    this.techniques,
    this.skillTraining,
    this.sessions,
    this.beneficiary,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Program.fromJson(Map<String, dynamic> json) => Program(
    id: json["_id"],
    name: json["name"],
    importance: json["importance"],
    treatmentPlan: json["treatmentPlan"],
    goals: json["goals"],
    stages: json["stages"] == null ? [] : List<String>.from(json["stages"]!.map((x) => x)),
    techniques: json["techniques"] == null ? [] : List<String>.from(json["techniques"]!.map((x) => x)),
    skillTraining: json["skillTraining"] == null ? [] : List<String>.from(json["skillTraining"]!.map((x) => x)),
    sessions: json["sessions"],
    beneficiary: json["beneficiary"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "importance": importance,
    "treatmentPlan": treatmentPlan,
    "goals": goals,
    "stages": stages == null ? [] : List<dynamic>.from(stages!.map((x) => x)),
    "techniques": techniques == null ? [] : List<dynamic>.from(techniques!.map((x) => x)),
    "skillTraining": skillTraining == null ? [] : List<dynamic>.from(skillTraining!.map((x) => x)),
    "sessions": sessions,
    "beneficiary": beneficiary,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
