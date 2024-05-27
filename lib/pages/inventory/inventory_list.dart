import 'dart:io';

import 'package:csv/csv.dart';
import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/utils/extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class InventoryList extends HookWidget {
  const InventoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final inventory = inventoryController.inventorys.watch(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (val) {
                      inventoryController.searchInventory.value = val;
                      inventoryController.inventorys.refresh();
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (item) async {
                    if (item == 'upload') {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        File file = File(result.files.single.path!);
                        inventoryController.csvFile.value = file;
                        if (context.mounted) context.push('/csv-preview');
                      }
                    } else if (item == 'download') {
                      if (inventory.hasValue &&
                          inventory.value?.isNotEmpty == true) {
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
                        for (ItemModel map in inventory.value!) {
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
                        final directory =
                            await getApplicationDocumentsDirectory();
                        String csv = const ListToCsvConverter().convert(rows);
                        String filePath = "${directory.path}/due-kasir.csv";

                        File file = File(filePath);
                        File fileCsv = await file.writeAsString(csv);
                        if (!fileCsv.existsSync()) {
                          fileCsv.create(recursive: true);
                        }
                        if (Platform.isWindows) {
                          FileSaver.instance
                              .saveFile(
                                  name:
                                      'due-kasir-${DateTime.now().millisecondsSinceEpoch}.csv',
                                  file: fileCsv)
                              .then(
                                (_) => const ShadToast(
                                  title: Text('Export CSV Success!'),
                                  description: Text(
                                      'CSV File already on your download folder'),
                                ),
                              );
                        } else {
                          await FileSaver.instance.saveAs(
                              name: 'due-kasir',
                              file: fileCsv,
                              ext: 'csv',
                              mimeType: MimeType.csv);
                        }
                      }
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'download',
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.download),
                          SizedBox(width: 8),
                          Text('Download'),
                        ],
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'upload',
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.upload),
                          SizedBox(width: 8),
                          Text('Upload'),
                        ],
                      ),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert_outlined),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          inventory.map(
              data: (items) {
                if (items.isEmpty) {
                  return const Center(child: Text('There is no Data'));
                }
                if (PlatformExtension.isMobile) {
                  return Column(
                    children: items
                        .map((item) => ListTile(
                              leading: Text(item.id.toString()),
                              title: Text('${item.nama} (${item.jumlahBarang} Stock)'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currency.format(item.hargaJual),
                                    style: TextStyle(
                                        color: item.diskonPersen != null &&
                                                item.diskonPersen != 0
                                            ? Colors.red
                                            : null,
                                        decoration: item.diskonPersen != null &&
                                                item.diskonPersen != 0
                                            ? TextDecoration.lineThrough
                                            : null),
                                  ),
                                  if (item.diskonPersen != null &&
                                      item.diskonPersen != 0) ...[
                                    Text(
                                      'Dasar: ${currency.format(item.hargaDasar)}',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    Text(
                                      'Disc: ${item.diskonPersen}',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    Text(
                                      currency.format(item.hargaJual -
                                          item.hargaJual *
                                              (item.diskonPersen! / 100)),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.green),
                                    )
                                  ]
                                ],
                              ),
                              // subtitle: Text(
                              //     '${i.diskonPersen == null || i.diskonPersen == 0 ? currency.format(i.hargaJual) : currency.format(i.hargaJual - i.hargaJual * (i.diskonPersen! / 100))} - ${i.code} (${i.jumlahBarang} Stock)'),
                              trailing: const Icon(Icons.arrow_right_outlined),
                              onTap: () {
                                inventoryController.inventorySelected.value =
                                    item;
                                context.go('/inventory/form');
                              },
                            ))
                        .toList(),
                  );
                }
                return DataTable(
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Nama')),
                    DataColumn(label: Text('Code')),
                    DataColumn(label: Text('Stock')),
                    DataColumn(label: Text('Harga')),
                    DataColumn(label: Text('Ukuran')),
                    DataColumn(label: Text('More')),
                  ],
                  dataRowMaxHeight: 80.0,
                  rows: items
                      .map((item) => DataRow(cells: [
                            DataCell(Text(item.id.toString())),
                            DataCell(Text(item.nama)),
                            DataCell(Text(item.code)),
                            DataCell(Text(item.jumlahBarang.toString())),
                            DataCell(ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 110),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currency.format(item.hargaJual),
                                    style: TextStyle(
                                        color: item.diskonPersen != null &&
                                                item.diskonPersen != 0
                                            ? Colors.red
                                            : null,
                                        decoration: item.diskonPersen != null &&
                                                item.diskonPersen != 0
                                            ? TextDecoration.lineThrough
                                            : null),
                                  ),
                                  if (item.diskonPersen != null &&
                                      item.diskonPersen != 0) ...[
                                    Text(
                                      'Dasar: ${currency.format(item.hargaDasar)}',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    Text(
                                      'Disc: ${item.diskonPersen}',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    Text(
                                      currency.format(item.hargaJual -
                                          item.hargaJual *
                                              (item.diskonPersen! / 100)),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.green),
                                    )
                                  ]
                                ],
                              ),
                            )),
                            DataCell(Text(item.ukuran)),
                            DataCell(
                              const Icon(Icons.more_horiz),
                              onTap: () {
                                inventoryController.inventorySelected.value =
                                    item;
                                context.go('/inventory/form');
                              },
                            ),
                          ]))
                      .toList(),
                );
              },
              error: (e, __) => Text('$e'),
              loading: () => const Center(child: CircularProgressIndicator())),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
