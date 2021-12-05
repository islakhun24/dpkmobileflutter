import 'package:dpkmobileflutter/model/smu.dart';

/// detail : {"id":20,"tanggal":"2021-09-10 22:09:27","no":"DO87676","no_polisi_kendaraan":"GH987","nama_pengemudi":"SUPRI","asal_tps":"PKD","kota_asal":"BTM","kota_tujuan":"MDN","selesai":3,"team":2,"createdAt":"2021-09-10 22:09:27","updatedAt":"2021-09-10 22:11:55"}
/// smu : [{"id":108,"smu":"126-04725","nama_barang":"GENERAL CARGO","nama_agen":"AGEN 1","no_hp":"0127319283","alamat":"BATAM","status":"CHECKER","koli":"1/3","berat_awal":200,"berat_recharge_cargo":10,"berat_total":190,"checker":3,"project_id":"20","check":true,"warehouse":"DBM","maskapai":"","tanggal_penerbangan":"0000-00-00","createdAt":"2021-09-10 22:10:05","updatedAt":"2021-12-01 13:36:34"}]
/// isi_kiriman : [{"nama_barang":"GENERAL CARGO"}]
/// nama_agen : [{"nama_agen":"AGEN 1"}]
/// data : {"id":108,"smu":"126-04725","nama_barang":"GENERAL CARGO","berat_total":"460","koli":3}
/// warehouses : [{"id":108,"smu":"126-04725","nama_barang":"GENERAL CARGO","nama_agen":"AGEN 1","no_hp":"0127319283","alamat":"BATAM","status":"CHECKER","koli":"1/3","berat_awal":200,"berat_recharge_cargo":10,"berat_total":190,"checker":3,"project_id":"20","check":true,"warehouse":"DBM","maskapai":"","tanggal_penerbangan":"0000-00-00","createdAt":"2021-09-10 22:10:05","updatedAt":"2021-12-01 13:36:34"}]

class DocumentResponse {
  DocumentResponse({
      Detail? detail, 
      List<Smu>? smu, 
      List<Isi_kiriman>? isiKiriman, 
      List<Nama_agen>? namaAgen, 
      Data? data, 
      List<Warehouses>? warehouses,}){
    _detail = detail;
    _smu = smu;
    _isiKiriman = isiKiriman;
    _namaAgen = namaAgen;
    _data = data;
    _warehouses = warehouses;
}

