import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class InventoryController {
  final inventory = futureSignal(() async => Database().getInventorys());
  final listInventoryActive = signal(true);
  final inventorySelected = signal<ItemModel?>(null);
}

final inventoryController = InventoryController();
