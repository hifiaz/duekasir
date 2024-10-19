import 'package:json/json.dart';

@JsonCodable()
class DuePayment {
  final int id;
  final String? name;
  final String? invoice;
  final String? itemName;
  final int? itemAmount;
  final int? amount;
  final String? status;
  final String? note;
  final String? dateIn;
  final String? dueDate;
  final String? createdAt;
  final String? user;
}
