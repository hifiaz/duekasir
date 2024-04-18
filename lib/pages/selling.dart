import 'dart:developer';

import 'package:due_kasir/service/database.dart';
import 'package:flutter/material.dart';

class Selling extends StatelessWidget {
  const Selling({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'You have pushed the button this many times:',
                          ),
                          TextButton(
                            child: const Text('test'),
                            onPressed: () async {
                              final users = await Database().getUsers();
                              log(users.first.nama);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const VerticalDivider(),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const Column(
              children: [
                Text('Payment'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
