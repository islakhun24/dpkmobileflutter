import 'dart:convert';

import 'package:flutter/services.dart';

class SuggestSmu {
  int id;
  String smu;
  String createdAt;
  String updatedAt;
  SuggestSmu({
    required this.id,
    required this.smu,
    required this.createdAt,
    required this.updatedAt
  });

  factory SuggestSmu.fromJson(Map<String, dynamic> parsedJson) {
    return SuggestSmu(
        id: parsedJson['id'] as int,
        smu: parsedJson['smu'],
        createdAt: parsedJson['createdAt'] as String,
        updatedAt: parsedJson['updatedAt'] as String
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'smu':smu,
      'createdAt':createdAt,
      'updatedAt':updatedAt
    };
  }

  @override
  String toString() {
    return '$smu';
  }
}
List<SuggestSmu> suggestFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<SuggestSmu>.from(data.map((item) => SuggestSmu.fromJson(item)));
}

String notifToJson(SuggestSmu data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}