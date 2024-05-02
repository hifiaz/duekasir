import 'package:due_kasir/controller/report_controller.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    final report = reportController.report.watch(context);
    final reportToday = reportController.reportToday.watch(context);
    final reportYesteday = reportController.reportYesterday.watch(context);
    final theme = ShadTheme.of(context);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Report'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                children: [
                  ShadCard(
                    width: 350,
                    title: Text(
                        currency.format(sumReport(reportToday.value ?? [])),
                        style: theme.textTheme.h4),
                    description: const Text('Total Penjualan Hari ini'),
                  ),
                  const SizedBox(width: 20),
                  ShadCard(
                    width: 350,
                    title: Text(
                        currency.format(sumReport(reportYesteday.value ?? [])),
                        style: theme.textTheme.h4),
                    description: const Text('Total Penjualan Kemarin'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              for (PenjualanModel item in report.value ?? [])
                ExpansionTile(
                  leading: Text(item.id.toString()),
                  title: FutureBuilder<UserModel?>(
                      future: Database().getUserById(item.kasir),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data?.nama ?? 'Admin');
                        }
                        return const Text('Admin');
                      }),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dateWithTime.format(item.createdAt)),
                      Text(
                          '(${item.totalItem.toString()}) ${currency.format(item.totalHarga)}')
                    ],
                  ),
                  children: item.items
                      .map(
                        (val) => ListTile(
                          title: Text('${val.nama} - ${val.code}'),
                          subtitle: Text(val.diskonPersen == null ||
                                  val.diskonPersen == 0
                              ? currency.format(val.hargaJual)
                              : currency.format(val.hargaJual -
                                  val.hargaJual * (val.diskonPersen! / 100))),
                          trailing: Text(val.quantity.toString()),
                        ),
                      )
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
