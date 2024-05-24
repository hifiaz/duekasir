import 'package:due_kasir/model/salary_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class SalaryController {
  final salaries = futureSignal(() async => Database().getSalary());
  final salarySelected = signal<SalaryModel?>(null);
  final dateRange = listSignal(
      [DateTime.now().subtract(const Duration(days: 31)), DateTime.now()]);
  final userId = signal<UserModel?>(null);
  final calculate = futureSignal(
    () async => Database().getReportById(
      start: salaryController.dateRange.first,
      end: salaryController.dateRange.last,
      userId: salaryController.userId.value?.id,
    ),
  );
}

final salaryController = SalaryController();
