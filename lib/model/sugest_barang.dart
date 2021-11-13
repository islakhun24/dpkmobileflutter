import 'dart:convert';

import 'package:flutter/services.dart';

class SuggestBarang {
  int id;
  String nama_barang;
  String kode_barang;
  String createdAt;
  String updatedAt;
  SuggestBarang({
    required this.id,
    required this.nama_barang,
    required this.kode_barang,
    required this.createdAt,
    required this.updatedAt
  });

  factory SuggestBarang.fromJson(Map<String, dynamic> parsedJson) {
    return SuggestBarang(
        id: parsedJson['id'] as int,
        nama_barang: parsedJson['nama_barang'],
        kode_barang: parsedJson['kode_barang'],
        createdAt: parsedJson['createdAt'] as String,
        updatedAt: parsedJson['updatedAt'] as String
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'nama_barang':nama_barang,
      'kode_barang':kode_barang,
      'createdAt':createdAt,
      'updatedAt':updatedAt
    };
  }

  @override
  String toString() {
    return '$nama_barang';
  }
}
List<SuggestBarang> suggestFromJsonBarang(String jsonData) {
  final data = json.decode(jsonData);
  return List<SuggestBarang>.from(data.map((item) => SuggestBarang.fromJson(item)));
}

String notifToJson(SuggestBarang data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}