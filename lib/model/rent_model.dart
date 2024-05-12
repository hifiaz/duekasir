import 'package:isar/isar.dart';

part 'rent_model.g.dart';

@collection
class RentModel {
  Id? id = Isar.autoIncrement;
  String name;
  int item;
  String? note;
  int amount;
  int? pinalty;
  bool identity;
  bool picture;
  bool paid;
  int howManyDay;
  DateTime rentDate;
  DateTime? updatedAt;
  DateTime? createdAt;
  bool isSynced;

  RentModel({
    this.id,
    required this.name,
    required this.item,
    this.note,
    required this.amount,
    this.pinalty,
    required this.identity,
    required this.picture,
    required this.paid,
    required this.howManyDay,
    required this.rentDate,
    this.updatedAt,
    this.createdAt,
    this.isSynced = true,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'item': item,
      'note': note,
      'amount': amount,
      'pinalty': pinalty,
      'identity': identity,
      'picture': picture,
      'paid': paid,
      'howManyDay': howManyDay,
      'rentDate': rentDate.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String()
    };
  }

  factory RentModel.fromJson(json) {
    return RentModel(
      id: json['id'],
      name: json['name'],
      item: json['item'],
      note: json['note'] != null ? json['note'] as String : null,
      amount: json['amount'],
      pinalty: json['pinalty'],
      identity: json['identity'],
      picture: json['picture'],
      paid: json['paid'],
      howManyDay: json['howManyDay'],
      rentDate: DateTime.parse(json['rentDate']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}
