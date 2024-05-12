import 'package:due_kasir/controller/report_controller.dart';
import 'package:due_kasir/controller/user_controller.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/utils/extension.dart';
import 'package:due_kasir/widget/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class ReportPie extends StatelessWidget {
  const ReportPie({super.key});

  @override
  Widget build(BuildContext context) {
    final users = userController.users.watch(context);
    final reportUsers = reportController.reportUser.watch(context);
    final report = reportController.report.watch(context);
    return ShadCard(
      width: context.isTablet
          ? context.width / 2.5
          : context.isMobile
              ? context.width
              : context.width / 3.5,
      title: const Text('Admin'),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (reportUsers.hasValue && report.hasValue)
            SizedBox(
              width: 200,
              height: 125,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 35,
                  sections:
                      showingSections(reportUsers.value!, report.value!.length),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: users.value
                      ?.map(
                        (u) => Indicator(
                          color: converColor(u.id),
                          text: u.nama,
                          isSquare: false,
                        ),
                      )
                      .toList() ??
                  [],
            ),
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      Map<int, List<PenjualanModel>> user, int total) {
    List<PieChartSectionData> listUser = [];
    for (var key in user.entries) {
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      listUser.add(
        PieChartSectionData(
          color: converColor(key.key),
          value: total / key.value.length,
          title:'${(100 * (key.value.length / total)).toStringAsFixed(2)}%',
          radius: 30,
          titleStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        ),
      );
    }
    return listUser;
  }
}
