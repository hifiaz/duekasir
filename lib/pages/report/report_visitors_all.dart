import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ReportVisitorAll extends StatelessWidget {
  final Map<DateTime, List<PenjualanModel>> items;
  const ReportVisitorAll({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Visitor'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ...ListTile.divideTiles(
              context: context,
              tiles: items.entries
                  .toList()
                  .reversed
                  .map(
                    (i) => ListTile(
                      title: Text(dateWithoutTime.format(i.key)),
                      subtitle: Text(
                        currency.format(i.value
                            .fold(0, (p, c) => p + c.totalHarga.toInt())),
                      ),
                      trailing: Text('${i.value.length} People',
                          style: ShadTheme.of(context).textTheme.muted),
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
