// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    this.data,
  });

  List<StepData>? data;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    data: List<StepData>.from(json["data"].map((x) => StepData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StepData {
  StepData({
    this.title,
    this.description,
  });

  String? title;
  String? description;

  factory StepData.fromJson(Map<String, dynamic> json) => StepData(
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
  };
}
