// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:groupify/app/core/user/domain/entities/user.dart';

class Community extends Equatable {
  final String id;
  final String ownerId;
  final String name;
  final String description;
  final String avatar;
  final List<AppUser> members;
  final DateTime createdAt;

  const Community({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.avatar,
    required this.members,
    required this.createdAt,
  });

  factory Community.initial() {
    return Community(
      id: "",
      name: "",
      avatar: "",
      description: "",
      members: const [],
      ownerId: "",
      createdAt: DateTime.now(),
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      ownerId,
      name,
      description,
      avatar,
      members,
      createdAt,
    ];
  }

  Community copyWith({
    String? id,
    String? ownerId,
    String? name,
    String? description,
    String? avatar,
    List<AppUser>? members,
    DateTime? createdAt,
  }) {
    return Community(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      description: description ?? this.description,
      avatar: avatar ?? this.avatar,
      members: members ?? this.members,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ownerId': ownerId,
      'name': name,
      'description': description,
      'avatar': avatar,
      'members': members.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Community.fromMap(Map<String, dynamic> map) {
    return Community(
      id: map['id'] as String,
      ownerId: map['ownerId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      avatar: map['avatar'] as String,
      members: List<AppUser>.from(
        (map['members'] as List<int>).map<AppUser>(
          (x) => AppUser.fromMap(x as Map<String, dynamic>),
        ),
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Community.fromJson(String source) =>
      Community.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
