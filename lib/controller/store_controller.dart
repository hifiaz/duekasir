import 'package:due_kasir/service/supabase_service.dart';
import 'package:signals/signals_flutter.dart';

class StoreController {
  final store = futureSignal(() async => SupabaseHelper().getStore());
}

final storeController = StoreController();
