import 'package:isar/isar.dart';

part 'item_model.g.dart';

@collection
class ItemModel {
  Id id = Isar.autoIncrement;
  late String nama;
  late String code;
  String? deskripsi;
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
  DateTime createdAt = DateTime.now();
}
