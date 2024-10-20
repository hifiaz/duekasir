// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class PresenseModel {
  final int id;
  final int? user;
  final String? status;
  final String? note;
  final String? path;
  final double? long;
  final double? lat;
  final DateTime createdAt;
  final String? belong;
  PresenseModel({
    required this.id,
    this.user,
    this.status,
    this.note,
    this.path,
    this.long,
    this.lat,
    required this.createdAt,
    this.belong,
  });

  PresenseModel copyWith({
    int? id,
    int? user,
    String? status,
    String? note,
    String? path,
    double? long,
    double? lat,
    DateTime? createdAt,
    String? belong,
  }) {
    return PresenseModel(
      id: id ?? this.id,
      user: user ?? this.user,
      status: status ?? this.status,
      note: note ?? this.note,
      path: path ?? this.path,
      long: long ?? this.long,
      lat: lat ?? this.lat,
      createdAt: createdAt ?? this.createdAt,
      belong: belong ?? this.belong,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'status': status,
      'note': note,
      'path': path,
      'long': long,
      'lat': lat,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'belong': belong,
    };
  }

  factory PresenseModel.fromMap(Map<String, dynamic> map) {
    return PresenseModel(
      id: map['id'] as int,
      user: map['user'] != null ? map['user'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      path: map['path'] != null ? map['path'] as String : null,
      long: map['long'] != null ? map['long'] as double : null,
      lat: map['lat'] != null ? map['lat'] as double : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      belong: map['belong'] != null ? map['belong'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PresenseModel.fromJson(String source) => PresenseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PresenseModel(id: $id, user: $user, status: $status, note: $note, path: $path, long: $long, lat: $lat, createdAt: $createdAt, belong: $belong)';
  }

  @override
  bool operator ==(covariant PresenseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.user == user &&
      other.status == status &&
      other.note == note &&
      other.path == path &&
      other.long == long &&
      other.lat == lat &&
      other.createdAt == createdAt &&
      other.belong == belong;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user.hashCode ^
      status.hashCode ^
      note.hashCode ^
      path.hashCode ^
      long.hashCode ^
      lat.hashCode ^
      createdAt.hashCode ^
      belong.hashCode;
  }
}
