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
          TextButton(
              onPressed: () => Database().checkIsInventorySynced(),
              child: const Text('Sync')),
          TextButton(
              onPressed: () {
                showShadDialog(
                  context: context,
                  builder: (context) => ShadDialog.alert(
                    title: const Text('Are you absolutely sure?'),
                    description: const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'This action will delete your local data',
                      ),
                    ),
                    actions: [
                      ShadButton.outline(
                        text: const Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      ShadButton(
                        text: const Text('Continue'),
                        onPressed: () {
                          Database()
                              .clearInventory()
                              .whenComplete(() => context.go('/'));
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Clear')),
          ShadButton.ghost(
            onPressed: () {
              Database().searchInventorys().then((val) {
                inventoryController.inventorys.clear();
                inventoryController.inventorys.addAll(val);
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
