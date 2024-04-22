import 'package:due_kasir/controller/auth_controller.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/selling/selling_left.dart';
import 'package:due_kasir/pages/selling/selling_right.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

class Selling extends HookWidget {
  const Selling({super.key});

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.sizeOf(context).width >= 600;
    authController.customer.watch(context);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Selling'),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () => context.push('/print-setting'),
              icon: const Icon(Icons.connect_without_contact))
        ],
      ),
      body: isScreenWide
          ? const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: SellingLeft()),
                Expanded(flex: 1, child: SellingRight()),
              ],
            )
          : const SingleChildScrollView(
              child: Column(
                children: [SellingLeft(), SellingRight()],
              ),
            ),
    );
  }
}
