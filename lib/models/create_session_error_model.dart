// To parse this JSON data, do
//
//     final createSessionErrorModel = createSessionErrorModelFromJson(jsonString);

import 'dart:convert';

CreateSessionErrorModel createSessionErrorModelFromJson(String str) => CreateSessionErrorModel.fromJson(json.decode(str));

String createSessionErrorModelToJson(CreateSessionErrorModel data) => json.encode(data.toJson());

class CreateSessionErrorModel {
  String? error;

  CreateSessionErrorModel({
    this.error,
  });

  factory CreateSessionErrorModel.fromJson(Map<String, dynamic> json) => CreateSessionErrorModel(
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}
