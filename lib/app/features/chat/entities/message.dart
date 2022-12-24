// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String authorId;
  final String groupId;
  final DateTime timestamp;
  final MessageType type;
  final String content;
  const MessageEntity({
    required this.authorId,
    required this.groupId,
    required this.timestamp,
    required this.type,
    required this.content,
  });

  @override
  List<Object> get props {
    return [
      authorId,
      groupId,
      timestamp,
      type,
      content,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authorId': authorId,
      'groupId': groupId,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'type': type.toMap(),
      'content': content,
    };
  }

  factory MessageEntity.fromMap(Map<String, dynamic> map) {
    return MessageEntity(
      authorId: map['authorId'] as String,
      groupId: map['groupId'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      type: MessageType.fromMap(map['type'] as Map<String, dynamic>),
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageEntity.fromJson(String source) =>
      MessageEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

class MessageType extends Equatable {
  final String type;
  const MessageType._(this.type);
  const MessageType.text() : this._('text');
  const MessageType.image() : this._('image');
  const MessageType.audio() : this._('audio');
  @override
  List<Object> get props => [type];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
    };
  }

  factory MessageType.fromMap(Map<String, dynamic> map) {
    return MessageType._(map['type'] as String);
  }

  String toJson() => json.encode(toMap());

  factory MessageType.fromJson(String source) =>
      MessageType.fromMap(json.decode(source) as Map<String, dynamic>);
}
