import 'package:due_kasir/model/customer_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class CustomerController {
  final searchCustomer = signal<String?>(null);
  final customer = futureSignal(() async =>
      Database().getCustomers(name: customerController.searchCustomer.value));
  final customerSelected = signal<CustomerModel?>(null);
}

final customerController = CustomerController();
