// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SocialLinkEntity extends Equatable {
  final String link;
  final String type;
  const SocialLinkEntity({
    required this.link,
    required this.type,
  });

  @override
  List<Object?> get props => [link, type];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'link': link,
      'name': type,
    };
  }

  factory SocialLinkEntity.fromMap(Map<String, dynamic> map) {
    return SocialLinkEntity(
      link: map['link'] as String,
      type: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialLinkEntity.fromJson(String source) =>
      SocialLinkEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
