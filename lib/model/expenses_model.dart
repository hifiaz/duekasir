import 'package:json/json.dart';

@JsonCodable()
class Expenses {
  final int id;
  final String? title;
  final String? note;
  final int? amount;
  final String createdAt;
  final String? user;
}
