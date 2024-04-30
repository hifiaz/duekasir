// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'customer_model.g.dart';

@collection
class CustomerModel {
  Id? id = Isar.autoIncrement;
  late String nama;
  String? phone;
  String? ktp;
  late DateTime? dob;
  String? keterangan;
  late bool status;
  DateTime? masuk;
  DateTime? createdAt;
  bool isSynced;

  CustomerModel({
    this.id,
    required this.nama,
    this.phone,
    this.ktp,
    this.dob,
    this.keterangan,
    required this.status,
    this.masuk,
    this.createdAt,
    this.isSynced = true,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'phone': phone,
      'ktp': ktp,
      'dob': dob,
      'keterangan': keterangan,
      'status': status,
      'masuk': masuk?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory CustomerModel.fromJson(json) {
    return CustomerModel(
      id: json['id'],
      nama: json['nama'],
      phone: json['phone'] != null ? json['phone'] as String : null,
      ktp: json['ktp'] != null ? json['ktp'] as String : null,
      dob: json['dob'] != null ? DateTime(json['dob']) : null,
      keterangan:
          json['keterangan'] != null ? json['keterangan'] as String : null,
      status: json['status'],
      masuk: json['masuk'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['masuk'] as int)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int)
          : null,
    );
  }
}
