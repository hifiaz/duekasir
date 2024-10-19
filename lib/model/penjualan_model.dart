import 'package:due_kasir/model/inventory_model.dart';
import 'package:json/json.dart';

@JsonCodable()
class Report {
  final int id;
  final List<Inventory> items;
  final int? totalItem;
  final double? totalHarga;
  final double? diskon;
  final int? kasir;
  final int? pembeli;
  final String? keterangan;
  final String createdAt;
  final String? user;
}
