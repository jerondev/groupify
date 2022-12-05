// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';

class MemberEntity extends AppUser with EquatableMixin {
  final DateTime joinedAt;
  const MemberEntity({
    required String id,
    required String phoneNumber,
    required String fullName,
    required String email,
    required String profile,
    required String displayName,
    required this.joinedAt,
  }) : super(
          displayName: displayName,
          email: email,
          id: id,
          fullName: fullName,
          phoneNumber: phoneNumber,
          profile: profile,
        );

  @override
  List<Object> get props => [
        id,
        phoneNumber,
        fullName,
        email,
        profile,
        displayName,
        joinedAt,
      ];

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'email': email,
      'profile': profile,
      'displayName': displayName,
      'joinedAt': joinedAt.millisecondsSinceEpoch,
    };
  }

  factory MemberEntity.fromMap(Map<String, dynamic> map) {
    return MemberEntity(
      id: map['id'] as String,
      phoneNumber: map['phoneNumber'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      profile: map['profile'] as String,
      displayName: map['displayName'] as String,
      joinedAt: DateTime.fromMillisecondsSinceEpoch(map['joinedAt'] as int),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory MemberEntity.fromJson(String source) =>
      MemberEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
