import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/inventory/inventory_list.dart';
import 'package:due_kasir/service/database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Inventory extends StatelessWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Inventory'),
        centerTitle: false,
        actions: [
          ShadButton.ghost(
            onPressed: () {
              Database().searchInventorys().then((val) {
                inventoryController.inventorySearch.clear();
                inventoryController.inventorySearch.addAll(val);
              });
            },
            text: const Text('Refresh'),
            icon: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.refresh,
                size: 16,
              ),
            ),
          )
        ],
      ),
      body: const InventoryList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/inventory/form'),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
