import 'package:collection/collection.dart';
import 'package:due_kasir/controller/report_controller.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/pages/report/report_bestseller_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

final totalItem = Signal(0, autoDispose: true);

class ReportBestSeller extends HookWidget {
  final double width;
  const ReportBestSeller({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    final items = reportController.bestSeller.watch(context);
    reportController.report.listen(context, () {
      final List<PenjualanModel>? listValue =
          reportController.report.value.value;
      if (listValue != null) {
        if (totalItem.value != listValue.length) {
          totalItem.value = listValue.length;
          for (var i in listValue) {
            for (var r in i.items) {
              var res = items.firstWhereOrNull((v) => v.id == r.id);
              if (res != null) {
                items[items.indexWhere((element) => element.id == r.id)] = res
                  ..quantity = (res.quantity! + r.quantity!);
              } else {
                items.add(r);
              }
            }
          }
        }
      }
    });

    final theme = ShadTheme.of(context);
    return ShadCard(
      width: width,
      title: const Text('Best Seller'),
      description: const Text('Items base on how many item sold'),
      child: Column(
        children: [
          const SizedBox(height: 16),
          ...items
              .sorted((a, b) => b.quantity!.compareTo(a.quantity!))
              .take(10)
              .map(
                (n) => Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(top: 4),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(n.nama!, style: theme.textTheme.small),
                                const SizedBox(height: 4),
                                Text(' ${n.quantity} Sold',
                                    style: theme.textTheme.muted),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
          ShadButton(
            width: double.infinity,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportBestSellerAll(items: items)),
              );
            },
            child: const Text('See All'),
          ),
        ],
      ),
    );
  }
}
