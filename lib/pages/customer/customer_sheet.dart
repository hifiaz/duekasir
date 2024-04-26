import 'package:due_kasir/controller/customer_controller.dart';
import 'package:due_kasir/controller/selling_controller.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/service/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class CustomerSheet extends HookWidget {
  const CustomerSheet({super.key, this.side});
  final ShadSheetSide? side;
  @override
  Widget build(BuildContext context) {
    final searchCustomer = useTextEditingController();
    final customers = customerController.customer.watch(context);
    useListenable(searchCustomer);
    useListenableSelector(searchCustomer, () {
      if (searchCustomer.text.length > 2) {
        Database().searchCustomers(value: searchCustomer.text).then((val) {
          customerController.customer.clear();
          customerController.customer.addAll(val);
        });
      } else if (searchCustomer.text.length == 1) {
        Database().searchCustomers().then((val) {
          customerController.customer.clear();
          customerController.customer.addAll(val);
        });
      }
    });
    return ShadSheet(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              context.pop();
              context.push('/customer/form');
            },
            icon: const Icon(Icons.add),
          ),
          const Text('List Customer'),
        ],
      ),
      description: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Pick customer who whan to buy"),
          ShadButton.outline(
            text: const Text('Umum'),
            onPressed: () {
              getIt.get<SellingController>().pelanggan.value = null;
              context.pop();
            },
          )
        ],
      ),
      content: SizedBox(
        width: side == ShadSheetSide.bottom || side == ShadSheetSide.top
            ? MediaQuery.sizeOf(context).width
            : null,
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: searchCustomer,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                    ),
                  ),
                  const SizedBox(height: 20),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Phone')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('More')),
                    ],
                    rows: customers.map((user) {
                      return DataRow(cells: [
                        DataCell(Text(user.id.toString())),
                        DataCell(Text(user.nama)),
                        DataCell(Text((user.phone ?? '').toString())),
                        DataCell(Text(
                            user.status == true ? 'Active' : 'Non Active')),
                        DataCell(ShadButton.outline(
                          text: const Text('Select'),
                          onPressed: () {
                            getIt.get<SellingController>().pelanggan.value =
                                user;
                            context.pop();
                          },
                        )),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
