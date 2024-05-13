import 'package:due_kasir/controller/expenses_controller.dart';
import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/controller/report_controller.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/report/report_bestseller.dart';
import 'package:due_kasir/pages/report/report_pie.dart';
import 'package:due_kasir/pages/report/report_revenue.dart';
import 'package:due_kasir/pages/report/report_visitors.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:due_kasir/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    final isMobile = context.isMobile;
    final report = reportController.report.watch(context);
    final reportToday = reportController.reportToday.watch(context);
    final reportYesteday = reportController.reportYesterday.watch(context);
    final reportOutOfStcok = reportController.reportOutOfStcok.watch(context);
    final rentRevenue = reportController.rentRevenue.watch(context);
    final expenses = expensesController.expenses.watch(context);
    final theme = ShadTheme.of(context);
    final screenRevenue = isMobile ? context.width : (context.width - 70) / 4;
    final screen = isMobile ? context.width : (context.width - 60) / 3;
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
          PopupMenuButton<String>(
            onSelected: (item) async {
              if (item == 'sync') {
                Database().checkIsReportSynced();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'sync',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.restore),
                    SizedBox(width: 8),
                    Text('Sync'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                ReportPie(width: screenRevenue),
                Column(
                  children: [
                    ShadCard(
                      width: screenRevenue,
                      title: Text(
                          currency.format(sumReport(reportToday.value ?? [])),
                          style: theme.textTheme.h4),
                      description: const Text('Total Penjualan Hari ini'),
                    ),
                    const SizedBox(height: 10),
                    ShadCard(
                      width: screenRevenue,
                      title: Text(
                          currency
                              .format(sumReport(reportYesteday.value ?? [])),
                          style: theme.textTheme.h4),
                      description: const Text('Total Penjualan Kemarin'),
                    ),
                  ],
                ),
                if (report.hasValue)
                  Column(
                    children: [
                      ShadCard(
                        width: screenRevenue,
                        title: Text(
                            currency.format(sumReport(report.value ?? [])),
                            style: theme.textTheme.h4),
                        description: const Text('Revenue'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ShadCard(
                        width: screenRevenue,
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
                                                c.hargaDasar! * c.quantity!))),
                            style: theme.textTheme.h4),
                        description: const Text('Profit'),
                      ),
                    ],
                  ),
                Column(
                  children: [
                    ShadCard(
                      width: screenRevenue,
                      title: Text(
                          currency.format((rentRevenue.value ?? [])
                              .fold(0, (p, c) => p + c.amount)),
                          style: theme.textTheme.h4),
                      description: const Text('Rent Revenue'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (expenses.hasValue)
                      ShadCard(
                        width: screenRevenue,
                        title: Text(
                            currency.format(expenses.value!
                                .fold(0, (p, c) => p + c.amount)),
                            style:
                                theme.textTheme.h4.copyWith(color: Colors.red)),
                        description: const Text('Expenses'),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                ReportVisitors(width: screen),
                ShadCard(
                  width: screen,
                  title: const Text('Out of Stock'),
                  description: Text(
                      'You have ${reportOutOfStcok.value?.length} item out of stock.'),
                  content: Column(
                    children: [
                      const SizedBox(height: 16),
                      if (reportOutOfStcok.hasValue)
                        ...reportOutOfStcok.value!.take(10).map(
                              (n) => Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        margin: const EdgeInsets.only(top: 4),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '${n.nama} - ${n.jumlahBarang} Item Left',
                                                  style: theme.textTheme.small),
                                              const SizedBox(height: 4),
                                              Text(
                                                  '${currency.format(n.hargaDasar)} - ${n.code}',
                                                  style: theme.textTheme.muted),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            inventoryController
                                                .inventorySelected.value = n;
                                            context.go('/inventory/form');
                                          },
                                          icon: const Icon(Icons.arrow_right))
                                    ],
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                if (report.hasValue)
                  ReportBestSeller(width: screen, list: report.value!),
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
                    for (PenjualanModel item in (report.value ?? []).reversed)
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
                          children: [
                            ...item.items.map(
                              (val) => ListTile(
                                title: Text('${val.nama} - ${val.code}'),
                                subtitle: Row(
                                  children: [
                                    Text('${val.quantity} x '),
                                    Text(val.diskonPersen == null ||
                                            val.diskonPersen == 0
                                        ? currency.format(val.hargaJual)
                                        : currency.format(val.hargaJual! -
                                            val.hargaJual! *
                                                (val.diskonPersen! / 100))),
                                  ],
                                ),
                                trailing: Text(val.diskonPersen == null ||
                                        val.diskonPersen == 0
                                    ? currency
                                        .format(val.hargaJual! * val.quantity!)
                                    : currency.format((val.hargaJual! -
                                            val.hargaJual! *
                                                (val.diskonPersen! / 100)) *
                                        val.quantity!)),
                              ),
                            ),
                          ]),
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
