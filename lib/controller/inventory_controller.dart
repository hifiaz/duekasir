import 'dart:io';

import 'package:due_kasir/model/item_model.dart';
import 'package:signals/signals_flutter.dart';

class InventoryController {
  final inventorys =
      ListSignal<ItemModel>([]..sort((a, b) => a.id!.compareTo(b.id!)));
  final deleteItemList = Signal<List<ItemModel>>([]);
  final inventorySelected = signal<ItemModel?>(null);
  final csvFile = signal<File?>(null);
  final selectAll = signal<bool>(false);
  final listItemFromCsv = ListSignal<ItemModel>([]);
}

final inventoryController = InventoryController();
