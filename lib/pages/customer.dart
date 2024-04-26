import 'package:due_kasir/pages/customer/customer_list.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class Customer extends HookWidget {
  const Customer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Customer'),
        centerTitle: false,
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
