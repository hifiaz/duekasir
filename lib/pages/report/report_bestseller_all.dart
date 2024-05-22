import 'package:collection/collection.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:flutter/material.dart';

class ReportBestSellerAll extends StatelessWidget {
  final List<ProductItemModel> items;
  const ReportBestSellerAll({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sold Items'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ...ListTile.divideTiles(
              context: context,
              tiles: items
                  .sorted((a, b) => b.quantity!.compareTo(a.quantity!))
                  .map(
                    (n) => ListTile(
                      title: Text(n.nama ?? ''),
                      subtitle: Text('${currency.format(n.hargaJual)}/item'),
                      trailing: Text(' ${n.quantity} Sold'),
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
