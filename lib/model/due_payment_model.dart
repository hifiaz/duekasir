// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'due_payment_model.g.dart';

@collection
class DuePaymentModel {
  Id? id = Isar.autoIncrement;
  late String name;
  String? invoice;
  String? itemName;
  int itemAmount;
  int amount;
  String status;
  String? note;
  DateTime dateIn;
  DateTime dueDate;
  DateTime? createdAt;
  bool isSynced;

  DuePaymentModel({
    this.id,
    required this.name,
    this.invoice,
    this.itemName,
    required this.itemAmount,
    required this.amount,
    required this.status,
    this.note,
    required this.dateIn,
    required this.dueDate,
    this.createdAt,
    this.isSynced = true,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'invoice': invoice,
      'itemName': itemName,
      'itemAmount': itemAmount,
      'amount': amount,
      'status': status,
      'note': note,
      'dateIn': dateIn.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory DuePaymentModel.fromJson(json) {
    return DuePaymentModel(
      id: json['id'],
      name: json['name'],
      invoice: json['invoice'] != null ? json['invoice'] as String : null,
      itemName: json['itemName'] != null ? json['itemName'] as String : null,
      itemAmount: json['itemAmount'],
      amount: json['amount'],
      status: json['status'],
      note: json['note'],
      dateIn: DateTime.parse(json['dateIn']),
      dueDate: DateTime.parse(json['dueDate']),
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}
