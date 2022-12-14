// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CommunityEntity extends Equatable {
  final String id;
  final String name;
  final int totalPeople;
  final int peoplePerGroup;
  final int totalGroups;
  final String createdBy;
  final String description;
  final bool isAnonymous;
  const CommunityEntity({
    required this.id,
    required this.name,
    required this.totalPeople,
    required this.peoplePerGroup,
    required this.totalGroups,
    required this.createdBy,
    required this.description,
    required this.isAnonymous,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        totalPeople,
        peoplePerGroup,
        totalGroups,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'totalPeople': totalPeople,
      'peoplePerGroup': peoplePerGroup,
      'totalGroups': totalGroups,
      'createdBy': createdBy,
      'description': description,
      "isAnonymous": isAnonymous,
    };
  }

  factory CommunityEntity.initial() {
    return const CommunityEntity(
      id: "",
      name: "",
      totalPeople: 0,
      peoplePerGroup: 0,
      totalGroups: 0,
      createdBy: "",
      description: "",
      isAnonymous: false,
    );
  }

  factory CommunityEntity.fromMap(Map<String, dynamic> map) {
    return CommunityEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      totalPeople: map['totalPeople'] as int,
      peoplePerGroup: map['peoplePerGroup'] as int,
      totalGroups: map['totalGroups'] as int,
      createdBy: map['createdBy'] as String,
      description: map['description'] as String,
      isAnonymous: map['isAnonymous'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommunityEntity.fromJson(String source) =>
      CommunityEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  CommunityEntity copyWith({
    String? id,
    String? name,
    int? totalPeople,
    int? peoplePerGroup,
    int? totalGroups,
    String? createdBy,
    String? description,
    bool? isAnonymous,
  }) {
    return CommunityEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      totalPeople: totalPeople ?? this.totalPeople,
      peoplePerGroup: peoplePerGroup ?? this.peoplePerGroup,
      totalGroups: totalGroups ?? this.totalGroups,
      createdBy: createdBy ?? this.createdBy,
      description: description ?? this.description,
      isAnonymous: isAnonymous ?? this.isAnonymous,
    );
  }
}
