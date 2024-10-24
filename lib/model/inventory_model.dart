// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Inventory {
  int id;
  String? nama;
  String? code;
  String? deskripsi;
  int? jumlahBarang;
  int? quantity;
  String? ukuran;
  int? hargaDasar;
  int? hargaJual;
  int? hargaJualPersen;
  int? diskonPersen;
  bool? isHargaJualPersen;
  DateTime? barangMasuk;
  DateTime? barangKeluar;
  String? createdAt;
  String? user;
  Inventory({
    required this.id,
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
    this.user,
  });

  Inventory copyWith({
    int? id,
    String? nama,
    String? code,
    String? deskripsi,
    int? jumlahBarang,
    int? quantity,
    String? ukuran,
    int? hargaDasar,
    int? hargaJual,
    int? hargaJualPersen,
    int? diskonPersen,
    bool? isHargaJualPersen,
    DateTime? barangMasuk,
    DateTime? barangKeluar,
    String? createdAt,
    String? user,
  }) {
    return Inventory(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      code: code ?? this.code,
      deskripsi: deskripsi ?? this.deskripsi,
      jumlahBarang: jumlahBarang ?? this.jumlahBarang,
      quantity: quantity ?? this.quantity,
      ukuran: ukuran ?? this.ukuran,
      hargaDasar: hargaDasar ?? this.hargaDasar,
      hargaJual: hargaJual ?? this.hargaJual,
      hargaJualPersen: hargaJualPersen ?? this.hargaJualPersen,
      diskonPersen: diskonPersen ?? this.diskonPersen,
      isHargaJualPersen: isHargaJualPersen ?? this.isHargaJualPersen,
      barangMasuk: barangMasuk ?? this.barangMasuk,
      barangKeluar: barangKeluar ?? this.barangKeluar,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
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
      'barangMasuk': barangMasuk?.millisecondsSinceEpoch,
      'barangKeluar': barangKeluar?.millisecondsSinceEpoch,
      'createdAt': createdAt,
      'user': user,
    };
  }

  factory Inventory.fromMap(Map<String, dynamic> map) {
    return Inventory(
      id: map['id'] as int,
      nama: map['nama'] != null ? map['nama'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      deskripsi: map['deskripsi'] != null ? map['deskripsi'] as String : null,
      jumlahBarang: map['jumlahBarang'] != null ? map['jumlahBarang'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      ukuran: map['ukuran'] != null ? map['ukuran'] as String : null,
      hargaDasar: map['hargaDasar'] != null ? map['hargaDasar'] as int : null,
      hargaJual: map['hargaJual'] != null ? map['hargaJual'] as int : null,
      hargaJualPersen: map['hargaJualPersen'] != null ? map['hargaJualPersen'] as int : null,
      diskonPersen: map['diskonPersen'] != null ? map['diskonPersen'] as int : null,
      isHargaJualPersen: map['isHargaJualPersen'] != null ? map['isHargaJualPersen'] as bool : null,
      barangMasuk: map['barangMasuk'] != null ? DateTime.fromMillisecondsSinceEpoch(map['barangMasuk'] as int) : null,
      barangKeluar: map['barangKeluar'] != null ? DateTime.fromMillisecondsSinceEpoch(map['barangKeluar'] as int) : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      user: map['user'] != null ? map['user'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Inventory.fromJson(String source) => Inventory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Inventory(id: $id, nama: $nama, code: $code, deskripsi: $deskripsi, jumlahBarang: $jumlahBarang, quantity: $quantity, ukuran: $ukuran, hargaDasar: $hargaDasar, hargaJual: $hargaJual, hargaJualPersen: $hargaJualPersen, diskonPersen: $diskonPersen, isHargaJualPersen: $isHargaJualPersen, barangMasuk: $barangMasuk, barangKeluar: $barangKeluar, createdAt: $createdAt, user: $user)';
  }

  @override
  bool operator ==(covariant Inventory other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nama == nama &&
      other.code == code &&
      other.deskripsi == deskripsi &&
      other.jumlahBarang == jumlahBarang &&
      other.quantity == quantity &&
      other.ukuran == ukuran &&
      other.hargaDasar == hargaDasar &&
      other.hargaJual == hargaJual &&
      other.hargaJualPersen == hargaJualPersen &&
      other.diskonPersen == diskonPersen &&
      other.isHargaJualPersen == isHargaJualPersen &&
      other.barangMasuk == barangMasuk &&
      other.barangKeluar == barangKeluar &&
      other.createdAt == createdAt &&
      other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nama.hashCode ^
      code.hashCode ^
      deskripsi.hashCode ^
      jumlahBarang.hashCode ^
      quantity.hashCode ^
      ukuran.hashCode ^
      hargaDasar.hashCode ^
      hargaJual.hashCode ^
      hargaJualPersen.hashCode ^
      diskonPersen.hashCode ^
      isHargaJualPersen.hashCode ^
      barangMasuk.hashCode ^
      barangKeluar.hashCode ^
      createdAt.hashCode ^
      user.hashCode;
  }
}
