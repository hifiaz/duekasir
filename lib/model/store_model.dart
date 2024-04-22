import 'package:isar/isar.dart';

part 'store_model.g.dart';

@collection
class StoreModel {
  Id id = Isar.autoIncrement;
  late String title;
  late String description;
  late String phone;
  String? footer;
  String? subFooter;
}
