import 'package:due_kasir/controller/expenses_controller.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/expenses/expenses_form.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class Expanses extends StatelessWidget {
  const Expanses({super.key});

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
      body: expenses.hasValue && expenses.value?.isNotEmpty == true
          ? ShadTable.list(
              header: const [
                ShadTableCell.header(child: Text('ID')),
                ShadTableCell.header(child: Text('Title')),
                ShadTableCell.header(child: Text('Amount')),
                ShadTableCell.header(child: Text('Note')),
                ShadTableCell.header(
                  alignment: Alignment.centerRight,
                  child: Text('Date'),
                ),
              ],
              columnSpanExtent: (index) {
                if (index == 1) return const FixedTableSpanExtent(200);
                if (index == 2) return const FixedTableSpanExtent(200);
                if (index == 4) {
                  return const MaxTableSpanExtent(
                    FixedTableSpanExtent(120),
                    RemainingTableSpanExtent(),
                  );
                }
                // uses the default value
                return null;
              },
              children: expenses.value!.map(
                (p) => [
                  ShadTableCell(
                    child: Text(
                      p.id.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ShadTableCell(child: Text(p.title)),
                  ShadTableCell(child: Text(currency.format(p.amount))),
                  ShadTableCell(child: Text(p.note ?? '-')),
                  ShadTableCell(
                    alignment: Alignment.centerRight,
                    child: Text(dateWithTime.format(p.createdAt!)),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text('There is no data'),
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
