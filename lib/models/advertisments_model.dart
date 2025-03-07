// To parse this JSON data, do
//
//     final advertismentsModel = advertismentsModelFromJson(jsonString);

import 'dart:convert';

AdvertismentsModel advertismentsModelFromJson(String str) => AdvertismentsModel.fromJson(json.decode(str));

String advertismentsModelToJson(AdvertismentsModel data) => json.encode(data.toJson());

class AdvertismentsModel {
  String? message;
  List<Adv>? advs;

  AdvertismentsModel({
    this.message,
    this.advs,
  });

  factory AdvertismentsModel.fromJson(Map<String, dynamic> json) => AdvertismentsModel(
    message: json["message"],
    advs: json["advs"] == null ? [] : List<Adv>.from(json["advs"]!.map((x) => Adv.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "advs": advs == null ? [] : List<dynamic>.from(advs!.map((x) => x.toJson())),
  };
}

class Adv {
  String? id;
  String? title;
  String? photo;
  String? type;
  int? v;
  DateTime? updatedAt;
  DateTime? createdAt;

  Adv({
    this.id,
    this.title,
    this.photo,
    this.type,
    this.v,
    this.updatedAt,
    this.createdAt,
  });

  factory Adv.fromJson(Map<String, dynamic> json) => Adv(
    id: json["_id"],
    title: json["title"],
    photo: json["photo"],
    type: json["type"],
    v: json["__v"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "photo": photo,
    "type": type,
    "__v": v,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };
}
