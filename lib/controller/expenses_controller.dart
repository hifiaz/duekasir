import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class ExpensesController {
  final dateRange = listSignal(
      [DateTime.now().subtract(const Duration(days: 31)), DateTime.now()]);
  final expenses = futureSignal(
    () async => Database().getExpenses(
        start: expensesController.dateRange.first,
        end: expensesController.dateRange.last),
  );
}

final expensesController = ExpensesController();
