import 'dart:io';

import 'package:csv/csv.dart';
import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class InventoryList extends StatelessWidget {
  const InventoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                    ),
                  ),
                ),
                ShadButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null) {
                      File file = File(result.files.single.path!);
                      inventoryController.csvFile.value = file;
                      if (context.mounted) context.push('/csv-preview');
                    }
                  },
                  text: const Text('Upload'),
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.upload,
                      size: 16,
                    ),
                  ),
                ),
                ShadButton.ghost(
                  icon: const Icon(Icons.download, size: 16),
                  size: ShadButtonSize.icon,
                  onPressed: () async {
                    List<List<dynamic>> rows = [];
                    rows.add([
                      "id",
                      "name",
                      "code",
                      "description",
                      "total_item",
                      "quantity",
                      "size",
                      "low_price",
                      "sell_price",
                      "sell_price_percent",
                      "discount_percent",
                      "is_percent",
                      "item_in",
                      "item_out",
                      "created"
                    ]);

                    for (ItemModel map
                        in inventoryController.inventory.value.value ?? []) {
                      rows.add([
                        map.id,
                        map.nama,
                        map.code,
                        map.deskripsi,
                        map.jumlahBarang,
                        map.quantity,
                        map.ukuran,
                        map.hargaDasar,
                        map.hargaJual,
                        map.hargaJualPersen,
                        map.diskonPersen,
                        map.isHargaJualPersen,
                        map.barangMasuk,
                        map.barangKeluar,
                        map.createdAt
                      ]);
                    }

                    String csv = const ListToCsvConverter().convert(rows);
                    String filePath = "due-kasir.csv";

                    File file = File(filePath);
                    File fileCsv = await file.writeAsString(csv);
                    FileSaver.instance.saveFile(
                        name: 'due-kasir-${DateTime.now()}.csv',
                        file: fileCsv);
                    // await FileSaver.instance.saveAs(
                    //     name: 'due-kasir-${DateTime.now().isUtc}',
                    //     file: fileCsv,
                    //     ext: 'csv',
                    //     mimeType: MimeType.csv);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Watch(
              (context) => DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Stock')),
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
                            DataCell(Text(item.jumlahBarang.toString())),
                            DataCell(Text(currency.format(item.hargaJual))),
                            DataCell(Text(item.ukuran)),
                            DataCell(
                              const Icon(Icons.more_horiz),
                              onTap: () {
                                inventoryController.inventorySelected.value =
                                    item;
                                context.go('/inventory/form');
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
