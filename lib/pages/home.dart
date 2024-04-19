import 'package:due_kasir/pages/customer.dart';
import 'package:due_kasir/pages/inventory.dart';
import 'package:due_kasir/pages/report.dart';
import 'package:due_kasir/pages/selling.dart';
import 'package:due_kasir/pages/users.dart';
import 'package:due_kasir/pages/widget/menu_left.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

final screenActive = signal(0);

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Due Kasir'),
            Text(
              dateWithTime.format(DateTime.now()),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(flex: 1, child: MenuLeft()),
          const VerticalDivider(),
          Expanded(
            flex: 4,
            child: Watch((context) {
              switch (screenActive.value) {
                case 0:
                  return Selling();
                case 1:
                  return const Inventory();
                case 2:
                  return const Report();
                case 3:
                  return const Users();
                case 4:
                  return const Customer();
                default:
                  return Selling();
              }
            }),
          ),
        ],
      ),
    );
  }
}
