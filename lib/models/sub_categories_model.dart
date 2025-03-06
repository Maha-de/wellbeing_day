// To parse this JSON data, do
//
//     final getSubCategoriesModel = getSubCategoriesModelFromJson(jsonString);

import 'dart:convert';

List<GetSubCategoriesModel> getSubCategoriesModelFromJson(String str) => List<GetSubCategoriesModel>.from(json.decode(str).map((x) => GetSubCategoriesModel.fromJson(x)));

String getSubCategoriesModelToJson(List<GetSubCategoriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSubCategoriesModel {
  String? name;
  List<String>? subcategory;

  GetSubCategoriesModel({
    this.name,
    this.subcategory,
  });

  factory GetSubCategoriesModel.fromJson(Map<String, dynamic> json) => GetSubCategoriesModel(
    name: json["name"],
    subcategory: json["subcategory"] == null ? [] : List<String>.from(json["subcategory"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "subcategory": subcategory == null ? [] : List<dynamic>.from(subcategory!.map((x) => x)),
  };
}
