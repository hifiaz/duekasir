import 'dart:convert';

import 'package:isar/isar.dart';

part 'penjualan_model.g.dart';

@collection
class PenjualanModel {
  Id? id = Isar.autoIncrement;
  List<ProductItemModel> items = [];
  late int totalItem;
  late double totalHarga;
  late double diskon;
  late int kasir;
  int? pembeli;
  String? keterangan;
  DateTime createdAt = DateTime.now();

  PenjualanModel({
    this.id,
    required this.items,
    required this.totalItem,
    required this.totalHarga,
    required this.diskon,
    required this.kasir,
    this.pembeli,
    this.keterangan,
    required this.createdAt,
  });

  factory PenjualanModel.fromJson(json) {
    return PenjualanModel(
      id: json['id'],
      items: json['items'],
      totalItem: json['totalItem'],
      totalHarga: json['totalHarga'],
      diskon: json['diskon'],
      kasir: json['kasir'],
      pembeli: json['pembeli'],
      keterangan: json['keterangan'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'items': jsonEncode(items.map((e) => e.toJson()).toList()),
      'totalItem': totalItem,
      'totalHarga': totalHarga,
      'diskon': diskon,
      'kasir': kasir,
      'pembeli': pembeli,
      'keterangan': keterangan,
      'createdAt': createdAt.toIso8601String()
    };
  }
}

@embedded
class ProductItemModel {
  late int? id;
  late String? nama;
  late String? code;
  late String? deskripsi;
  late int? jumlahBarang;
  late int? quantity;
  late String? ukuran;
  late int? hargaDasar;
  late int? hargaJual;
  double? hargaJualPersen;
  double? diskonPersen;
  late bool? isHargaJualPersen;
  DateTime? barangMasuk;
  DateTime? barangKeluar;
  DateTime? createdAt;
  late bool? isSynced;

  ProductItemModel({
    this.id,
    this.nama,
    this.code,
    this.deskripsi,
    this.jumlahBarang,
    this.quantity,
    this.ukuran,
    this.hargaDasar,
    this.hargaJual,
    this.hargaJualPersen,
    this.diskonPersen,
    this.isHargaJualPersen,
    this.barangMasuk,
    this.barangKeluar,
    this.createdAt,
    this.isSynced,
  });

  factory ProductItemModel.fromJson(json) {
    return ProductItemModel(
        id: json['id'],
        nama: json['nama'],
        code: json['code'],
        deskripsi: json['deskripsi'],
        jumlahBarang: json['jumlahBarang'],
        quantity: json['quantity'],
        ukuran: json['ukuran'],
        hargaDasar: json['hargaDasar'],
        hargaJual: json['hargaJual'],
        hargaJualPersen: json['hargaJualPersen'],
        diskonPersen: json['diskonPersen'],
        isHargaJualPersen: json['isHargaJualPersen'],
        barangMasuk: json['barangMasuk'],
        barangKeluar: json['barangKeluar'],
        createdAt: json['createdAt'],
        isSynced: json['isSynced']);
  }

  toJson() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'code': code,
      'deskripsi': deskripsi,
      'jumlahBarang': jumlahBarang,
      'quantity': quantity,
      'ukuran': ukuran,
      'hargaDasar': hargaDasar,
      'hargaJual': hargaJual,
      'hargaJualPersen': hargaJualPersen,
      'diskonPersen': diskonPersen,
      'isHargaJualPersen': isHargaJualPersen,
      'barangMasuk': barangMasuk,
      'barangKeluar': barangKeluar,
      'createdAt': createdAt?.toIso8601String()
    };
  }
}
