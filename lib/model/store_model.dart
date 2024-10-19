import 'package:json/json.dart';

@JsonCodable()
class StoreModel {
  final int id;
  final String title;
  final String? description;
  final String? phone;
  final String? footer;
  final String? subFooter;
  final String? user;
}
