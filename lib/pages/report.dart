import 'package:due_kasir/controller/report_controller.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/report/report_pie.dart';
import 'package:due_kasir/pages/report/report_revenue.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final report = reportController.report.watch(context);
    final reportToday = reportController.reportToday.watch(context);
    final reportYesteday = reportController.reportYesterday.watch(context);
    final theme = ShadTheme.of(context);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Report'),
        centerTitle: false,
        actions: [
          ShadButton.ghost(
            onPressed: () {
              reportController.report.refresh();
              reportController.reportToday.refresh();
              reportController.reportYesterday.refresh();
            },
            text: const Text('Refresh'),
            icon: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.refresh,
                size: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              children: [
                const ReportPie(),
                const SizedBox(width: 10, height: 10),
                Column(
                  children: [
                    ShadCard(
                      width: 350,
                      title: Text(
                          currency.format(sumReport(reportToday.value ?? [])),
                          style: theme.textTheme.h4),
                      description: const Text('Total Penjualan Hari ini'),
                    ),
                    const SizedBox(height: 10),
                    ShadCard(
                      width: 350,
                      title: Text(
                          currency
                              .format(sumReport(reportYesteday.value ?? [])),
                          style: theme.textTheme.h4),
                      description: const Text('Total Penjualan Kemarin'),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                if (report.hasValue)
                  Column(
                    children: [
                      ShadCard(
                        width: 350,
                        title: Text(
                            currency.format(sumReport(report.value ?? [])),
                            style: theme.textTheme.h4),
                        description: const Text('Revenue'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ShadCard(
                        width: 350,
                        title: Text(
                            currency.format(sumReport(report.value ?? []) -
                                report.value!.fold(
                                    0,
                                    (p, c) =>
                                        p +
                                        c.items.fold(
                                            0,
                                            (p, c) =>
                                                p +
                                                c.hargaDasar * c.quantity))),
                            style: theme.textTheme.h4),
                        description: const Text('Profit'),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const ShadCard(
              title: Text('Report Revenue by Day'),
              content: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: ReportRevenue(),
              ),
            ),
            const SizedBox(height: 20),
            ShadCard(
              title: const Text('List Sales'),
              content: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    for (PenjualanModel item in report.value ?? [])
                      ExpansionTile(
                        leading: Text(item.id.toString()),
                        title: FutureBuilder<UserModel?>(
                            future: Database().getUserById(item.kasir),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data?.nama ?? 'Admin');
                              }
                              return const Text('Admin');
                            }),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dateWithTime.format(item.createdAt)),
                            Text(
                                '(${item.totalItem.toString()}) ${currency.format(item.totalHarga)}')
                          ],
                        ),
                        children: item.items
                            .map(
                              (val) => ListTile(
                                title: Text('${val.nama} - ${val.code}'),
                                subtitle: Row(
                                  children: [
                                    Text('${val.quantity} x '),
                                    Text(val.diskonPersen == null ||
                                            val.diskonPersen == 0
                                        ? currency.format(val.hargaJual)
                                        : currency.format(val.hargaJual -
                                            val.hargaJual *
                                                (val.diskonPersen! / 100))),
                                  ],
                                ),
                                trailing: Text(val.diskonPersen == null ||
                                        val.diskonPersen == 0
                                    ? currency
                                        .format(val.hargaJual * val.quantity)
                                    : currency.format((val.hargaJual -
                                            val.hargaJual *
                                                (val.diskonPersen! / 100)) *
                                        val.quantity)),
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
