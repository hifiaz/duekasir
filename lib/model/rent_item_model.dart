import 'package:isar/isar.dart';

part 'rent_item_model.g.dart';

@collection
class RentItemModel {
  Id? id = Isar.autoIncrement;
  String name;
  String code;
  String? note;
  int jumlahBarang;
  int rentThreeDay;
  int rentOneWeek;
  int rentOneMonth;
  DateTime? createdAt;
  bool isSynced;

  RentItemModel({
    this.id,
    required this.name,
    required this.code,
    this.note,
    required this.jumlahBarang,
    required this.rentThreeDay,
    required this.rentOneWeek,
    required this.rentOneMonth,
    this.createdAt,
    this.isSynced = true,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'note': note,
      'jumlahBarang': jumlahBarang,
      'rentThreeDay': rentThreeDay,
      'rentOneWeek': rentOneWeek,
      'rentOneMonth': rentOneMonth,
      'createdAt': createdAt?.toIso8601String()
    };
  }

  factory RentItemModel.fromJson(json) {
    return RentItemModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      note: json['note'] != null ? json['note'] as String : null,
      jumlahBarang: json['jumlahBarang'],
      rentThreeDay: json['rentThreeDay'],
      rentOneWeek: json['rentOneWeek'],
      rentOneMonth: json['rentOneMonth'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}
