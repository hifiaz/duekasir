import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class ReportController {
  final dateRange = listSignal(
      [DateTime.now().subtract(const Duration(days: 31)), DateTime.now()]);
  final report = futureSignal(
    () async => Database().getReport(
        start: reportController.dateRange.first,
        end: reportController.dateRange.last),
  );
  final reportToday = futureSignal(() async => Database().getReportToday());
  final reportYesterday =
      futureSignal(() async => Database().getReportYesterday());
  final reportUser = futureSignal(() async => Database().getSalesByUser());
  final reportIncome = futureSignal(
    () async => Database().getSalesByDate(
        start: reportController.dateRange.first,
        end: reportController.dateRange.last),
  );
  final reportOutOfStcok = futureSignal(() async => Database().getOutStock());
  final bestSeller = listSignal<ProductItemModel>([], autoDispose: true);
  final rentRevenue = futureSignal(() async => Database().getRentRevenue());
}

final reportController = ReportController();
