import 'package:isar/isar.dart';

part 'item_model.g.dart';

@collection
class ItemModel {
  Id? id = Isar.autoIncrement;
  String nama;
  String code;
  String? deskripsi;
  int jumlahBarang;
  int quantity;
  String ukuran;
  int hargaDasar;
  int hargaJual;
  double? hargaJualPersen;
  double? diskonPersen;
  bool isHargaJualPersen;
  DateTime? barangMasuk;
  DateTime? barangKeluar;
  DateTime? createdAt;
  bool isSynced;

  ItemModel({
    this.id,
    required this.nama,
    required this.code,
    this.deskripsi,
    required this.jumlahBarang,
    required this.quantity,
    required this.ukuran,
    required this.hargaDasar,
    required this.hargaJual,
    this.hargaJualPersen,
    this.diskonPersen,
    required this.isHargaJualPersen,
    this.barangMasuk,
    this.barangKeluar,
    this.createdAt,
    this.isSynced = true,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'code': code,
      'deskripsi': deskripsi,
      'jumlahBarang': jumlahBarang,
      'quantity': quantity,
      'ukuran': ukuran,
      'hargaDasar': hargaDasar,
      'hargaJual': hargaJual,
      'hargaJualPersen': hargaJualPersen,
      'diskonPersen': diskonPersen,
      'isHargaJualPersen': isHargaJualPersen,
      'barangMasuk': barangMasuk?.toIso8601String(),
      'barangKeluar': barangKeluar?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String()
    };
  }

  factory ItemModel.fromJson(json) {
    return ItemModel(
      id: json['id'],
      nama: json['nama'],
      code: json['code'],
      deskripsi: json['deskripsi'] != null ? json['deskripsi'] as String : null,
      jumlahBarang: json['jumlahBarang'],
      quantity: json['quantity'],
      ukuran: json['ukuran'],
      hargaDasar: json['hargaDasar'],
      hargaJual: json['hargaJual'],
      hargaJualPersen: json['hargaJualPersen'] != null
          ? json['hargaJualPersen'] as double
          : null,
      diskonPersen:
          json['diskonPersen'] != null ? json['diskonPersen'] as double : null,
      isHargaJualPersen: json['isHargaJualPersen'],
      barangMasuk: json['barangMasuk'] != null
          ? DateTime.parse(json['barangMasuk'])
          : null,
      barangKeluar: json['barangKeluar'] != null
          ? DateTime.parse(json['barangKeluar'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
