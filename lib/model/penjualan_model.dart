// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:due_kasir/model/inventory_model.dart';

class Report {
  final int id;
  final List<Inventory> items;
  final int? totalItem;
  final double? totalHarga;
  final double? diskon;
  final int? kasir;
  final int? pembeli;
  final String? keterangan;
  final DateTime createdAt;
  final String? user;
  Report({
    required this.id,
    required this.items,
    this.totalItem,
    this.totalHarga,
    this.diskon,
    this.kasir,
    this.pembeli,
    this.keterangan,
    required this.createdAt,
    this.user,
  });

  Report copyWith({
    int? id,
    List<Inventory>? items,
    int? totalItem,
    double? totalHarga,
    double? diskon,
    int? kasir,
    int? pembeli,
    String? keterangan,
    DateTime? createdAt,
    String? user,
  }) {
    return Report(
      id: id ?? this.id,
      items: items ?? this.items,
      totalItem: totalItem ?? this.totalItem,
      totalHarga: totalHarga ?? this.totalHarga,
      diskon: diskon ?? this.diskon,
      kasir: kasir ?? this.kasir,
      pembeli: pembeli ?? this.pembeli,
      keterangan: keterangan ?? this.keterangan,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'items': items.map((x) => x.toMap()).toList(),
      'totalItem': totalItem,
      'totalHarga': totalHarga,
      'diskon': diskon,
      'kasir': kasir,
      'pembeli': pembeli,
      'keterangan': keterangan,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'user': user,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'] as int,
      items: List<Inventory>.from(
        (map['items'] as List<int>).map<Inventory>(
          (x) => Inventory.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalItem: map['totalItem'] != null ? map['totalItem'] as int : null,
      totalHarga:
          map['totalHarga'] != null ? map['totalHarga'] as double : null,
      diskon: map['diskon'] != null ? map['diskon'] as double : null,
      kasir: map['kasir'] != null ? map['kasir'] as int : null,
      pembeli: map['pembeli'] != null ? map['pembeli'] as int : null,
      keterangan:
          map['keterangan'] != null ? map['keterangan'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      user: map['user'] != null ? map['user'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) =>
      Report.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Report(id: $id, items: $items, totalItem: $totalItem, totalHarga: $totalHarga, diskon: $diskon, kasir: $kasir, pembeli: $pembeli, keterangan: $keterangan, createdAt: $createdAt, user: $user)';
  }

  @override
  bool operator ==(covariant Report other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.items, items) &&
        other.totalItem == totalItem &&
        other.totalHarga == totalHarga &&
        other.diskon == diskon &&
        other.kasir == kasir &&
        other.pembeli == pembeli &&
        other.keterangan == keterangan &&
        other.createdAt == createdAt &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        items.hashCode ^
        totalItem.hashCode ^
        totalHarga.hashCode ^
        diskon.hashCode ^
        kasir.hashCode ^
        pembeli.hashCode ^
        keterangan.hashCode ^
        createdAt.hashCode ^
        user.hashCode;
  }
}
