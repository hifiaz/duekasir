import 'dart:io';

import 'package:due_kasir/model/inventory_model.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:signals/signals_flutter.dart';

class InventoryController {
  final searchInventory = signal<String?>(null);
  final inventorys = futureSignal(() async => SupabaseHelper()
      .getInventoryAll(value: inventoryController.searchInventory.value));
  final deleteItemList = Signal<List<Inventory>>([]);
  final inventorySelected = signal<Inventory?>(null);
  final csvFile = signal<File?>(null);
  final selectAll = signal<bool>(false);
  final listItemFromCsv = ListSignal<Inventory>([]);
}

final inventoryController = InventoryController();
