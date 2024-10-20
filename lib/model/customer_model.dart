// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Customer {
  final int id;
  final String? nama;
  final String? phone;
  final String? ktp;
  final DateTime? dob;
  final String? keterangan;
  final bool? status;
  final DateTime? masuk;
  final String? user;
  final DateTime createdAt;
  Customer({
    required this.id,
    this.nama,
    this.phone,
    this.ktp,
    this.dob,
    this.keterangan,
    this.status,
    this.masuk,
    this.user,
    required this.createdAt,
  });

  Customer copyWith({
    int? id,
    String? nama,
    String? phone,
    String? ktp,
    DateTime? dob,
    String? keterangan,
    bool? status,
    DateTime? masuk,
    String? user,
    DateTime? createdAt,
  }) {
    return Customer(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      phone: phone ?? this.phone,
      ktp: ktp ?? this.ktp,
      dob: dob ?? this.dob,
      keterangan: keterangan ?? this.keterangan,
      status: status ?? this.status,
      masuk: masuk ?? this.masuk,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'phone': phone,
      'ktp': ktp,
      'dob': dob?.millisecondsSinceEpoch,
      'keterangan': keterangan,
      'status': status,
      'masuk': masuk?.millisecondsSinceEpoch,
      'user': user,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as int,
      nama: map['nama'] != null ? map['nama'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      ktp: map['ktp'] != null ? map['ktp'] as String : null,
      dob: map['dob'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dob'] as int) : null,
      keterangan: map['keterangan'] != null ? map['keterangan'] as String : null,
      status: map['status'] != null ? map['status'] as bool : null,
      masuk: map['masuk'] != null ? DateTime.fromMillisecondsSinceEpoch(map['masuk'] as int) : null,
      user: map['user'] != null ? map['user'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) => Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Customer(id: $id, nama: $nama, phone: $phone, ktp: $ktp, dob: $dob, keterangan: $keterangan, status: $status, masuk: $masuk, user: $user, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nama == nama &&
      other.phone == phone &&
      other.ktp == ktp &&
      other.dob == dob &&
      other.keterangan == keterangan &&
      other.status == status &&
      other.masuk == masuk &&
      other.user == user &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nama.hashCode ^
      phone.hashCode ^
      ktp.hashCode ^
      dob.hashCode ^
      keterangan.hashCode ^
      status.hashCode ^
      masuk.hashCode ^
      user.hashCode ^
      createdAt.hashCode;
  }
}
