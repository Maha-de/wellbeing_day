
import 'dart:convert';

ProgramsModel programsFromJson(String str) => ProgramsModel.fromJson(json.decode(str));

String programsToJson(ProgramsModel data) => json.encode(data.toJson());

class ProgramsModel {
  // List<Program> programs;
  Program program;

  ProgramsModel({
     // required this.programs,
    required this.program
  });

  factory ProgramsModel.fromJson(Map<String, dynamic> json) => ProgramsModel(
    // programs: List<Program>.from(json["programs"].map((x) => ProgramsModel.fromJson(x))),
    program: Program.fromJson(json["programs"]),

  );

  Map<String, dynamic> toJson() => {
    // "programs": List<dynamic>.from(programs.map((x) => x.toJson())),
    "programs": program,
  };
}

class Program {
  String id;
  String name;
  String importance;
  String treatmentPlan;
  String goals;
  List<String> stages;
  List<String> techniques;
  List<String> skillTraining;
  List<dynamic> sessions;
  String beneficiary;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Program({
    required this.id,
    required this.name,
    required this.importance,
    required this.treatmentPlan,
    required this.goals,
    required this.stages,
    required this.techniques,
    required this.skillTraining,
    required this.sessions,
    required this.beneficiary,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Program.fromJson(Map<String, dynamic> json) => Program(
    id: json["_id"],
    name: json["name"],
    importance: json["importance"],
    treatmentPlan: json["treatmentPlan"],
    goals: json["goals"],
    stages: List<String>.from(json["stages"].map((x) => x)),
    techniques: List<String>.from(json["techniques"].map((x) => x)),
    skillTraining: List<String>.from(json["skillTraining"].map((x) => x)),
    sessions: List<dynamic>.from(json["sessions"].map((x) => x)),
    beneficiary: json["beneficiary"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "importance": importance,
    "treatmentPlan": treatmentPlan,
    "goals": goals,
    "stages": List<dynamic>.from(stages.map((x) => x)),
    "techniques": List<dynamic>.from(techniques.map((x) => x)),
    "skillTraining": List<dynamic>.from(skillTraining.map((x) => x)),
    "sessions": List<dynamic>.from(sessions.map((x) => x)),
    "beneficiary": beneficiary,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
