import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:due_kasir/controller/expenses_controller.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/expenses/expenses_form.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class Expanses extends StatelessWidget {
  const Expanses({super.key});

  @override
  Widget build(BuildContext context) {
    final dateRange = expensesController.dateRange.watch(context);
    final expenses = expensesController.expenses.watch(context);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Expanses'),
        centerTitle: false,
        actions: [
          ShadButton.ghost(
            onPressed: () {
              expensesController.expenses.refresh();
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
                await Database().expensesSync();
                await expensesController.expenses.refresh();
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShadButton.outline(
                    text: Text(
                        'Filter Date: ${dateWithoutTime.format(dateRange.first)} - ${dateWithoutTime.format(dateRange.last)}'),
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
                        expensesController.dateRange.value = [
                          results.first!,
                          results.last!
                        ];
                      }
                    }),
                ShadButton(
                  text: const Text('Reset'),
                  onPressed: () => expensesController.dateRange.value = [
                    DateTime.now().subtract(const Duration(days: 30)),
                    DateTime.now()
                  ],
                )
              ],
            ),
            expenses.map(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('There is no Data'),
                    ),
                  );
                }
                if (Platform.isAndroid || Platform.isIOS) {
                  return Column(
                    children: data
                        .map((v) => ListTile(
                              title: Text(v.title),
                              subtitle: Text(currency.format(v.amount)),
                              trailing:
                                  Text(dateWithoutTime.format(v.createdAt!)),
                            ))
                        .toList(),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DataTable(
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Title')),
                          DataColumn(label: Text('Amount')),
                          DataColumn(label: Text('Note')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Option')),
                        ],
                        rows: data
                            .map((val) => DataRow(cells: [
                                  DataCell(Text(val.id.toString())),
                                  DataCell(Text(val.title)),
                                  DataCell(Text(currency.format(val.amount))),
                                  DataCell(Text(val.note ?? '')),
                                  DataCell(Text(dateWithTime.format(
                                      val.createdAt ?? DateTime.now()))),
                                  DataCell(
                                    ShadButton.destructive(
                                      onPressed: () {
                                        expensesController.expenses.refresh();
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
                                  ),
                                ]))
                            .toList()),
                  ],
                );
              },
              error: (e, __) => Text('$e'),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showShadSheet(
          side: ShadSheetSide.right,
          context: context,
          builder: (context) => const ExpensesForm(),
        ),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
