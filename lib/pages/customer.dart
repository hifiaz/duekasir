import 'package:due_kasir/controller/customer_controller.dart';
import 'package:due_kasir/pages/customer/customer_form.dart';
import 'package:due_kasir/pages/customer/customer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_flutter.dart';

class Customer extends HookWidget {
  const Customer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              if (customerController.listCustomerActive.watch(context))
                const CustomerList()
              else
                CustomerForm(customer: customerController.customerSelected.value),
              if (customerController.listCustomerActive.watch(context))
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () =>
                          customerController.listCustomerActive.value = false,
                      tooltip: 'Add',
                      child: const Icon(Icons.add),
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
