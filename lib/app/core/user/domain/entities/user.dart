import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  final String displayName;
  final String email;
  final String id;
  final String profile;
  final String phoneNumber;
  final String fullName;
  AppUser({
    required this.displayName,
    required this.email,
    required this.id,
    required this.profile,
    required this.phoneNumber,
    required this.fullName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'email': email,
      'id': id,
      'profile': profile,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      displayName: map['displayName'] as String,
      email: map['email'] as String,
      id: map['id'] as String,
      profile: map['profile'] as String,
      phoneNumber: map['phoneNumber'] as String,
      fullName: map['fullName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
