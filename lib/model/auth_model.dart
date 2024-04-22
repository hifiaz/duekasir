import 'package:due_kasir/model/user_model.dart';
import 'package:isar/isar.dart';

part 'auth_model.g.dart';

@collection
class AuthModel {
  Id id = Isar.autoIncrement;
  IsarLink<UserModel> user = IsarLink<UserModel>();
  DateTime createdAt = DateTime.now();
}
