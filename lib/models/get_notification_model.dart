// To parse this JSON data, do
//
//     final getNotificationModel = getNotificationModelFromJson(jsonString);

import 'dart:convert';

List<GetNotificationModel> getNotificationModelFromJson(String str) => List<GetNotificationModel>.from(json.decode(str).map((x) => GetNotificationModel.fromJson(x)));

String getNotificationModelToJson(List<GetNotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetNotificationModel {
  String? id;
  String? message;
  String? senderId;
  String? userId;
  String? meetingLink;
  bool? isRead;
  String? createdAt;
  int? v;

  GetNotificationModel({
    this.id,
    this.message,
    this.senderId,
    this.userId,
    this.meetingLink,
    this.isRead,
    this.createdAt,
    this.v,
  });

  factory GetNotificationModel.fromJson(Map<String, dynamic> json) => GetNotificationModel(
    id: json["_id"],
    message: json["message"],
    senderId: json["senderId"],
    userId: json["userId"],
    meetingLink: json["meetingLink"],
    isRead: json["isRead"],
    createdAt: json["createdAt"] ,
    v: json["__v"]??0,
  );


  Map<String, dynamic> toJson() => {
    "_id": id,
    "message": message,
    "senderId": senderId,
    "userId": userId,
    "meetingLink": meetingLink,
    "isRead": isRead,
    "createdAt": createdAt,
    "__v": v,
  };
}
