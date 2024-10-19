import 'package:json/json.dart';

@JsonCodable()
class RentItems {
  final int id;
  final String? name;
  final String? code;
  final String? note;
  final int? jumlahBarang;
  final int? rentThreeDay;
  final int? rentOneWeek;
  final int? rentOneMonth;
  final String? user;
  final String? createdAt;
}
