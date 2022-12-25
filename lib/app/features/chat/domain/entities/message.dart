// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import "package:intl/intl.dart";
import 'package:organizer_client/app/core/user/domain/entities/user.dart';

class MessageEntity extends Equatable {
  final AppUser sender;
  final String groupId;
  final DateTime timestamp;
  final MessageType type;
  final String content;
  const MessageEntity({
    required this.sender,
    required this.groupId,
    required this.timestamp,
    required this.type,
    required this.content,
  });

  @override
  List<Object> get props {
    return [
      sender,
      groupId,
      timestamp,
      type,
      content,
    ];
  }

  String get formattedDate {
    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(timestamp);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender.toMap(),
      'groupId': groupId,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'type': type.toMap(),
      'content': content,
    };
  }

  factory MessageEntity.fromMap(Map<String, dynamic> map) {
    return MessageEntity(
      sender: AppUser.fromMap(map['sender'] as Map<String, dynamic>),
      groupId: map['groupId'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      type: MessageType.fromMap(map['type'] as Map<String, dynamic>),
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageEntity.fromJson(String source) =>
      MessageEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  MessageEntity copyWith({
    AppUser? sender,
    String? groupId,
    DateTime? timestamp,
    MessageType? type,
    String? content,
  }) {
    return MessageEntity(
      sender: sender ?? this.sender,
      groupId: groupId ?? this.groupId,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      content: content ?? this.content,
    );
  }
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
