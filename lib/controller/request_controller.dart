import 'package:due_kasir/model/request_model.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:signals/signals_flutter.dart';

class RequestController {
  final requests = futureSignal(() async => SupabaseHelper().getRequests());
  final requestItemSelected = signal<Request?>(null);
}

final requestController = RequestController();
