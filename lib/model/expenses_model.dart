// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Expenses {
  final int id;
  final String? title;
  final String? note;
  final int? amount;
  final DateTime createdAt;
  final String? user;
  Expenses({
    required this.id,
    this.title,
    this.note,
    this.amount,
    required this.createdAt,
    this.user,
  });

  Expenses copyWith({
    int? id,
    String? title,
    String? note,
    int? amount,
    DateTime? createdAt,
    String? user,
  }) {
    return Expenses(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'note': note,
      'amount': amount,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'user': user,
    };
  }

  factory Expenses.fromMap(Map<String, dynamic> map) {
    return Expenses(
      id: map['id'] as int,
      title: map['title'] != null ? map['title'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      user: map['user'] != null ? map['user'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expenses.fromJson(String source) => Expenses.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expenses(id: $id, title: $title, note: $note, amount: $amount, createdAt: $createdAt, user: $user)';
  }

  @override
  bool operator ==(covariant Expenses other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.note == note &&
      other.amount == amount &&
      other.createdAt == createdAt &&
      other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      note.hashCode ^
      amount.hashCode ^
      createdAt.hashCode ^
      user.hashCode;
  }
}
