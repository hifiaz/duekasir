import 'package:json/json.dart';

@JsonCodable()
class Inventory {
  int id;
  String? nama;
  String? code;
  String? deskripsi;
  int? jumlahBarang;
  int? quantity;
  String? ukuran;
  num? hargaDasar;
  num? hargaJual;
  double? hargaJualPersen;
  double? diskonPersen;
  bool? isHargaJualPersen;
  String? barangMasuk;
  String? barangKeluar;
  String? createdAt;
  String? user;
}
