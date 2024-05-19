import 'package:due_kasir/controller/customer_controller.dart';
import 'package:due_kasir/controller/expenses_controller.dart';
import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/controller/presence_controller.dart';
import 'package:due_kasir/controller/rent_controller.dart';
import 'package:due_kasir/controller/report_controller.dart';
import 'package:due_kasir/controller/store_controller.dart';
import 'package:due_kasir/controller/user_controller.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/service/database.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final isSync = Signal(false);

class Sync extends StatelessWidget {
  const Sync({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    User? user = Supabase.instance.client.auth.currentUser;
    final sync = isSync.watch(context);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Sync'),
        centerTitle: false,
      ),
      body: Center(
        child: ShadCard(
          width: 350,
          title: Text('Sync', style: theme.textTheme.h4),
          description: const Text(
              'Do you have data on cloud before? if not you can ignore this page and move to other menu'),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: theme.radius,
                    border: Border.all(color: theme.colorScheme.border),
                  ),
                  child: Row(
                    children: [
                      ShadImage.square(
                        LucideIcons.bellRing,
                        size: 24,
                        color: theme.colorScheme.foreground,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status account',
                                style: theme.textTheme.small,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Indicator become green when its ready to sync',
                                style: theme.textTheme.muted,
                              )
                            ],
                          ),
                        ),
                      ),
                      ShadSwitch(
                        checkedTrackColor: Colors.green,
                        value: user != null,
                        onChanged: (v) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          footer: ShadButton(
            width: double.infinity,
            text: Text(sync ? 'Loading...' : 'Sync Data'),
            onPressed: () async {
              if (user == null) return;
              isSync.value = true;
              // store
              await Database().syncStore();
              await storeController.store.refresh();
              // users
              await Database().syncUsers();
              await userController.users.refresh();
              // rent
              await Database().rentSync();
              await rentController.rents.refresh();
              await Database().rentItemSync();
              await rentController.rentItems.refresh();
              // expenses
              await Database().expensesSync();
              await expensesController.expenses.refresh();
              // presense
              await Database().presenseSync();
              await presenceController.presence.refresh();
              // report
              await Database().checkIsReportSynced();
              await reportController.report.refresh();
              await reportController.reportToday.refresh();
              await reportController.reportYesterday.refresh();
              // inventory
              await Database().checkIsInventorySynced();
              await Database().getInventorys();
              inventoryController.inventorys.refresh();
              // customer
              await Database().syncCustomers();
              customerController.customer.refresh();
              isSync.value = false;
              if (context.mounted) {
                ShadToaster.of(context).show(
                  const ShadToast(
                    description: Text('Sync Done, Enjoy Due Kasir!'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
