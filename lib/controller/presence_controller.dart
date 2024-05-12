import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class PresenceController {
  final presence = futureSignal(() async => Database().getPresense());
}

final presenceController = PresenceController();
