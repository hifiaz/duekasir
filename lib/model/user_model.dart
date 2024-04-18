import 'package:isar/isar.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;
  late String nama;
  DateTime? dob;
  String? keterangan;
  late bool status;
  DateTime? masuk;
  DateTime createdAt = DateTime.now();
}
