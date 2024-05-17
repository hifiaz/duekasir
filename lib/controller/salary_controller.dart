import 'package:due_kasir/model/salary_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:signals/signals_flutter.dart';

class SalaryController {
  final salaries = futureSignal(() async => Database().getSalary());
  final salarySelected = signal<SalaryModel?>(null);
}

final salaryController = SalaryController();
