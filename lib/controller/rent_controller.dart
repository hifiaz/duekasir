import 'package:due_kasir/model/rent_item_model.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:signals/signals_flutter.dart';

class RentController {
  final rentItems = futureSignal(() async => SupabaseHelper().getRentItems());
  final rents = futureSignal(() async => SupabaseHelper().getRent());
  final rentItemSelected = signal<RentItems?>(null);
}

final rentController = RentController();
