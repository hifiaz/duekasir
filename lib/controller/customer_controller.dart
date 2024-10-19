import 'package:due_kasir/model/customer_model.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:signals/signals_flutter.dart';

class CustomerController {
  final searchCustomer = signal<String?>(null);
  final customer = futureSignal(() async =>
      SupabaseHelper().getCustomerAll(name: customerController.searchCustomer.value));
  final customerSelected = signal<Customer?>(null);
}

final customerController = CustomerController();
