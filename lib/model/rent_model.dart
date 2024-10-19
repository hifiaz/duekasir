import 'package:json/json.dart';

@JsonCodable()
class Rent {
  final int id;
  final String? name;
  final int? item;
  final String? note;
  final int? amount;
  final int? pinalty;
  final bool? identity;
  final bool? picture;
  final String? rentDate;
  final bool? paid;
  final String? user;
  final String createdAt;
  final String? updatedAt;
  final int? howManyDay;
}
