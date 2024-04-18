import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/pages/inventory/inventory_form.dart';
import 'package:due_kasir/pages/inventory/inventory_list.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class Inventory extends StatelessWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              if (inventoryController.listInventoryActive.watch(context))
                const InventoryList()
              else
                InventoryForm(
                    item: inventoryController.inventorySelected.value),
              if (inventoryController.listInventoryActive.watch(context))
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () =>
                          inventoryController.listInventoryActive.value = false,
                      tooltip: 'Add',
                      child: const Icon(Icons.add),
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
