import 'package:due_kasir/model/pembeli_model.dart';
import 'package:signals/signals_flutter.dart';

class CustomerController {
  final customer = ListSignal<PembeliModel>([]);
  final customerSelected = signal<PembeliModel?>(null);
}

final customerController = CustomerController();
