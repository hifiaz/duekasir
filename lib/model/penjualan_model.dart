import 'package:isar/isar.dart';

part 'penjualan_model.g.dart';

@collection
class PenjualanModel {
  Id id = Isar.autoIncrement;
  late List<ItemData>? items = [];
  late double totalItem;
  late double totalHarga;
  late double diskon;
  late int kasir;
  int? pembeli;
  String? keterangan;
  DateTime createdAt = DateTime.now();
}

@embedded
class ItemData {
  late int id;
  late String nama;
  String? deskripsi;
  late int jumlahBarang;
  late int quantity;
  late double hargaDasar;
  late double hargaJual;
  double? hargaJualPersen;
  double? diskonPersen;
  late bool isHargaJualPersen;
  DateTime? barangMasuk;
  DateTime? barangKeluar;
  late DateTime createdAt;
}
