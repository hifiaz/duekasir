import 'package:due_kasir/model/customer_model.dart';
import 'package:signals/signals_flutter.dart';

class CustomerController {
  final customer = ListSignal<CustomerModel>([]);
  final customerSelected = signal<CustomerModel?>(null);
}

final customerController = CustomerController();
