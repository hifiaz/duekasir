import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class PresenceController {
  final dateRange = listSignal(
      [DateTime.now().subtract(const Duration(days: 31)), DateTime.now()]);
  final presence = futureSignal(() async => Database().getPresense(
        start: presenceController.dateRange.first,
        end: presenceController.dateRange.last,
      ));
}

final presenceController = PresenceController();
