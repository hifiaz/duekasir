import 'package:due_kasir/controller/customer_controller.dart';
import 'package:due_kasir/pages/customer/customer_list.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Customer extends HookWidget {
  const Customer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Customer'),
        centerTitle: false,
        actions: [
          ShadButton.ghost(
            onPressed: () {
              Database().searchCustomers().then((val) {
                customerController.customer.clear();
                customerController.customer.addAll(val);
              });
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
                Database().syncCustomers().whenComplete(() {
                  Database().searchCustomers().then((val) {
                    customerController.customer.clear();
                    customerController.customer.addAll(val);
                  });
                });
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
      body: const CustomerList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/customer/form'),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
