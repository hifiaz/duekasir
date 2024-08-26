import 'package:due_kasir/controller/rent_controller.dart';
import 'package:due_kasir/model/rent_item_model.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/rent/rent_form.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class Rent extends StatefulWidget {
  const Rent({super.key});

  @override
  State<Rent> createState() => _RentState();
}

class _RentState extends State<Rent> {
  @override
  Widget build(BuildContext context) {
    final items = rentController.rentItems.watch(context);
    final rents = rentController.rents.watch(context);
    final screen = context.isMobile ? context.width : (context.width - 60) / 2;
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Rent'),
        centerTitle: false,
        actions: [
          ShadButton.ghost(
            onPressed: () {
              rentController.rentItems.refresh();
              rentController.rents.refresh();
            },
            icon: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.refresh,
                size: 16,
              ),
            ),
            child: const Text('Refresh'),
          ),
          PopupMenuButton<String>(
            onSelected: (item) async {
              if (item == 'sync') {
                await Database().rentSync();
                await rentController.rents.refresh();
                await Database().rentItemSync();
                await rentController.rentItems.refresh();
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
      body: SingleChildScrollView(
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: [
            ShadCard(
              width: screen,
              title: const Text('Ready to Rent'),
              description: const Text('Available item to rent'),
              child: items.map(
                data: (val) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: val
                        .map((p) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  rentController.rentItemSelected.value = p;
                                  context.go('/rent/form');
                                },
                              ),
                              title: Text(p.name),
                              subtitle: Text(
                                '${currency.format(p.rentOneMonth)}/Month\n${currency.format(p.rentOneWeek)}/Week\n${currency.format(p.rentThreeDay)}/3 Days',
                                style: ShadTheme.of(context).textTheme.muted,
                              ),
                              trailing: const Icon(Icons.arrow_right),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RentForm(item: p)),
                              ),
                            ))
                        .toList(),
                  );
                },
                error: (e, ee) => Text(
                    'Something wrong please force close app and reopen $e'),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(width: 10),
            ShadCard(
              width: screen,
              title: const Text('Rental Periode'),
              description: const Text('List customer who rent our item'),
              child: rents.map(
                data: (rest) {
                  return Column(
                      children: rest.map(
                    (p) {
                      return FutureBuilder<RentItemModel?>(
                        future: Database().getRentItemById(p.item),
                        builder: (context, snapshot) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(p.name,
                                style: p.paid
                                    ? const TextStyle(
                                        decoration: TextDecoration.lineThrough)
                                    : null),
                            subtitle: Text(
                              p.paid
                                  ? snapshot.data?.name ?? ''
                                  : '${snapshot.data?.name} - Expired on ${(DateTime.now().difference(p.rentDate).inDays)} days - ${p.rentDate.day}/${p.rentDate.month}/${p.rentDate.year}',
                              style: p.paid
                                  ? const TextStyle(
                                      decoration: TextDecoration.lineThrough)
                                  : null,
                            ),
                            trailing: p.paid
                                ? null
                                : DateTime.now()
                                        .difference(p.rentDate)
                                        .inDays
                                        .isNegative
                                    ? const Icon(Icons.check_circle,
                                        color: Colors.green)
                                    : const Icon(Icons.close,
                                        color: Colors.red),
                            onTap: () {
                              if (p.paid) return;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RentForm(
                                          item: snapshot.data!,
                                          rent: p,
                                        )),
                              );
                            },
                          );
                        },
                      );
                    },
                  ).toList());
                },
                error: (e, ee) => const Text(
                    'Something wrong please force close app and reopen'),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/rent/form'),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
