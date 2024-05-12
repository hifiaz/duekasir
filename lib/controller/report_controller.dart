import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class ReportController {
  final report = futureSignal(() async => Database().getReport());
  final reportToday = futureSignal(() async => Database().getReportToday());
  final reportYesterday = futureSignal(() async => Database().getReportYesterday());
  final reportUser = futureSignal(() async => Database().getSalesByUser());
  final reportIncome = futureSignal(() async => Database().getSalesByMonth());
  final reportOutOfStcok = futureSignal(() async => Database().getOutStock());
  final bestSeller = listSignal<ProductItemModel>([], autoDispose: true);
}

final reportController = ReportController();
