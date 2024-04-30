import 'package:isar/isar.dart';

part 'customer_model.g.dart';

@collection
class CustomerModel {
  Id id = Isar.autoIncrement;
  late String nama;
  String? phone;
  String? ktp;
  late DateTime? dob;
  String? keterangan;
  late bool status;
  DateTime? masuk;
  DateTime createdAt = DateTime.now();
}
