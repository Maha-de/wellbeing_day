// To parse this JSON data, do
//
//     final beneficiaryUpComingSessionsModel = beneficiaryUpComingSessionsModelFromJson(jsonString);

import 'dart:convert';

BeneficiaryUpComingSessionsModel beneficiaryUpComingSessionsModelFromJson(String str) => BeneficiaryUpComingSessionsModel.fromJson(json.decode(str));

String beneficiaryUpComingSessionsModelToJson(BeneficiaryUpComingSessionsModel data) => json.encode(data.toJson());

class BeneficiaryUpComingSessionsModel {
  List<UpcomingSession>? upcomingSessions;

  BeneficiaryUpComingSessionsModel({
    this.upcomingSessions,
  });

  factory BeneficiaryUpComingSessionsModel.fromJson(Map<String, dynamic> json) => BeneficiaryUpComingSessionsModel(
    upcomingSessions: json["upcomingSessions"] == null ? [] : List<UpcomingSession>.from(json["upcomingSessions"]!.map((x) => UpcomingSession.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "upcomingSessions": upcomingSessions == null ? [] : List<dynamic>.from(upcomingSessions!.map((x) => x.toJson())),
  };
}

class UpcomingSession {
  String? id;
  DateTime? sessionDate;
  String? specialist;

  UpcomingSession({
    this.id,
    this.sessionDate,
    this.specialist,
  });

  factory UpcomingSession.fromJson(Map<String, dynamic> json) => UpcomingSession(
    id: json["_id"],
    sessionDate: json["sessionDate"] == null ? null : DateTime.parse(json["sessionDate"]),
    specialist: json["specialist"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sessionDate": sessionDate?.toIso8601String(),
    "specialist": specialist,
  };
}
