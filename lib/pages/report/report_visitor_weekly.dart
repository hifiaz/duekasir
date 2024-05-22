import 'package:due_kasir/controller/report_controller.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class ReportVisitorWeekLy extends StatefulWidget {
  const ReportVisitorWeekLy({super.key});

  @override
  State<ReportVisitorWeekLy> createState() => _ReportVisitorWeekLyState();
}

class _ReportVisitorWeekLyState extends State<ReportVisitorWeekLy> {
  bool loading = true;
  List<MapEntry<DateTime, List<PenjualanModel>>> sun = [];
  List<MapEntry<DateTime, List<PenjualanModel>>> mon = [];
  List<MapEntry<DateTime, List<PenjualanModel>>> tue = [];
  List<MapEntry<DateTime, List<PenjualanModel>>> wed = [];
  List<MapEntry<DateTime, List<PenjualanModel>>> thu = [];
  List<MapEntry<DateTime, List<PenjualanModel>>> fri = [];
  List<MapEntry<DateTime, List<PenjualanModel>>> sat = [];

  @override
  void initState() {
    final reportIncome = reportController.reportIncome.watch(context);
    if (reportIncome.value != null) {
      initiateData(reportIncome.value!);
    } else {
      loading = false;
    }
    super.initState();
  }

  Future<void> initiateData(Map<DateTime, List<PenjualanModel>> data) async {
    await Future.forEach(data.entries, (i) {
      if (i.key.weekday == 7) {
        sun.add(i);
      } else if (i.key.weekday == 1) {
        mon.add(i);
      } else if (i.key.weekday == 2) {
        tue.add(i);
      } else if (i.key.weekday == 3) {
        wed.add(i);
      } else if (i.key.weekday == 4) {
        thu.add(i);
      } else if (i.key.weekday == 5) {
        fri.add(i);
      } else if (i.key.weekday == 6) {
        sat.add(i);
      }
    });
    await Future.delayed(Durations.long1);
    loading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final reportIncome = reportController.reportIncome.watch(context);
    return ShadCard(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Report Visitor Weekly'),
          ShadButton.ghost(
            onPressed: () async {
              setState(() {
                loading = true;
              });
              if (reportIncome.hasValue) {
                initiateData(reportIncome.value!);
              } else {
                setState(() {
                  loading = false;
                });
              }
            },
            text: const Text('Refresh'),
            icon: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.refresh,
                size: 16,
              ),
            ),
          ),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    barTouchData: barTouchData,
                    titlesData: titlesData,
                    borderData: borderData,
                    barGroups: barGroups,
                    gridData: const FlGridData(show: false),
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 20,
                  ),
                ),
              ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thu';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Colors.blue,
          Colors.cyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: mon.fold(0, (p, c) => p + c.value.length),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: tue.fold(0, (p, c) => p + c.value.length),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: wed.fold(0, (p, c) => p + c.value.length),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: thu.fold(0, (p, c) => p + c.value.length),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: fri.fold(0, (p, c) => p + c.value.length),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: sat.fold(0, (p, c) => p + c.value.length),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: sun.fold(0, (p, c) => p + c.value.length),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
