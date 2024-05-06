import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class ReportController {
  final report = futureSignal(() async => Database().getPenjualan());
  final reportToday = futureSignal(() async => Database().getReportToday());
  final reportYesterday = futureSignal(() async => Database().getReportYesterday());
  final reportUser = futureSignal(() async => Database().getSalesByUser());
  final reportIncome = futureSignal(() async => Database().getSalesByMonth());
}

final reportController = ReportController();
