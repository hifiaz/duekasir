import 'package:due_kasir/model/rent_item_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class RentController {
  final rentItems = futureSignal(() async => Database().getRentItem());
  final rents = futureSignal(() async => Database().getRent());
  final rentItemSelected = signal<RentItemModel?>(null);
}

final rentController = RentController();
