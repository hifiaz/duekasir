// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DuePayment {
  final int id;
  final String? name;
  final String? invoice;
  final String? itemName;
  final int? itemAmount;
  final int? amount;
  final String? status;
  final String? note;
  final DateTime? dateIn;
  final DateTime? dueDate;
  final DateTime? createdAt;
  final String? user;
  DuePayment({
    required this.id,
    this.name,
    this.invoice,
    this.itemName,
    this.itemAmount,
    this.amount,
    this.status,
    this.note,
    this.dateIn,
    this.dueDate,
    this.createdAt,
    this.user,
  });

  DuePayment copyWith({
    int? id,
    String? name,
    String? invoice,
    String? itemName,
    int? itemAmount,
    int? amount,
    String? status,
    String? note,
    DateTime? dateIn,
    DateTime? dueDate,
    DateTime? createdAt,
    String? user,
  }) {
    return DuePayment(
      id: id ?? this.id,
      name: name ?? this.name,
      invoice: invoice ?? this.invoice,
      itemName: itemName ?? this.itemName,
      itemAmount: itemAmount ?? this.itemAmount,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      note: note ?? this.note,
      dateIn: dateIn ?? this.dateIn,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'invoice': invoice,
      'itemName': itemName,
      'itemAmount': itemAmount,
      'amount': amount,
      'status': status,
      'note': note,
      'dateIn': dateIn?.millisecondsSinceEpoch,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'user': user,
    };
  }

  factory DuePayment.fromMap(Map<String, dynamic> map) {
    return DuePayment(
      id: map['id'] as int,
      name: map['name'] != null ? map['name'] as String : null,
      invoice: map['invoice'] != null ? map['invoice'] as String : null,
      itemName: map['itemName'] != null ? map['itemName'] as String : null,
      itemAmount: map['itemAmount'] != null ? map['itemAmount'] as int : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      dateIn: map['dateIn'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateIn'] as int) : null,
      dueDate: map['dueDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int) : null,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
      user: map['user'] != null ? map['user'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DuePayment.fromJson(String source) => DuePayment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DuePayment(id: $id, name: $name, invoice: $invoice, itemName: $itemName, itemAmount: $itemAmount, amount: $amount, status: $status, note: $note, dateIn: $dateIn, dueDate: $dueDate, createdAt: $createdAt, user: $user)';
  }

  @override
  bool operator ==(covariant DuePayment other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.invoice == invoice &&
      other.itemName == itemName &&
      other.itemAmount == itemAmount &&
      other.amount == amount &&
      other.status == status &&
      other.note == note &&
      other.dateIn == dateIn &&
      other.dueDate == dueDate &&
      other.createdAt == createdAt &&
      other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      invoice.hashCode ^
      itemName.hashCode ^
      itemAmount.hashCode ^
      amount.hashCode ^
      status.hashCode ^
      note.hashCode ^
      dateIn.hashCode ^
      dueDate.hashCode ^
      createdAt.hashCode ^
      user.hashCode;
  }
}
