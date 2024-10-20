// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Users {
  int id;
  final String nama;
  final DateTime? dob;
  final String? keterangan;
  final bool? status;
  final DateTime? masuk;
  final DateTime? createdAt;
  final String? user;
  Users({
    required this.id,
    required this.nama,
    this.dob,
    this.keterangan,
    this.status,
    this.masuk,
    this.createdAt,
    this.user,
  });

  Users copyWith({
    int? id,
    String? nama,
    DateTime? dob,
    String? keterangan,
    bool? status,
    DateTime? masuk,
    DateTime? createdAt,
    String? user,
  }) {
    return Users(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      dob: dob ?? this.dob,
      keterangan: keterangan ?? this.keterangan,
      status: status ?? this.status,
      masuk: masuk ?? this.masuk,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'dob': dob?.millisecondsSinceEpoch,
      'keterangan': keterangan,
      'status': status,
      'masuk': masuk?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'user': user,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] as int,
      nama: map['nama'] as String,
      dob: map['dob'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dob'] as int) : null,
      keterangan: map['keterangan'] != null ? map['keterangan'] as String : null,
      status: map['status'] != null ? map['status'] as bool : null,
      masuk: map['masuk'] != null ? DateTime.fromMillisecondsSinceEpoch(map['masuk'] as int) : null,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
      user: map['user'] != null ? map['user'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Users(id: $id, nama: $nama, dob: $dob, keterangan: $keterangan, status: $status, masuk: $masuk, createdAt: $createdAt, user: $user)';
  }

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nama == nama &&
      other.dob == dob &&
      other.keterangan == keterangan &&
      other.status == status &&
      other.masuk == masuk &&
      other.createdAt == createdAt &&
      other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nama.hashCode ^
      dob.hashCode ^
      keterangan.hashCode ^
      status.hashCode ^
      masuk.hashCode ^
      createdAt.hashCode ^
      user.hashCode;
  }
}
