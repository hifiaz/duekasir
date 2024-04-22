import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class ReportController {
  final report = futureSignal(() async => Database().getPenjualan());
}

final reportController = ReportController();
