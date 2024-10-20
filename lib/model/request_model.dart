// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Request {
  final int id;
  final String? note;
  final DateTime createdAt;
  final String? user;
  final String? status;
  final String? title;
  Request({
    required this.id,
    this.note,
    required this.createdAt,
    this.user,
    this.status,
    this.title,
  });

  Request copyWith({
    int? id,
    String? note,
    DateTime? createdAt,
    String? user,
    String? status,
    String? title,
  }) {
    return Request(
      id: id ?? this.id,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
      status: status ?? this.status,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'note': note,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'user': user,
      'status': status,
      'title': title,
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      id: map['id'] as int,
      note: map['note'] != null ? map['note'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      user: map['user'] != null ? map['user'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Request.fromJson(String source) => Request.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Request(id: $id, note: $note, createdAt: $createdAt, user: $user, status: $status, title: $title)';
  }

  @override
  bool operator ==(covariant Request other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.note == note &&
      other.createdAt == createdAt &&
      other.user == user &&
      other.status == status &&
      other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      note.hashCode ^
      createdAt.hashCode ^
      user.hashCode ^
      status.hashCode ^
      title.hashCode;
  }
}
