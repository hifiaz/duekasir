import 'dart:io';

import 'package:due_kasir/model/item_model.dart';
import 'package:signals/signals_flutter.dart';

class InventoryController {
  final inventorySearch = ListSignal<ItemModel>([]);
  final inventorySelected = signal<ItemModel?>(null);
  final csvFile = signal<File?>(null);
  final selectAll = signal<bool>(false);
  final listItemFromCsv = ListSignal<ItemModel>([]);
}

final inventoryController = InventoryController();
