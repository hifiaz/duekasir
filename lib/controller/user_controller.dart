import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:signals/signals_flutter.dart';

class UserController {
  final searchUser = signal<String?>(null);
  final users = futureSignal(
      () async => SupabaseHelper().getUsers(name: userController.searchUser.value));
  final userSelected = signal<Users?>(null);
}

final userController = UserController();
