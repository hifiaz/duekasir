import 'package:due_kasir/controller/report_controller.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class ReportRevenue extends StatelessWidget {
  const ReportRevenue({super.key});

  @override
  Widget build(BuildContext context) {
    final reportIncome = reportController.reportIncome.watch(context);
    if (reportIncome.hasValue && reportIncome.value != null) {
      return SizedBox(
        height: 250,
        child: LineChart(mainData(reportIncome.value!)),
      );
    }
    return const SizedBox();
  }

  LineChartData mainData(Map<DateTime, List<Report>> data) {
    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          axisNameWidget: Text('Day'),
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 50),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 1,
      maxX: 31,
      minY: 0,
      maxY: 1000000.0,
      lineTouchData: LineTouchData(touchTooltipData:
          LineTouchTooltipData(getTooltipItems: (touchedSpots) {
        return touchedSpots.map((touchedSpot) {
          return LineTooltipItem(currency.format(touchedSpot.y),
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white));
        }).toList();
      })),
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (var i in data.entries)
              FlSpot(
                i.key.day.toDouble(),
                i.value.fold(0, (p, c) => p + c.totalHarga!),
              ),
          ],
          isCurved: true,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }
}
