// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_member_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/sub_group_entity.dart';

class GroupEntity extends Equatable {
  final String id;
  final String name;
  final int totalPeople;
  final int peoplePerGroup;
  final int totalGroups;
  final String createdBy;
  final List<GroupMemberEntity> members;
  final List<SubGroupEntity> subGroups;
  const GroupEntity({
    required this.id,
    required this.name,
    required this.totalPeople,
    required this.peoplePerGroup,
    required this.totalGroups,
    required this.createdBy,
    this.members = const [],
    required this.subGroups,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        totalPeople,
        peoplePerGroup,
        totalGroups,
        subGroups,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'totalPeople': totalPeople,
      'peoplePerGroup': peoplePerGroup,
      'totalGroups': totalGroups,
      'createdBy': createdBy,
      'members': members.map((x) => x.toMap()).toList(),
      'subGroups': subGroups.map((x) => x.toMap()).toList(),
    };
  }

  factory GroupEntity.initial() {
    return const GroupEntity(
      id: "",
      name: "",
      totalPeople: 0,
      peoplePerGroup: 0,
      totalGroups: 0,
      createdBy: "",
      subGroups: [],
      members: [],
    );
  }

  factory GroupEntity.fromMap(Map<String, dynamic> map) {
    return GroupEntity(
        id: map['id'] as String,
        name: map['name'] as String,
        totalPeople: map['totalPeople'] as int,
        peoplePerGroup: map['peoplePerGroup'] as int,
        totalGroups: map['totalGroups'] as int,
        createdBy: map['createdBy'] as String,
        members: List<GroupMemberEntity>.from(
          (map['members'] as List<GroupMemberEntity>).map<GroupMemberEntity>(
            (GroupMemberEntity x) => GroupMemberEntity.fromMap(x.toMap()),
          ),
        ),
        subGroups: List<SubGroupEntity>.from(
          (map['subGroups'] as List<dynamic>).map<SubGroupEntity>(
            (dynamic x) => SubGroupEntity.fromMap(x.toMap()),
          ),
        ));
  }

  String toJson() => json.encode(toMap());

  factory GroupEntity.fromJson(String source) =>
      GroupEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  GroupEntity copyWith({
    String? id,
    String? name,
    int? totalPeople,
    int? peoplePerGroup,
    int? totalGroups,
    String? createdBy,
    List<GroupMemberEntity>? members,
    List<SubGroupEntity>? subGroups,
  }) {
    return GroupEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      totalPeople: totalPeople ?? this.totalPeople,
      peoplePerGroup: peoplePerGroup ?? this.peoplePerGroup,
      totalGroups: totalGroups ?? this.totalGroups,
      createdBy: createdBy ?? this.createdBy,
      members: members ?? this.members,
      subGroups: subGroups ?? this.subGroups,
    );
  }
}
