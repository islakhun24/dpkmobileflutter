class Project{
  final int? id;
  final String? tanggal;
  final String? no;
  final String? no_polisi_kendaraan;
  final String? nama_pengemudi;
  final String? asal_tps;
  final String? kota_asal;
  final String? kota_tujuan;
  final int? selesai;
  final int? team;
  Project({
    required this.id,
    required this.tanggal,
    required this.no,
    required this.no_polisi_kendaraan,
    required this.nama_pengemudi,
    required this.asal_tps,
    required this.kota_asal,
    required this.kota_tujuan,
    required this.selesai,
    required this.team,
  });

  factory Project.fromJson(Map<String, dynamic> json){
    return Project(
        id: json['id'],
        tanggal: json['tanggal'],
        no: json['no'],
        no_polisi_kendaraan: json['no_polisi_kendaraan'],
        nama_pengemudi: json['nama_pengemudi'],
        asal_tps: json['asal_tps'],
        kota_asal: json['kota_asal'] ,
        kota_tujuan: json['kota_tujuan'],
        selesai: json['selesai'],
        team: json['team']);
  }
  @override
  String toString() {
    return 'Trans{id: $id, tanggal: $tanggal, no: $no, no_polisi_kendaraan: $no_polisi_kendaraan, nama_pengemudi: $nama_pengemudi, asal_tps: $asal_tps, kota_tujuan: $kota_tujuan, selesai: $selesai, team: $selesai}';
  }
}