// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Salary {
  final int id;
  final int? userId;
  final String? status;
  final String? periode;
  final List<ItemSalary>? items;
  final List<ItemSalary>? deductions;
  final int? total;
  final String? note;
  final DateTime? createdAt;
  final String? user;
  final String? management;
  Salary({
    required this.id,
    this.userId,
    this.status,
    this.periode,
    this.items,
    this.deductions,
    this.total,
    this.note,
    this.createdAt,
    this.user,
    this.management,
  });

  Salary copyWith({
    int? id,
    int? userId,
    String? status,
    String? periode,
    List<ItemSalary>? items,
    List<ItemSalary>? deductions,
    int? total,
    String? note,
    DateTime? createdAt,
    String? user,
    String? management,
  }) {
    return Salary(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      periode: periode ?? this.periode,
      items: items ?? this.items,
      deductions: deductions ?? this.deductions,
      total: total ?? this.total,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
      management: management ?? this.management,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'status': status,
      'periode': periode,
      'items': items?.map((x) => x.toMap()).toList(),
      'deductions': deductions?.map((x) => x.toMap()).toList(),
      'total': total,
      'note': note,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'user': user,
      'management': management,
    };
  }

  factory Salary.fromMap(Map<String, dynamic> map) {
    return Salary(
      id: map['id'] as int,
      userId: map['userId'] != null ? map['userId'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      periode: map['periode'] != null ? map['periode'] as String : null,
      items: map['items'] != null
          ? List<ItemSalary>.from(
              (map['items'] as List<int>).map<ItemSalary?>(
                (x) => ItemSalary.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      deductions: map['deductions'] != null
          ? List<ItemSalary>.from(
              (map['deductions'] as List<int>).map<ItemSalary?>(
                (x) => ItemSalary.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      total: map['total'] != null ? map['total'] as int : null,
      note: map['note'] != null ? map['note'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      user: map['user'] != null ? map['user'] as String : null,
      management:
          map['management'] != null ? map['management'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Salary.fromJson(String source) =>
      Salary.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Salary(id: $id, userId: $userId, status: $status, periode: $periode, items: $items, deductions: $deductions, total: $total, note: $note, createdAt: $createdAt, user: $user, management: $management)';
  }

  @override
  bool operator ==(covariant Salary other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.status == status &&
        other.periode == periode &&
        listEquals(other.items, items) &&
        listEquals(other.deductions, deductions) &&
        other.total == total &&
        other.note == note &&
        other.createdAt == createdAt &&
        other.user == user &&
        other.management == management;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        status.hashCode ^
        periode.hashCode ^
        items.hashCode ^
        deductions.hashCode ^
        total.hashCode ^
        note.hashCode ^
        createdAt.hashCode ^
        user.hashCode ^
        management.hashCode;
  }
}

class ItemSalary {
  int? id;
  String? description;
  String? amount;
  ItemSalary({
    this.id,
    this.description,
    this.amount,
  });

  ItemSalary copyWith({
    int? id,
    String? description,
    String? amount,
  }) {
    return ItemSalary(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'amount': amount,
    };
  }

  factory ItemSalary.fromMap(Map<String, dynamic> map) {
    return ItemSalary(
      id: map['id'] != null ? map['id'] as int : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemSalary.fromJson(String source) =>
      ItemSalary.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ItemSalary(id: $id, description: $description, amount: $amount)';

  @override
  bool operator ==(covariant ItemSalary other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        other.amount == amount;
  }

  @override
  int get hashCode => id.hashCode ^ description.hashCode ^ amount.hashCode;
}
