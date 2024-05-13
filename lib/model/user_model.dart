import 'package:isar/isar.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  Id? id = Isar.autoIncrement;
  late String nama;
  DateTime? dob;
  String? keterangan;
  late bool status;
  DateTime? masuk;
  DateTime createdAt = DateTime.now();

  UserModel({
    this.id,
    required this.nama,
    this.dob,
    this.keterangan,
    required this.status,
    this.masuk,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'dob': dob?.toIso8601String(),
      'keterangan': keterangan,
      'status': status,
      'masuk': masuk?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromJson(json) {
    return UserModel(
      id: json['id'],
      nama: json['nama'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      keterangan:
          json['keterangan'] != null ? json['keterangan'] as String : null,
      status: json['status'],
      masuk: json['masuk'] != null ? DateTime.parse(json['masuk']) : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
