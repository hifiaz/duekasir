
import 'package:due_kasir/controller/user_controller.dart';
import 'package:due_kasir/service/database.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<Database>(() => Database());
  getIt.registerLazySingleton<UserController>(() => UserController());
}
