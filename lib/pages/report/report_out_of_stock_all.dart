import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:flutter/material.dart';

class ReportOutOfStock extends StatelessWidget {
  final List<ItemModel> items;
  const ReportOutOfStock({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Item Out of Stock'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ...ListTile.divideTiles(
              context: context,
              tiles: items
                  .map(
                    (n) => ListTile(
                      title: Text(n.nama),
                      subtitle:
                          Text('${currency.format(n.hargaDasar)} - ${n.code}'),
                      trailing: Text(' ${n.jumlahBarang} left'),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
