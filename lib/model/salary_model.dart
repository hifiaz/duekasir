import 'package:json/json.dart';

@JsonCodable()
class Salary {
  final int id;
  final int? userId;
  final String? status;
  final String? periode;
  final List<ItemSalary>? items;
  final List<ItemSalary>? deductions;
  final int? total;
  final String? note;
  final String? createdAt;
  final String? user;
  final String? management;
}

@JsonCodable()
class ItemSalary {
  int? id;
  String? description;
  String? amount;
}
