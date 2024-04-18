import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class InventoryList extends StatelessWidget {
  const InventoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
              ),
            ),
            const SizedBox(height: 20),
            Watch(
              (context) => DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Harga')),
                  DataColumn(label: Text('Ukuran')),
                  DataColumn(label: Text('More')),
                ],
                rows: inventoryController.inventory.value.map(
                    loading: () => [
                          const DataRow(cells: [
                            DataCell(Text('Loading')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text(''))
                          ])
                        ],
                    error: (e) => Text('Error $e'),
                    data: (data) {
                      return [
                        for (ItemModel item in data)
                          DataRow(cells: [
                            DataCell(Text(item.id.toString())),
                            DataCell(Text(item.nama)),
                            DataCell(Text(item.code)),
                            DataCell(Text(item.quantity.toString())),
                            DataCell(Text(item.hargaJual.toString())),
                            DataCell(Text(item.ukuran)),
                            DataCell(
                              const Icon(Icons.keyboard_arrow_right_outlined),
                              onTap: () {
                                inventoryController.inventorySelected.value =
                                    item;
                                inventoryController.listInventoryActive.value =
                                    false;
                              },
                            ),
                          ])
                      ];
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
