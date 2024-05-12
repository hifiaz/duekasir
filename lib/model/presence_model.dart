import 'package:isar/isar.dart';

part 'presence_model.g.dart';

@collection
class PresenceModel {
  Id? id = Isar.autoIncrement;
  int user;
  String status;
  String? note;
  DateTime createdAt;
  String? path;
  double? long;
  double? lat;
  bool isSynced;

  PresenceModel({
    this.id,
    required this.user,
    required this.status,
    this.note,
    required this.createdAt,
    this.path,
    this.long,
    this.lat,
    this.isSynced = true,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'status': status,
      'note': note,
      'path': path,
      'long': long,
      'lat': lat,
      'createdAt': createdAt.toIso8601String()
    };
  }

  factory PresenceModel.fromJson(json) {
    return PresenceModel(
      id: json['id'],
      user: json['user'],
      status: json['status'],
      note: json['note'],
      path: json['path'],
      long: json['long'],
      lat: json['lat'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
