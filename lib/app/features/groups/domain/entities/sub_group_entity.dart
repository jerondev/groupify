// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_member_entity.dart';

class SubGroupEntity extends Equatable {
  final String id;
  final String name;
  final int capacity;
  final List<GroupMemberEntity> members;
  const SubGroupEntity({
    required this.id,
    required this.name,
    required this.capacity,
    required this.members,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      capacity,
      members,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'capacity': capacity,
      'members': members.map((x) => x.toMap()).toList(),
    };
  }

  // check if the user is already in the group
  // getter for isMember
  bool get isMember {
    return members
        .any((member) => member.id == FirebaseAuth.instance.currentUser!.uid);
  }

  factory SubGroupEntity.initial() {
    return const SubGroupEntity(id: '', name: '', capacity: 0, members: []);
  }

  factory SubGroupEntity.fromMap(Map<String, dynamic> map) {
    return SubGroupEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      capacity: map['capacity'] as int,
      members: List<GroupMemberEntity>.from(
        (map['members'] as List<dynamic>).map<GroupMemberEntity>(
          (x) => GroupMemberEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubGroupEntity.fromJson(String source) =>
      SubGroupEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
