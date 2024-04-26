import 'dart:convert' show utf8;
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class CsvPreview extends StatefulWidget {
  const CsvPreview({super.key});

  @override
  State<CsvPreview> createState() => _CsvPreviewState();
}

class _CsvPreviewState extends State<CsvPreview> {
  Future<List<ItemModel>> data() async {
    final csv = inventoryController.csvFile.watch(context);
    final input = File(csv!.path).openRead();
    return await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .skip(1)
        .map((val) {
      return ItemModel()
        ..nama = val[1]
        ..code = val[2].toString()
        ..deskripsi = val[3] == 'null' ? null : val[3]
        ..jumlahBarang = val[4]
        ..quantity = 1
        ..ukuran = val[6].toString()
        ..hargaDasar = val[7]
        ..hargaJual = val[8]
        ..hargaJualPersen = double.parse(val[9].toString())
        ..diskonPersen = double.tryParse(val[10].toString())
        ..isHargaJualPersen = val[11] == 'TRUE' ? true : false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectAll = inventoryController.selectAll.watch(context);
    final d = inventoryController.listItemFromCsv.watch(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          ShadButton(
            onPressed: () => d.isNotEmpty
                ? Database().addAllInventory(d).whenComplete(() {
                    inventoryController.listItemFromCsv.clear();
                    Database().searchInventorys().then((val) {
                      inventoryController.inventorySearch.clear();
                      inventoryController.inventorySearch.addAll(val);
                    });
                    context.pop();
                  })
                : null,
            text: const Text('Export'),
            icon: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.import_export,
                size: 16,
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: data(),
        builder: (context, res) {
          if (res.data?.isNotEmpty == true) {
            final data = (res.data ?? []);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DataTable(
                    columns: [
                      DataColumn(
                        label: ShadCheckbox(
                          value: selectAll,
                          onChanged: (v) {
                            if (v) {
                              inventoryController.listItemFromCsv.addAll(data);
                            } else {
                              inventoryController.listItemFromCsv.clear();
                            }
                            inventoryController.selectAll.value = v;
                          },
                        ),
                      ),
                      const DataColumn(label: Text('Nama')),
                      const DataColumn(label: Text('Code')),
                      const DataColumn(label: Text('Description')),
                      const DataColumn(label: Text('Total Item')),
                      const DataColumn(label: Text('Quantity')),
                      const DataColumn(label: Text('Size')),
                      const DataColumn(label: Text('Low Price')),
                      const DataColumn(label: Text('Sell Price')),
                      const DataColumn(label: Text('Sell Price %')),
                      const DataColumn(label: Text('Discount %')),
                      const DataColumn(label: Text('Mode %')),
                      const DataColumn(label: Text('Item In')),
                      const DataColumn(label: Text('Item Out')),
                    ],
                    rows: [
                      for (var item in data)
                        DataRow(cells: [
                          DataCell(
                            ShadCheckbox(
                              value: d
                                          .firstWhereOrNull(
                                              (val) => val.code == item.code)
                                          ?.code !=
                                      item.code
                                  ? false
                                  : true,
                              onChanged: (v) {
                                if (d
                                        .firstWhereOrNull(
                                            (val) => val.code == item.code)
                                        ?.code ==
                                    item.code) {
                                  inventoryController.listItemFromCsv
                                      .removeWhere(
                                          (val) => val.code == item.code);
                                } else {
                                  inventoryController.listItemFromCsv.add(item);
                                }
                              },
                            ),
                          ),
                          DataCell(Text(item.nama.toString())),
                          DataCell(Text(item.code.toString())),
                          DataCell(Text(item.deskripsi.toString())),
                          DataCell(Text(item.jumlahBarang.toString())),
                          DataCell(Text(item.quantity.toString())),
                          DataCell(Text(item.ukuran.toString())),
                          DataCell(Text(item.hargaDasar.toString())),
                          DataCell(Text(item.hargaJual.toString())),
                          DataCell(Text(item.hargaJualPersen.toString())),
                          DataCell(Text(item.diskonPersen.toString())),
                          DataCell(Text(item.isHargaJualPersen.toString())),
                          DataCell(Text(item.barangMasuk.toString())),
                          DataCell(Text(item.barangKeluar.toString())),
                        ])
                    ],
                  ),
                ],
              ),
            );
          }
          return Text('Data is Missing ${res.error}');
        },
      ),
    );
  }
}
