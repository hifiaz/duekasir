// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RentItems {
  final int id;
  final String? name;
  final String? code;
  final String? note;
  final int? jumlahBarang;
  final int? rentThreeDay;
  final int? rentOneWeek;
  final int? rentOneMonth;
  final String? user;
  final String? createdAt;
  RentItems({
    required this.id,
    this.name,
    this.code,
    this.note,
    this.jumlahBarang,
    this.rentThreeDay,
    this.rentOneWeek,
    this.rentOneMonth,
    this.user,
    this.createdAt,
  });

  RentItems copyWith({
    int? id,
    String? name,
    String? code,
    String? note,
    int? jumlahBarang,
    int? rentThreeDay,
    int? rentOneWeek,
    int? rentOneMonth,
    String? user,
    String? createdAt,
  }) {
    return RentItems(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      note: note ?? this.note,
      jumlahBarang: jumlahBarang ?? this.jumlahBarang,
      rentThreeDay: rentThreeDay ?? this.rentThreeDay,
      rentOneWeek: rentOneWeek ?? this.rentOneWeek,
      rentOneMonth: rentOneMonth ?? this.rentOneMonth,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'note': note,
      'jumlahBarang': jumlahBarang,
      'rentThreeDay': rentThreeDay,
      'rentOneWeek': rentOneWeek,
      'rentOneMonth': rentOneMonth,
      'user': user,
      'createdAt': createdAt,
    };
  }

  factory RentItems.fromMap(Map<String, dynamic> map) {
    return RentItems(
      id: map['id'] as int,
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      jumlahBarang:
          map['jumlahBarang'] != null ? map['jumlahBarang'] as int : null,
      rentThreeDay:
          map['rentThreeDay'] != null ? map['rentThreeDay'] as int : null,
      rentOneWeek:
          map['rentOneWeek'] != null ? map['rentOneWeek'] as int : null,
      rentOneMonth:
          map['rentOneMonth'] != null ? map['rentOneMonth'] as int : null,
      user: map['user'] != null ? map['user'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RentItems.fromJson(String source) =>
      RentItems.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RentItems(id: $id, name: $name, code: $code, note: $note, jumlahBarang: $jumlahBarang, rentThreeDay: $rentThreeDay, rentOneWeek: $rentOneWeek, rentOneMonth: $rentOneMonth, user: $user, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant RentItems other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.code == code &&
        other.note == note &&
        other.jumlahBarang == jumlahBarang &&
        other.rentThreeDay == rentThreeDay &&
        other.rentOneWeek == rentOneWeek &&
        other.rentOneMonth == rentOneMonth &&
        other.user == user &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        code.hashCode ^
        note.hashCode ^
        jumlahBarang.hashCode ^
        rentThreeDay.hashCode ^
        rentOneWeek.hashCode ^
        rentOneMonth.hashCode ^
        user.hashCode ^
        createdAt.hashCode;
  }
}