  DocumentResponse.fromJson(dynamic json) {
    _detail = json['detail'] != null ? Detail.fromJson(json['detail']) : null;
    if (json['smu'] != null) {
      _smu = [];
      json['smu'].forEach((v) {
        _smu?.add(Smu.fromJson(v));
      });
    }
    if (json['isi_kiriman'] != null) {
      _isiKiriman = [];
      json['isi_kiriman'].forEach((v) {
        _isiKiriman?.add(Isi_kiriman.fromJson(v));
      });
    }
    if (json['nama_agen'] != null) {
      _namaAgen = [];
      json['nama_agen'].forEach((v) {
        _namaAgen?.add(Nama_agen.fromJson(v));
      });
    }
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['warehouses'] != null) {
      _warehouses = [];
      json['warehouses'].forEach((v) {
        _warehouses?.add(Warehouses.fromJson(v));
      });
    }
  }
  Detail? _detail;
  List<Smu>? _smu;
  List<Isi_kiriman>? _isiKiriman;
  List<Nama_agen>? _namaAgen;
  Data? _data;
  List<Warehouses>? _warehouses;

  Detail? get detail => _detail;
  List<Smu>? get smu => _smu;
  List<Isi_kiriman>? get isiKiriman => _isiKiriman;
  List<Nama_agen>? get namaAgen => _namaAgen;
  Data? get data => _data;
  List<Warehouses>? get warehouses => _warehouses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_detail != null) {
      map['detail'] = _detail?.toJson();
    }
    if (_smu != null) {
      map['smu'] = _smu?.map((v) => v.toJson()).toList();
    }
    if (_isiKiriman != null) {
      map['isi_kiriman'] = _isiKiriman?.map((v) => v.toJson()).toList();
    }
    if (_namaAgen != null) {
      map['nama_agen'] = _namaAgen?.map((v) => v.toJson()).toList();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    if (_warehouses != null) {
      map['warehouses'] = _warehouses?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 108
/// smu : "126-04725"
/// nama_barang : "GENERAL CARGO"
/// nama_agen : "AGEN 1"
/// no_hp : "0127319283"
/// alamat : "BATAM"
/// status : "CHECKER"
/// koli : "1/3"
/// berat_awal : 200
/// berat_recharge_cargo : 10
/// berat_total : 190
/// checker : 3
/// project_id : "20"
/// check : true
/// warehouse : "DBM"
/// maskapai : ""
/// tanggal_penerbangan : "0000-00-00"
/// createdAt : "2021-09-10 22:10:05"
/// updatedAt : "2021-12-01 13:36:34"

class Warehouses {
  Warehouses({
      int? id, 
      String? smu, 
      String? namaBarang, 
      String? namaAgen, 
      String? noHp, 
      String? alamat, 
      String? status, 
      String? koli, 
      int? beratAwal, 
      int? beratRechargeCargo, 
      int? beratTotal, 
      int? checker, 
      String? projectId, 
      bool? check, 
      String? warehouse, 
      String? maskapai, 
      String? tanggalPenerbangan, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _smu = smu;
    _namaBarang = namaBarang;
    _namaAgen = namaAgen;
    _noHp = noHp;
    _alamat = alamat;
    _status = status;
    _koli = koli;
    _beratAwal = beratAwal;
    _beratRechargeCargo = beratRechargeCargo;
    _beratTotal = beratTotal;
    _checker = checker;
    _projectId = projectId;
    _check = check;
    _warehouse = warehouse;
    _maskapai = maskapai;
    _tanggalPenerbangan = tanggalPenerbangan;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Warehouses.fromJson(dynamic json) {
    _id = json['id'];
    _smu = json['smu'];
    _namaBarang = json['nama_barang'];
    _namaAgen = json['nama_agen'];
    _noHp = json['no_hp'];
    _alamat = json['alamat'];
    _status = json['status'];
    _koli = json['koli'];
    _beratAwal = json['berat_awal'];
    _beratRechargeCargo = json['berat_recharge_cargo'];
    _beratTotal = json['berat_total'];
    _checker = json['checker'];
    _projectId = json['project_id'];
    _check = json['check'];
    _warehouse = json['warehouse'];
    _maskapai = json['maskapai'];
    _tanggalPenerbangan = json['tanggal_penerbangan'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  int? _id;
  String? _smu;
  String? _namaBarang;
  String? _namaAgen;
  String? _noHp;
  String? _alamat;
  String? _status;
  String? _koli;
  int? _beratAwal;
  int? _beratRechargeCargo;
  int? _beratTotal;
  int? _checker;
  String? _projectId;
  bool? _check;
  String? _warehouse;
  String? _maskapai;
  String? _tanggalPenerbangan;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get smu => _smu;
  String? get namaBarang => _namaBarang;
  String? get namaAgen => _namaAgen;
  String? get noHp => _noHp;
  String? get alamat => _alamat;
  String? get status => _status;
  String? get koli => _koli;
  int? get beratAwal => _beratAwal;
  int? get beratRechargeCargo => _beratRechargeCargo;
  int? get beratTotal => _beratTotal;
  int? get checker => _checker;
  String? get projectId => _projectId;
  bool? get check => _check;
  String? get warehouse => _warehouse;
  String? get maskapai => _maskapai;
  String? get tanggalPenerbangan => _tanggalPenerbangan;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['smu'] = _smu;
    map['nama_barang'] = _namaBarang;
    map['nama_agen'] = _namaAgen;
    map['no_hp'] = _noHp;
    map['alamat'] = _alamat;
    map['status'] = _status;
    map['koli'] = _koli;
    map['berat_awal'] = _beratAwal;
    map['berat_recharge_cargo'] = _beratRechargeCargo;
    map['berat_total'] = _beratTotal;
    map['checker'] = _checker;
    map['project_id'] = _projectId;
    map['check'] = _check;
    map['warehouse'] = _warehouse;
    map['maskapai'] = _maskapai;
    map['tanggal_penerbangan'] = _tanggalPenerbangan;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}

/// id : 108
/// smu : "126-04725"
/// nama_barang : "GENERAL CARGO"
/// berat_total : "460"
/// koli : 3

class Data {
  Data({
      int? id, 
      String? smu, 
      String? namaBarang, 
      String? beratTotal, 
      int? koli,}){
    _id = id;
    _smu = smu;
    _namaBarang = namaBarang;
    _beratTotal = beratTotal;
    _koli = koli;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _smu = json['smu'];
    _namaBarang = json['nama_barang'];
    _beratTotal = json['berat_total'];
    _koli = json['koli'];
  }
  int? _id;
  String? _smu;
  String? _namaBarang;
  String? _beratTotal;
  int? _koli;

  int? get id => _id;
  String? get smu => _smu;
  String? get namaBarang => _namaBarang;
  String? get beratTotal => _beratTotal;
  int? get koli => _koli;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['smu'] = _smu;
    map['nama_barang'] = _namaBarang;
    map['berat_total'] = _beratTotal;
    map['koli'] = _koli;
    return map;
  }

}

/// nama_agen : "AGEN 1"

class Nama_agen {
  Nama_agen({
      String? namaAgen,}){
    _namaAgen = namaAgen;
}

  Nama_agen.fromJson(dynamic json) {
    _namaAgen = json['nama_agen'];
  }
  String? _namaAgen;

  String? get namaAgen => _namaAgen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nama_agen'] = _namaAgen;
    return map;
  }

}

/// nama_barang : "GENERAL CARGO"

class Isi_kiriman {
  Isi_kiriman({
      String? namaBarang,}){
    _namaBarang = namaBarang;
}

  Isi_kiriman.fromJson(dynamic json) {
    _namaBarang = json['nama_barang'];
  }
  String? _namaBarang;

  String? get namaBarang => _namaBarang;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nama_barang'] = _namaBarang;
    return map;
  }

}

/// id : 108
/// smu : "126-04725"
/// nama_barang : "GENERAL CARGO"
/// nama_agen : "AGEN 1"
/// no_hp : "0127319283"
/// alamat : "BATAM"
/// status : "CHECKER"
/// koli : "1/3"
/// berat_awal : 200
/// berat_recharge_cargo : 10
/// berat_total : 190
/// checker : 3
/// project_id : "20"
/// check : true
/// warehouse : "DBM"
/// maskapai : ""
/// tanggal_penerbangan : "0000-00-00"
/// createdAt : "2021-09-10 22:10:05"
/// updatedAt : "2021-12-01 13:36:34"


/// id : 20
/// tanggal : "2021-09-10 22:09:27"
/// no : "DO87676"
/// no_polisi_kendaraan : "GH987"
/// nama_pengemudi : "SUPRI"
/// asal_tps : "PKD"
/// kota_asal : "BTM"
/// kota_tujuan : "MDN"
/// selesai : 3
/// team : 2
/// createdAt : "2021-09-10 22:09:27"
/// updatedAt : "2021-09-10 22:11:55"

class Detail {
  Detail({
      int? id, 
      String? tanggal, 
      String? no, 
      String? noPolisiKendaraan, 
      String? namaPengemudi, 
      String? asalTps, 
      String? kotaAsal, 
      String? kotaTujuan, 
      int? selesai, 
      int? team, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _tanggal = tanggal;
    _no = no;
    _noPolisiKendaraan = noPolisiKendaraan;
    _namaPengemudi = namaPengemudi;
    _asalTps = asalTps;
    _kotaAsal = kotaAsal;
    _kotaTujuan = kotaTujuan;
    _selesai = selesai;
    _team = team;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Detail.fromJson(dynamic json) {
    _id = json['id'];
    _tanggal = json['tanggal'];
    _no = json['no'];
    _noPolisiKendaraan = json['no_polisi_kendaraan'];
    _namaPengemudi = json['nama_pengemudi'];
    _asalTps = json['asal_tps'];
    _kotaAsal = json['kota_asal'];
    _kotaTujuan = json['kota_tujuan'];
    _selesai = json['selesai'];
    _team = json['team'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  int? _id;
  String? _tanggal;
  String? _no;
  String? _noPolisiKendaraan;
  String? _namaPengemudi;
  String? _asalTps;
  String? _kotaAsal;
  String? _kotaTujuan;
  int? _selesai;
  int? _team;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get tanggal => _tanggal;
  String? get no => _no;
  String? get noPolisiKendaraan => _noPolisiKendaraan;
  String? get namaPengemudi => _namaPengemudi;
  String? get asalTps => _asalTps;
  String? get kotaAsal => _kotaAsal;
  String? get kotaTujuan => _kotaTujuan;
  int? get selesai => _selesai;
  int? get team => _team;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['tanggal'] = _tanggal;
    map['no'] = _no;
    map['no_polisi_kendaraan'] = _noPolisiKendaraan;
    map['nama_pengemudi'] = _namaPengemudi;
    map['asal_tps'] = _asalTps;
    map['kota_asal'] = _kotaAsal;
    map['kota_tujuan'] = _kotaTujuan;
    map['selesai'] = _selesai;
    map['team'] = _team;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}