import 'package:json/json.dart';

@JsonCodable()
class Customer {
  final int id;
  final String? nama;
  final String? phone;
  final String? ktp;
  final String? dob;
  final String? keterangan;
  final bool? status;
  final String? masuk;
  final String? user;
  final String createdAt;
}
