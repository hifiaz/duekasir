import 'package:isar/isar.dart';

part 'penjualan_model.g.dart';

@collection
class PenjualanModel {
  Id id = Isar.autoIncrement;
  List<ProductItemModel> items = [];
  late int totalItem;
  late double totalHarga;
  late double diskon;
  late int kasir;
  int? pembeli;
  String? keterangan;
  DateTime createdAt = DateTime.now();
}

@embedded
class ProductItemModel {
  late int id;
  late String nama;
  late String code;
  late String? deskripsi;
  late int jumlahBarang;
  late int quantity;
  late String ukuran;
  late int hargaDasar;
  late int hargaJual;
  double? hargaJualPersen;
  double? diskonPersen;
  late bool isHargaJualPersen;
  DateTime? barangMasuk;
  DateTime? barangKeluar;
  DateTime? createdAt;
  late bool isSynced;
}
