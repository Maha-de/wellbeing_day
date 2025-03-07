// To parse this JSON data, do
//
//     final subSubCategoryModel = subSubCategoryModelFromJson(jsonString);

import 'dart:convert';

List<String> subSubCategoryModelFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String subSubCategoryModelToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
