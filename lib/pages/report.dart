import 'package:due_kasir/controller/report_controller.dart';
import 'package:due_kasir/model/customer_model.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:signals/signals_flutter.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Report'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    DataColumn(label: Text('Tanggal')),
                    DataColumn(label: Text('Kasir')),
                    DataColumn(label: Text('Pembeli')),
                    DataColumn(label: Text('Total Item')),
                    DataColumn(label: Text('Total Harga')),
                    DataColumn(label: Text('More')),
                  ],
                  rows: reportController.report.value.map(
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
                          for (PenjualanModel item in data)
                            DataRow(cells: [
                              DataCell(Text(item.id.toString())),
                              DataCell(Text(GetTimeAgo.parse(item.createdAt))),
                              DataCell(FutureBuilder<UserModel?>(
                                  future: Database().getUserById(item.kasir),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                          snapshot.data?.nama ?? 'Admin');
                                    }
                                    return const Text('Admin');
                                  })),
                              DataCell(
                                item.pembeli != null
                                    ? FutureBuilder<CustomerModel?>(
                                        future: Database()
                                            .getCustomerById(item.pembeli!),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                                snapshot.data?.nama ?? 'Umum');
                                          }
                                          return const Text('Umum');
                                        })
                                    : const Text('Umum'),
                              ),
                              DataCell(Text(item.totalItem.toString())),
                              DataCell(Text(currency.format(item.totalHarga))),
                              DataCell(
                                const Icon(Icons.more_horiz),
                                onTap: () {},
                              ),
                            ])
                        ];
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
