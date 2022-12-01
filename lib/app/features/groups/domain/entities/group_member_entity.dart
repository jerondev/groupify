// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class GroupMemberEntity extends Equatable {
  final String id;
  final String phoneNumber;
  final String name;
  final String email;
  final String profile;
  const GroupMemberEntity({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.profile,
  });

  @override
  List<Object> get props => [id, phoneNumber, name, email, profile];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'profile': profile,
    };
  }

  factory GroupMemberEntity.fromMap(Map<String, dynamic> map) {
    return GroupMemberEntity(
      id: map['id'] as String,
      phoneNumber: map['phoneNumber'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profile: map['profile'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupMemberEntity.fromJson(String source) =>
      GroupMemberEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
