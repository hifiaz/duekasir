import 'package:due_kasir/pages/home.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class MenuLeft extends StatelessWidget {
  const MenuLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            style: screenActive.watch(context) == 0 ? active : nonActive,
            onPressed: () => screenActive.value = 0,
            child: const Row(
              children: [
                Icon(Icons.sell_outlined),
                SizedBox(width: 8),
                Text('Selling'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: screenActive.watch(context) == 1 ? active : nonActive,
            onPressed: () => screenActive.value = 1,
            child: const Row(
              children: [
                Icon(Icons.inventory),
                SizedBox(width: 8),
                Text('Inventory'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: screenActive.watch(context) == 2 ? active : nonActive,
            onPressed: () => screenActive.value = 2,
            child: const Row(
              children: [
                Icon(Icons.home_repair_service_outlined),
                SizedBox(width: 8),
                Text('Report'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: screenActive.watch(context) == 3 ? active : nonActive,
            onPressed: () {
              screenActive.value = 3;
            },
            child: const Row(
              children: [
                Icon(Icons.person_2),
                SizedBox(width: 8),
                Text('Users'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: screenActive.watch(context) == 4 ? active : nonActive,
            onPressed: () => screenActive.value = 4,
            child: const Row(
              children: [
                Icon(Icons.people),
                SizedBox(width: 8),
                Text('Customer'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
