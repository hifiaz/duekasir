import 'package:due_kasir/controller/due_payment_controller.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:due_kasir/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class DuePayment extends StatefulWidget {
  const DuePayment({super.key});

  @override
  State<DuePayment> createState() => _DuePaymentState();
}

class _DuePaymentState extends State<DuePayment> with SignalsMixin {
  @override
  Widget build(BuildContext context) {
    final payment = duePaymentController.payments.watch(context);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Due Payment'),
        centerTitle: false,
        actions: [
          ShadButton.ghost(
            onPressed: () {
              duePaymentController.payments.refresh();
            },
            icon: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.refresh,
                size: 16,
              ),
            ),
            child: const Text('Refresh'),
          ),
          // PopupMenuButton<String>(
          //   onSelected: (item) async {
          //     if (item == 'sync') {
          //       await Database().duePaymentSync();
          //       await duePaymentController.payments.refresh();
          //     }
          //   },
          //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          //     const PopupMenuItem<String>(
          //       value: 'sync',
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Icon(Icons.restore),
          //           SizedBox(width: 8),
          //           Text('Sync'),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: payment.map(
          data: (items) {
            if (items.isEmpty) {
              return const Center(child: Text('There is no Data'));
            }
            if (PlatformExtension.isMobile) {
              return Column(
                children: items
                    .map((i) => ListTile(
                          leading: Text(i.id.toString()),
                          title: Text('${i.name}(${i.invoice ?? ''})'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              i.status == 'paid'
                                  ? ShadBadge(
                                      backgroundColor: Colors.green,
                                      child: Text(i.status!.toUpperCase()),
                                    )
                                  : ShadBadge.destructive(
                                      child: Text(i.status!.toUpperCase()),
                                    ),
                              Text(currency.format(i.amount)),
                              Text(
                                dateWithoutTime.format(
                                    i.dueDateDateTime ?? DateTime.now()),
                                style: TextStyle(
                                    color: i.status == 'paid'
                                        ? Colors.green
                                        : Colors.red),
                              )
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_right_outlined),
                          onTap: () {
                            duePaymentController.paymentSelected.value = i;
                            context.go('/due-payment/form');
                          },
                        ))
                    .toList(),
              );
            }
            return DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Item')),
                DataColumn(label: Text('Harga')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Note')),
                DataColumn(label: Text('Masuk')),
                DataColumn(label: Text('Tempo')),
                DataColumn(label: Text('More')),
              ],
              dataRowMaxHeight: 80.0,
              rows: items
                  .map((item) => DataRow(cells: [
                        DataCell(Text(item.id.toString())),
                        DataCell(SizedBox(
                          width: 180,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name ?? ''),
                              Text(item.invoice ?? ''),
                            ],
                          ),
                        )),
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.itemName ?? ''),
                            Text('${item.itemAmount} Items')
                          ],
                        )),
                        DataCell(Text(currency.format(item.amount))),
                        DataCell(
                          item.status == 'paid'
                              ? ShadBadge(
                                  backgroundColor: Colors.green,
                                  child: Text(item.status!.toUpperCase()),
                                )
                              : ShadBadge.destructive(
                                  child: Text(item.status!.toUpperCase()),
                                ),
                        ),
                        DataCell(Text(item.note ?? '')),
                        DataCell(Text(dateWithoutTime
                            .format(item.dateInDateTime ?? DateTime.now()))),
                        DataCell(Text(dateWithoutTime
                            .format(item.dueDateDateTime ?? DateTime.now()))),
                        DataCell(
                          const Icon(Icons.more_horiz),
                          onTap: () {
                            duePaymentController.paymentSelected.value = item;
                            context.go('/due-payment/form');
                          },
                        ),
                      ]))
                  .toList(),
            );
          },
          error: (error, __) => Center(
            child: Text('$error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/due-payment/form'),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
