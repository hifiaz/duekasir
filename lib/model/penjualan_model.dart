import 'package:due_kasir/model/item_model.dart';
import 'package:isar/isar.dart';

part 'penjualan_model.g.dart';

@collection
class PenjualanModel {
  Id id = Isar.autoIncrement;
  IsarLinks<ItemModel> items = IsarLinks<ItemModel>();
  late int totalItem;
  late double totalHarga;
  late double diskon;
  late int kasir;
  int? pembeli;
  String? keterangan;
  DateTime createdAt = DateTime.now();
}
