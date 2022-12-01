// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class GroupMemberEntity extends Equatable {
  final String id;
  final String phoneNumber;
  final String name;
  final String email;
  const GroupMemberEntity({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.email,
  });

  @override
  List<Object> get props => [id, phoneNumber, name, email];

  GroupMemberEntity copyWith({
    String? id,
    String? phoneNumber,
    String? name,
    String? email,
  }) {
    return GroupMemberEntity(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
    };
  }

  factory GroupMemberEntity.fromMap(Map<String, dynamic> map) {
    return GroupMemberEntity(
      id: map['id'] as String,
      phoneNumber: map['phoneNumber'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupMemberEntity.fromJson(String source) =>
      GroupMemberEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
