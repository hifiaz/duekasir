// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class StoreModel {
  final int id;
  final String title;
  final String? description;
  final String? phone;
  final String? footer;
  final String? subFooter;
  final String? user;
  StoreModel({
    required this.id,
    required this.title,
    this.description,
    this.phone,
    this.footer,
    this.subFooter,
    this.user,
  });

  StoreModel copyWith({
    int? id,
    String? title,
    String? description,
    String? phone,
    String? footer,
    String? subFooter,
    String? user,
  }) {
    return StoreModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      footer: footer ?? this.footer,
      subFooter: subFooter ?? this.subFooter,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'phone': phone,
      'footer': footer,
      'subFooter': subFooter,
      'user': user,
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      footer: map['footer'] != null ? map['footer'] as String : null,
      subFooter: map['subFooter'] != null ? map['subFooter'] as String : null,
      user: map['user'] != null ? map['user'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreModel.fromJson(String source) => StoreModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StoreModel(id: $id, title: $title, description: $description, phone: $phone, footer: $footer, subFooter: $subFooter, user: $user)';
  }

  @override
  bool operator ==(covariant StoreModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.phone == phone &&
      other.footer == footer &&
      other.subFooter == subFooter &&
      other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      phone.hashCode ^
      footer.hashCode ^
      subFooter.hashCode ^
      user.hashCode;
  }
}
