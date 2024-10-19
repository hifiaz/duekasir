import 'package:due_kasir/model/due_payment_model.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:signals/signals_flutter.dart';

class DuePaymentController {
  final payments = futureSignal(() async => SupabaseHelper().getDuePayment());
  final paymentSelected = signal<DuePayment?>(null);
}

final duePaymentController = DuePaymentController();
