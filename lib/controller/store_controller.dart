import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class StoreController {
  final store = futureSignal(() async => Database().getStore());
}

final storeController = StoreController();
