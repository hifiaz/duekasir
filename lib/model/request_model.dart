import 'package:json/json.dart';

@JsonCodable()
class Request {
  final int id;
  final String? note;
  final String createdAt;
  final String? user;
  final String? status;
  final String? title;
}
