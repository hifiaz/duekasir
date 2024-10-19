import 'package:due_kasir/service/supabase_service.dart';
import 'package:signals/signals_flutter.dart';

class AuthController {
  final customer = futureSignal(() async => SupabaseHelper().getCurrentUserProfile());
}

final authController = AuthController();
