import 'dart:convert' show utf8;
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class CsvPreview extends StatefulWidget {
  const CsvPreview({super.key});

  @override
  State<CsvPreview> createState() => _CsvPreviewState();
}

class _CsvPreviewState extends State<CsvPreview> {
  Future<List<List<dynamic>>> data() async {
    final csv = inventoryController.csvFile.watch(context);
    final input = File(csv!.path).openRead();
    return await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .skip(1)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectAll = inventoryController.selectAll.watch(context);
    final d = inventoryController.listItemFromCsv.watch(context);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: data(),
        builder: (context, res) {
          if (res.data?.isNotEmpty == true) {
            final data = (res.data ?? []);
            return Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: ShadCheckbox(
                            value: selectAll,
                            onChanged: (v) {
                              inventoryController.selectAll.value = v;
                              if (v == false) {
                                inventoryController.listItemFromCsv.clear();
                              }
                            },
                          ),
                        ),
                        const DataColumn(label: Text('ID')),
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
                                              (val) =>
                                                  val.nama == item[1] &&
                                                  val.code ==
                                                      item[2].toString(),
                                            )
                                            ?.nama ==
                                        item[1]
                                    ? true
                                    : false,
                                onChanged: (v) {
                                  final res = ItemModel()
                                    ..nama = item[1]
                                    ..code = item[2].toString()
                                    ..deskripsi =
                                        item[3] == 'null' ? null : item[3]
                                    ..jumlahBarang = item[4]
                                    ..quantity = 1
                                    ..ukuran = item[6]
                                    ..hargaDasar = item[7]
                                    ..hargaJual = item[8]
                                    ..hargaJualPersen =
                                        double.parse(item[9].toString())
                                    ..diskonPersen =
                                        double.parse(item[10].toString())
                                    ..isHargaJualPersen =
                                        item[11] == 'TRUE' ? true : false;
                                  // print(res);
                                  inventoryController.listItemFromCsv.add(res);
                                },
                              ),
                            ),
                            DataCell(Text(item[0].toString())),
                            DataCell(Text(item[1].toString())),
                            DataCell(Text(item[2].toString())),
                            DataCell(Text(item[3].toString())),
                            DataCell(Text(item[4].toString())),
                            DataCell(Text(item[5].toString())),
                            DataCell(Text(item[6].toString())),
                            DataCell(Text(item[7].toString())),
                            DataCell(Text(item[8].toString())),
                            DataCell(Text(item[9].toString())),
                            DataCell(Text(item[10].toString())),
                            DataCell(Text(item[11].toString())),
                            DataCell(Text(item[12].toString())),
                            DataCell(Text(item[13].toString())),
                          ])
                      ],
                    ),
                  ),
                ),
              ],
            );
            // return ListView.builder(
            //   itemCount: res.data?.length,
            //   itemBuilder: (_, index) {
            //     return
            //     // return Card(
            //     //   margin: const EdgeInsets.all(3),
            //     //   color: Colors.white,
            //     //   child: ListTile(
            //     //     leading: Text(res.data![index][0].toString()),
            //     //     title: Text(res.data![index][1]),
            //     //     trailing: Text(res.data![index][2].toString()),
            //     //   ),
            //     // );
            //   },
            // );
          }
          return const Text('Data is Missing');
        },
      ),
    );
  }
}
