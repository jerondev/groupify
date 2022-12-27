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
  final bool isAnonymous;
  const AppUser({
    required this.displayName,
    required this.email,
    required this.id,
    required this.profile,
    required this.phoneNumber,
    required this.fullName,
    this.isAnonymous = false,
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
      'isAnonymous': isAnonymous,
    };
  }

  String get avatar => isAnonymous
      ? 'https://avatars.dicebear.com/api/adventurer/$fullName.png'
      : profile;

  factory AppUser.initial() => const AppUser(
        displayName: '',
        email: '',
        id: '',
        profile:
            'https://images.unsplash.com/photo-1671017437423-4e74b08cde85?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1664&q=80',
        phoneNumber: '',
        fullName: '',
        isAnonymous: false,
      );

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      displayName: map['displayName'] as String,
      email: map['email'] as String,
      id: map['id'] as String,
      profile: map['profile'] as String,
      phoneNumber: map['phoneNumber'] as String,
      fullName: map['fullName'] as String,
      isAnonymous: map['isAnonymous'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
