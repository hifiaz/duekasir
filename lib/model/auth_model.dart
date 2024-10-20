// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:due_kasir/model/user_model.dart';

class AuthModel {
  Users? user;
  AuthModel({
    this.user,
  });

  AuthModel copyWith({
    Users? user,
  }) {
    return AuthModel(
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      user: map['user'] != null
          ? Users.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthModel(user: $user)';

  @override
  bool operator ==(covariant AuthModel other) {
    if (identical(this, other)) return true;

    return other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}
