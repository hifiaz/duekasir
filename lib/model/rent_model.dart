// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Rent {
  final int id;
  final String? name;
  final int? item;
  final String? note;
  final int? amount;
  final int? pinalty;
  final bool? identity;
  final bool? picture;
  final DateTime? rentDate;
  final bool? paid;
  final String? user;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int? howManyDay;
  Rent({
    required this.id,
    this.name,
    this.item,
    this.note,
    this.amount,
    this.pinalty,
    this.identity,
    this.picture,
    this.rentDate,
    this.paid,
    this.user,
    required this.createdAt,
    this.updatedAt,
    this.howManyDay,
  });

  Rent copyWith({
    int? id,
    String? name,
    int? item,
    String? note,
    int? amount,
    int? pinalty,
    bool? identity,
    bool? picture,
    DateTime? rentDate,
    bool? paid,
    String? user,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? howManyDay,
  }) {
    return Rent(
      id: id ?? this.id,
      name: name ?? this.name,
      item: item ?? this.item,
      note: note ?? this.note,
      amount: amount ?? this.amount,
      pinalty: pinalty ?? this.pinalty,
      identity: identity ?? this.identity,
      picture: picture ?? this.picture,
      rentDate: rentDate ?? this.rentDate,
      paid: paid ?? this.paid,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      howManyDay: howManyDay ?? this.howManyDay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'item': item,
      'note': note,
      'amount': amount,
      'pinalty': pinalty,
      'identity': identity,
      'picture': picture,
      'rentDate': rentDate?.millisecondsSinceEpoch,
      'paid': paid,
      'user': user,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'howManyDay': howManyDay,
    };
  }

  factory Rent.fromMap(Map<String, dynamic> map) {
    return Rent(
      id: map['id'] as int,
      name: map['name'] != null ? map['name'] as String : null,
      item: map['item'] != null ? map['item'] as int : null,
      note: map['note'] != null ? map['note'] as String : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
      pinalty: map['pinalty'] != null ? map['pinalty'] as int : null,
      identity: map['identity'] != null ? map['identity'] as bool : null,
      picture: map['picture'] != null ? map['picture'] as bool : null,
      rentDate: map['rentDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['rentDate'] as int) : null,
      paid: map['paid'] != null ? map['paid'] as bool : null,
      user: map['user'] != null ? map['user'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int) : null,
      howManyDay: map['howManyDay'] != null ? map['howManyDay'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rent.fromJson(String source) => Rent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Rent(id: $id, name: $name, item: $item, note: $note, amount: $amount, pinalty: $pinalty, identity: $identity, picture: $picture, rentDate: $rentDate, paid: $paid, user: $user, createdAt: $createdAt, updatedAt: $updatedAt, howManyDay: $howManyDay)';
  }

  @override
  bool operator ==(covariant Rent other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.item == item &&
      other.note == note &&
      other.amount == amount &&
      other.pinalty == pinalty &&
      other.identity == identity &&
      other.picture == picture &&
      other.rentDate == rentDate &&
      other.paid == paid &&
      other.user == user &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.howManyDay == howManyDay;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      item.hashCode ^
      note.hashCode ^
      amount.hashCode ^
      pinalty.hashCode ^
      identity.hashCode ^
      picture.hashCode ^
      rentDate.hashCode ^
      paid.hashCode ^
      user.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      howManyDay.hashCode;
  }
}
