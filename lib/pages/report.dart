import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:due_kasir/controller/expenses_controller.dart';
import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/controller/report_controller.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/report/report_bestseller.dart';
import 'package:due_kasir/pages/report/report_out_of_stock_all.dart';
import 'package:due_kasir/pages/report/report_revenue.dart';
import 'package:due_kasir/pages/report/report_visitor_weekly.dart';
import 'package:due_kasir/pages/report/report_visitors.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:due_kasir/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

final isRefreshReport = signal(false);

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final reportFormKey = GlobalKey<ShadFormState>();
  bool obscure = true;
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final isLoading = isRefreshReport.watch(context);
    final dateRange = reportController.dateRange.watch(context);
    final isMobile = context.isMobile;
    final report = reportController.report.watch(context);
    final reportToday = reportController.reportToday.watch(context);
    final reportYesteday = reportController.reportYesterday.watch(context);
    final reportOutOfStcok = reportController.reportOutOfStcok.watch(context);
    final rentRevenue = reportController.rentRevenue.watch(context);
    final expenses = expensesController.expenses.watch(context);
    final theme = ShadTheme.of(context);
    final screen = isMobile ? context.width : (context.width - 60) / 3;
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Report'),
        centerTitle: false,
        actions: [
          ShadButton.ghost(
            onPressed: isLoading
                ? null
                : () async {
                    isRefreshReport.value = true;
                    await reportController.report.refresh();
                    await reportController.reportToday.refresh();
                    await reportController.reportYesterday.refresh();
                    await Future.delayed(Durations.medium1);
                    isRefreshReport.value = false;
                  },
            text: Text(isLoading ? 'Loading...' : 'Refresh'),
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
                await Database().checkIsReportSynced();
                reportController.report.refresh();
                reportController.reportToday.refresh();
                reportController.reportYesterday.refresh();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShadButton.outline(
                    text: Text(
                        'Filter: ${dateWithoutTime.format(dateRange.first)} - ${dateWithoutTime.format(dateRange.last)}'),
                    onPressed: () async {
                      var results = await showCalendarDatePicker2Dialog(
                        context: context,
                        config: CalendarDatePicker2WithActionButtonsConfig(
                          calendarType: CalendarDatePicker2Type.range,
                        ),
                        dialogSize: const Size(325, 400),
                        value: dateRange,
                        borderRadius: BorderRadius.circular(15),
                      );
                      if (results != null) {
                        reportController.dateRange.value = [
                          results.first!,
                          results.last!
                        ];
                      }
                    }),
                ShadButton(
                  text: const Text('Reset'),
                  onPressed: () => reportController.dateRange.value = [
                    DateTime.now().subtract(const Duration(days: 30)),
                    DateTime.now()
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                // ReportPie(width: screenRevenue),
                Column(
                  children: [
                    ShadCard(
                      width: screen,
                      title: Text(
                          currency.format(sumReport(reportToday.value ?? [])),
                          style: theme.textTheme.h4),
                      description: const Text('Total Penjualan Hari ini'),
                    ),
                    const SizedBox(height: 10),
                    ShadCard(
                      width: screen,
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
                        width: screen,
                        title: Text(
                            currency.format(sumReport(report.value ?? [])),
                            style: theme.textTheme.h4),
                        description: const Text('Revenue'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ShadCard(
                        width: screen,
                        title: Text(
                            currency.format(report.value!.fold(
                                    0, (p, c) => p + c.totalHarga.toInt()) -
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
                      width: screen,
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
                        width: screen,
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
                      if (reportOutOfStcok.hasValue) ...[
                        ...reportOutOfStcok.value!.take(8).map(
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
                        ShadButton(
                          width: double.infinity,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportOutOfStock(
                                      items: reportOutOfStcok.value!)),
                            );
                          },
                          text: const Text('See All'),
                        ),
                      ]
                    ],
                  ),
                ),
                ReportBestSeller(width: screen),
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
            const ReportVisitorWeekLy(),
            const SizedBox(height: 20),
            ShadCard(
              title: const Text('List Sales'),
              content: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    ShadAccordion<PenjualanModel>.multiple(
                      children: (report.value ?? []).reversed.map(
                            (detail) => ShadAccordionItem(
                              value: detail,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 5,
                                    runSpacing: 5,
                                    children: [
                                      Text(
                                        '${detail.id}.',
                                        style: ShadTheme.of(context)
                                            .textTheme
                                            .small,
                                      ),
                                      FutureBuilder<UserModel?>(
                                        future: Database()
                                            .getUserById(detail.kasir),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                                snapshot.data?.nama ?? 'Admin');
                                          }
                                          return const Text('Admin');
                                        },
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 5,
                                    runSpacing: 5,
                                    children: [
                                      Text(
                                        '${currency.format(detail.totalHarga)} (${detail.totalItem.toString()})',
                                        style: ShadTheme.of(context)
                                            .textTheme
                                            .small,
                                      ),
                                      Text(
                                          dateDayWithTime
                                              .format(detail.createdAt),
                                          style: ShadTheme.of(context)
                                              .textTheme
                                              .muted),
                                    ],
                                  ),
                                ],
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ...detail.items.map(
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
                                                      (val.diskonPersen! /
                                                          100))),
                                        ],
                                      ),
                                      trailing: Text(val.diskonPersen == null ||
                                              val.diskonPersen == 0
                                          ? currency.format(
                                              val.hargaJual! * val.quantity!)
                                          : currency.format((val.hargaJual! -
                                                  val.hargaJual! *
                                                      (val.diskonPersen! /
                                                          100)) *
                                              val.quantity!)),
                                    ),
                                  ),
                                  ShadButton.outline(
                                    onPressed: () {
                                      showShadDialog(
                                        context: context,
                                        builder: (context) => ShadDialog(
                                          title: const Text('Delete Report'),
                                          description: const Text(
                                              "Are you sure to delete this report, this action can't be undo"),
                                          content: Container(
                                            width: 375,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: ShadInputFormField(
                                              id: 'password',
                                              label: const Text('Password'),
                                              placeholder: const Text(
                                                  'Enter your password'),
                                              validator: (v) {
                                                if (v.length < 2) {
                                                  return 'Password must be at least 2 characters.';
                                                }
                                                return null;
                                              },
                                              obscureText: obscure,
                                              prefix: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: ShadImage.square(
                                                    size: 16, LucideIcons.lock),
                                              ),
                                              suffix: ShadButton(
                                                width: 24,
                                                height: 24,
                                                padding: EdgeInsets.zero,
                                                decoration: ShadDecoration.none,
                                                icon: ShadImage.square(
                                                  size: 16,
                                                  obscure
                                                      ? LucideIcons.eyeOff
                                                      : LucideIcons.eye,
                                                ),
                                                onPressed: () {
                                                  setState(
                                                      () => obscure = !obscure);
                                                },
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            ShadButton(
                                                onPressed: () => context.pop(),
                                                text: const Text('Cancel')),
                                            ShadButton(
                                                onPressed: () async {
                                                  if (reportFormKey
                                                          .currentState!
                                                          .value['password'] ==
                                                      '111111') {
                                                    await Database()
                                                        .removePenjualan(
                                                            detail.id!);
                                                    reportController.report
                                                        .refresh();
                                                    reportController.reportToday
                                                        .refresh();
                                                    reportController
                                                        .reportYesterday
                                                        .refresh();
                                                  }
                                                },
                                                text: const Text('Delete'))
                                          ],
                                        ),
                                      );
                                    },
                                    text: const Text('Delete'),
                                    icon: const Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.delete,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
