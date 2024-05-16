import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class UserController {
  final searchUser = signal<String?>(null);
  final users = futureSignal(
      () async => Database().getUsers(name: userController.searchUser.value));
  final userSelected = signal<UserModel?>(null);
}

final userController = UserController();
