// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SubGroupEntity extends Equatable {
  final String id;
  final String name;
  final int capacity;
  final List<String> members;
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
      'members': members,
    };
  }

  factory SubGroupEntity.fromMap(Map<String, dynamic> map) {
    return SubGroupEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      capacity: map['capacity'] as int,
      members: List<String>.from(
        (map['members'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubGroupEntity.fromJson(String source) =>
      SubGroupEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  SubGroupEntity copyWith({
    String? id,
    String? name,
    int? totalPeople,
    int? capacity,
    List<String>? members,
  }) {
    return SubGroupEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      capacity: capacity ?? this.capacity,
      members: members ?? this.members,
    );
  }

  @override
  bool get stringify => true;
}
