import 'dart:io';

import 'package:due_kasir/controller/customer_controller.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

class CustomerList extends HookWidget {
  const CustomerList({super.key});

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
    return Padding(
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
            if (Platform.isAndroid || Platform.isIOS)
              ...customers.map((user) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(user.nama),
                  subtitle: Text(
                      '(${user.status ? 'Active' : 'Non-Active'}) ${user.phone ?? '-'} '),
                  trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                  onTap: () {
                    customerController.customerSelected.value = user;
                    context.push('/customer/form');
                  },
                );
              })
            else
              DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Phone')),
                  DataColumn(label: Text('Birth')),
                  DataColumn(label: Text('Identity')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Join')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('More')),
                ],
                rows: customers.map((user) {
                  return DataRow(cells: [
                    DataCell(Text(user.id.toString())),
                    DataCell(Text(user.nama)),
                    DataCell(Text(user.phone ?? '-')),
                    DataCell(Text(
                        dateWithoutTime.format(user.dob ?? DateTime.now()))),
                    DataCell(Text(user.ktp ?? '-')),
                    DataCell(
                        Text(user.status == true ? 'Active' : 'Non Active')),
                    DataCell(Text(
                        dateWithTime.format(user.masuk ?? DateTime.now()))),
                    DataCell(Text(user.keterangan ?? '')),
                    DataCell(
                      const Icon(Icons.keyboard_arrow_right_outlined),
                      onTap: () {
                        customerController.customerSelected.value = user;
                        context.push('/customer/form');
                      },
                    ),
                  ]);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
