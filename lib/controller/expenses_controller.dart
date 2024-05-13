import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class ExpensesController {
  final expenses = futureSignal(() async => Database().getExpenses());
}

final expensesController = ExpensesController();
