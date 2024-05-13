import 'package:collection/collection.dart';
import 'package:due_kasir/controller/report_controller.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

final totalItem = Signal(0);

class ReportBestSeller extends StatefulWidget {
  final double width;
  final List<PenjualanModel> list;
  const ReportBestSeller({super.key, required this.width, required this.list});

  @override
  State<ReportBestSeller> createState() => _ReportBestSellerState();
}

class _ReportBestSellerState extends State<ReportBestSeller> {
  @override
  void initState() {
    final itemsRes = reportController.bestSeller.watch(context);
    if (totalItem.value != widget.list.length) {
      totalItem.value = widget.list.length;
      for (var i in widget.list) {
        for (var r in i.items) {
          var res = itemsRes.firstWhereOrNull((v) => v.id == r.id);
          if (res != null) {
            itemsRes[itemsRes.indexWhere((element) => element.id == r.id)] = res
              ..quantity = (res.quantity! + r.quantity!);
          } else {
            itemsRes.add(r);
          }
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = reportController.bestSeller.watch(context);
    final theme = ShadTheme.of(context);
    return ShadCard(
      width: widget.width,
      title: const Text('Best Seller'),
      description: const Text('Items base on how many item sold'),
      content: Column(
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
        ],
      ),
    );
  }
}
