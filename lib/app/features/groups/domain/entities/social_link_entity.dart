// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SocialLinkEntity extends Equatable {
  final String link;
  final String type;
  final String authorId;
  final String authorName;
  const SocialLinkEntity({
    required this.link,
    required this.type,
    required this.authorId,
    required this.authorName,
  });

  @override
  List<Object?> get props => [link, type];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'link': link,
      'type': type,
      'authorId': authorId,
      'authorName': authorName,
    };
  }

  factory SocialLinkEntity.fromMap(Map<String, dynamic> map) {
    return SocialLinkEntity(
      link: map['link'] as String,
      type: map['type'] as String,
      authorId: map['authorId'] as String,
      authorName: map['authorName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialLinkEntity.fromJson(String source) =>
      SocialLinkEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
