import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/inventory/inventory_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Inventory extends StatelessWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Inventory'),
        centerTitle: false,
        // actions: [
        //   PopupMenuButton<String>(
        //     onSelected: (item) async {
        //       if (item == 'sync') {
        //         await Database().checkIsInventorySynced();
        //         inventoryController.inventorys.refresh();
        //       } else if (item == 'clear') {
        //         showShadDialog(
        //           context: context,
        //           builder: (context) => ShadDialog.alert(
        //             title: const Text('Are you absolutely sure?'),
        //             description: const Padding(
        //               padding: EdgeInsets.only(bottom: 8),
        //               child: Text(
        //                 'This action will delete your local data',
        //               ),
        //             ),
        //             actions: [
        //               ShadButton.outline(
        //                 child: const Text('Cancel'),
        //                 onPressed: () => Navigator.of(context).pop(false),
        //               ),
        //               ShadButton(
        //                 child: const Text('Continue'),
        //                 onPressed: () {
        //                   Database().clearInventory().whenComplete(() {
        //                     if (context.mounted) context.go('/');
        //                   });
        //                   Navigator.of(context).pop(true);
        //                 },
        //               ),
        //             ],
        //           ),
        //         );
        //       }
        //     },
        //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        //       const PopupMenuItem<String>(
        //         value: 'sync',
        //         child: Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Icon(Icons.restore),
        //             SizedBox(width: 8),
        //             Text('Sync'),
        //           ],
        //         ),
        //       ),
        //       const PopupMenuItem<String>(
        //         value: 'clear',
        //         child: Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Icon(Icons.clear_all),
        //             SizedBox(width: 8),
        //             Text('Clear'),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
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
