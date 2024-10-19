import 'package:json/json.dart';

@JsonCodable()
class PresenseModel {
  final int id;
  final int? user;
  final String? status;
  final String? note;
  final String? path;
  final double? long;
  final double? lat;
  final String createdAt;
  final String? belong;
}
