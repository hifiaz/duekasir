import 'package:due_kasir/model/inventory_model.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:signals/signals_flutter.dart';

class ReportController {
  final dateRange = listSignal(
      [DateTime.now().subtract(const Duration(days: 31)), DateTime.now()]);
  final report = futureSignal(
    () async => SupabaseHelper().getRepots(
        start: reportController.dateRange.first,
        end: reportController.dateRange.last),
  );
  final reportToday = futureSignal(() async => SupabaseHelper().getRepots(
      start: DateTime.now().copyWith(hour: 0, minute: 0, second: 0),
      end: DateTime.now().copyWith(hour: 23, minute: 59, second: 59)));

  final reportYesterday = futureSignal(() async => SupabaseHelper().getRepots(
      start: DateTime.now()
          .subtract(const Duration(days: 1))
          .copyWith(hour: 0, minute: 0, second: 0),
      end: DateTime.now()
          .subtract(const Duration(days: 1))
          .copyWith(hour: 23, minute: 59, second: 59)));
  final reportUser =
      futureSignal(() async => SupabaseHelper().getReportsByUser());
  final reportIncome = futureSignal(
    () async => SupabaseHelper().getSalesByDate(
        start: reportController.dateRange.first,
        end: reportController.dateRange.last),
  );
  final reportOutOfStcok =
      futureSignal(() async => SupabaseHelper().getOutStock());
  final bestSeller = listSignal<Inventory>([], autoDispose: true);
  final rentRevenue =
      futureSignal(() async => SupabaseHelper().getRentRevenue());
}

final reportController = ReportController();
