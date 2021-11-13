
import 'dart:convert';


class Smu {
  int? id;
  String? smu;
  String? nama_barang;
  String? nama_agen;
  String? no_hp;
  String? alamat;
  String? status;
  String? koli;
  int? berat_awal;
  int? berat_recharge_cargo;
  int? berat_total;
  String? checker;
  String? project_id;
  bool? check;
  String? warehouse;
  String? maskapai;
  String? tanggal_penerbangan;
  String? createdAt;
  String? updatedAt;

  Smu({
    required this.id,
    required this.smu,
    required this.nama_barang,
    required this.nama_agen,
    required this.no_hp,
    required this.alamat,
    required this.status,
    required this.koli,
    required this.berat_awal,
    required this.berat_recharge_cargo,
    required this.berat_total,
    required this.checker,
    required this.project_id,
    required this.check,
    required this.warehouse,
    required this.maskapai,
    required this.tanggal_penerbangan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Smu.fromJson(Map<String, dynamic> json)  {
    return Smu(
      id: json['id'],
      smu: json['smu'],
      nama_barang: json['nama_barang'],
      nama_agen: json['nama_agen'],
      no_hp: json['no_hp'],
      alamat: json['alamat'],
      status: json['status'],
      koli: json['koli'],
      berat_awal: json['berat_awal'],
      berat_recharge_cargo: json['berat_recharge_cargo'],
      berat_total: json['berat_total'],
      checker: json['checker'],
      project_id: json['project_id'],
      check: json['check'],
      warehouse: json['warehouse'],
      maskapai: json['maskapai'],
      tanggal_penerbangan: json['tanggal_penerbangan'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'smu':smu,
      'nama_barang':nama_barang,
      'nama_agen':nama_agen,
      'no_hp':no_hp,
      'alamat':alamat,
      'status':status,
      'koli':koli,
      'berat_awal':berat_awal,
      'berat_recharge_cargo':berat_recharge_cargo,
      'berat_total':berat_total,
      'checker':checker,
      'project_id':project_id,
      'check':check,
      'warehouse':warehouse,
      'maskapai':maskapai,
      'tanggal_penerbangan':tanggal_penerbangan,
      'createdAt':createdAt,
      'updatedAt':updatedAt,
    };
  }

  @override
  String toString() {
    return 'Smu{id:$id, smu:$smu, nama_barang:$nama_barang, nama_agen:$nama_agen, no_hp:$no_hp, alamat:$alamat, status:$status, koli:$koli, berat_awal:$berat_awal, berat_recharge_cargo:$berat_recharge_cargo, berat_total:$berat_total, checker:$checker, project_id:$project_id, check:$check, warehouse:$warehouse, maskapai:$maskapai, tanggal_penerbangan:$tanggal_penerbangan, createdAt:$createdAt, updatedAt:$updatedAt}';
  }
}
List<Smu> smuFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Smu>.from(data.map((item) => Smu.fromJson(item)));
}

String smuToJson(Smu data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}