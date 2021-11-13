import 'dart:convert';

import 'package:flutter/services.dart';

class SuggestAgen {
  int? id;
  String? customer;
  String? nohp;
  String? alamat;
  String? company_name;
  String? createdAt;
  String? updatedAt;
  SuggestAgen({
    required this.id,
    required this.customer,
    required this.nohp,
    required this.alamat,
    required this.company_name,
    required this.createdAt,
    required this.updatedAt
  });

  factory SuggestAgen.fromJson(Map<String, dynamic> parsedJson) {
    return SuggestAgen(
        id: parsedJson['id'],
        customer: parsedJson['customer'],
        nohp: parsedJson['nohp'],
        alamat: parsedJson['alamat'],
        company_name: parsedJson['company_name'],
        createdAt: parsedJson['createdAt'] as String,
        updatedAt: parsedJson['updatedAt'] as String
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'customer':customer,
      'nohp':nohp,
      'alamat':alamat,
      'company_name':company_name,
      'createdAt':createdAt,
      'updatedAt':updatedAt
    };
  }

  @override
  String toString() {
    return 'Ok';
  }
}
List<SuggestAgen> suggesAgenFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<SuggestAgen>.from(data.map((item) => SuggestAgen.fromJson(item)));
}

String notifToJson(SuggestAgen data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}