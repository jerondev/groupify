// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:intl/intl.dart";
import 'package:organizer_client/app/core/user/domain/entities/user.dart';

class CommunityMessageEntity extends Equatable {
  final AppUser sender;
  final String id;
  final String communityId;
  final DateTime timestamp;
  final MessageType type;
  final String content;
  final bool isDeleted;
  final bool isSent;
  const CommunityMessageEntity({
    required this.sender,
    required this.id,
    required this.communityId,
    required this.timestamp,
    required this.type,
    required this.content,
    this.isDeleted = false,
    this.isSent = false,
  });

  @override
  List<Object> get props {
    return [
      sender,
      id,
      communityId,
      timestamp,
      type,
      content,
      isDeleted,
      isSent,
    ];
  }

  // get chat date, like today, yesterday, 3rd May,
  String get formattedDate {
    // compare date to current date and return appropriate string
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    final DateTime messageDate =
        DateTime(timestamp.year, timestamp.month, timestamp.day);
    if (messageDate == today) {
      return "Today";
    } else if (messageDate == yesterday) {
      return "Yesterday";
    } else {
      // let the formatted date be something like Sunday, August 07
      final DateFormat formatter = DateFormat('EEEE, MMMM dd');
      return formatter.format(timestamp);
    }
  }

  String get formattedTime {
    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(timestamp);
  }

  // check if is my message
  bool get isMyMessage => sender.id == FirebaseAuth.instance.currentUser!.uid;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender.toMap(),
      'id': id,
      'communityId': communityId,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'type': type.toMap(),
      'content': content,
      'isDeleted': isDeleted,
      'isSent': isSent,
    };
  }

  factory CommunityMessageEntity.fromMap(Map<String, dynamic> map) {
    return CommunityMessageEntity(
      sender: AppUser.fromMap(map['sender'] as Map<String, dynamic>),
      id: map['id'] as String,
      communityId: map['communityId'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      type: MessageType.fromMap(map['type'] as Map<String, dynamic>),
      content: map['content'] as String,
      isDeleted: map['isDeleted'] as bool,
      isSent: map['isSent'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommunityMessageEntity.fromJson(String source) =>
      CommunityMessageEntity.fromMap(
          json.decode(source) as Map<String, dynamic>);

  CommunityMessageEntity copyWith({
    AppUser? sender,
    String? id,
    String? communityId,
    DateTime? timestamp,
    MessageType? type,
    String? content,
    bool? isDeleted,
    bool? isSent,
  }) {
    return CommunityMessageEntity(
      sender: sender ?? this.sender,
      id: id ?? this.id,
      communityId: communityId ?? this.communityId,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      content: content ?? this.content,
      isDeleted: isDeleted ?? this.isDeleted,
      isSent: isSent ?? this.isSent,
    );
  }

  @override
  bool get stringify => true;
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
