import 'package:isar/isar.dart';

part 'store_model.g.dart';

@collection
class StoreModel {
  Id? id = Isar.autoIncrement;
  late String title;
  late String description;
  late String phone;
  String? footer;
  String? subFooter;

  StoreModel({
    this.id,
    required this.title,
    required this.description,
    required this.phone,
    this.footer,
    this.subFooter,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'phone': phone,
      'footer': footer,
      'subFooter': subFooter,
    };
  }

  factory StoreModel.fromJson(json) {
    return StoreModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      phone: json['phone'],
      footer: json['footer'],
      subFooter: json['subFooter'],
    );
  }
}
