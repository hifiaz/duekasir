import 'package:json/json.dart';

@JsonCodable()
class Users {
  int id;
  final String nama;
  final String? dob;
  final String? keterangan;
  final bool? status;
  final String? masuk;
  final String? createdAt;
  final String? user;
}
