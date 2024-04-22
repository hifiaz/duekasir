import 'package:due_kasir/model/pembeli_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class CustomerController {
  final customer = futureSignal(() async => Database().getCustomers());
  final customerSelected = signal<PembeliModel?>(null);
}

final customerController = CustomerController();
