import 'package:due_kasir/controller/request_controller.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/request/request_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    final request = requestController.requests.watch(context);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Request Note'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: request.map(
          data: (item) {
            if (item.isEmpty) {
              return const Center(child: Text('There is no Data'));
            }
            return Wrap(
              runSpacing: 10,
              spacing: 10,
              children: item.map((val) => RequestCard(val: val)).toList(),
            );
          },
          error: (e) => Center(child: Text('$e')),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/request/form'),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
