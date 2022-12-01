// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String displayName;
  final String email;
  final String id;
  final String profile;
  final String phoneNumber;
  final String fullName;
  final List<String> groupsCreated;
  final List<String> subGroupsJoined;
  const AppUser({
    required this.displayName,
    required this.email,
    required this.id,
    required this.profile,
    required this.phoneNumber,
    required this.fullName,
    this.groupsCreated = const [],
    this.subGroupsJoined = const [],
  });
  @override
  List<Object?> get props => [
        displayName,
        email,
        id,
        profile,
        phoneNumber,
        fullName,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'email': email,
      'id': id,
      'profile': profile,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'groupsCreated': groupsCreated,
      'subGroupsJoined': subGroupsJoined,
    };
  }

  factory AppUser.initial() => const AppUser(
        displayName: '',
        email: '',
        id: '',
        profile: '',
        phoneNumber: '',
        fullName: '',
        groupsCreated: [],
        subGroupsJoined: [],
      );

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
        displayName: map['displayName'] as String,
        email: map['email'] as String,
        id: map['id'] as String,
        profile: map['profile'] as String,
        phoneNumber: map['phoneNumber'] as String,
        fullName: map['fullName'] as String,
        subGroupsJoined:
            List<String>.from((map['subGroupsJoined'] as List<dynamic>)),
        groupsCreated: List<String>.from(
          (map['groupsCreated'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
