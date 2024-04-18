import 'package:isar/isar.dart';

part 'pembeli_model.g.dart';

@collection
class PembeliModel {
  Id id = Isar.autoIncrement;
  late String nama;
  String? ktp;
  late DateTime? dob;
  String? keterangan;
  late bool status;
  DateTime? masuk;
  DateTime createdAt = DateTime.now();
}
