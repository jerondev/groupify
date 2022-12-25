import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizer_client/app/core/user/data/database/user_remote_database.dart';
import 'package:organizer_client/app/features/chat/domain/entities/message.dart';
import 'package:organizer_client/shared/constant/db_collections.dart';

abstract class ChatRemoteDatabase {
  Stream<List<MessageEntity>> getMessages(String groupId);
  Future<void> sendMessage(MessageEntity message);
}

class ChatRemoteDatabaseImpl implements ChatRemoteDatabase {
  final UserRemoteDatabase userRemoteDatabase;
  ChatRemoteDatabaseImpl({required this.userRemoteDatabase});

  @override
  Stream<List<MessageEntity>> getMessages(String groupId) {
    final messagesSnapshot = FirebaseFirestore.instance
        .collection(GROUPS_COLLECTION)
        .doc(groupId)
        .collection(MESSAGES_COLLECTION)
        .orderBy('timestamp', descending: true)
        .snapshots();
    return messagesSnapshot.asyncMap((snapshot) async {
      final messagesData = snapshot.docs;
      final List<MessageEntity> messages = [];
      for (final messageData in messagesData) {
        final message = MessageEntity.fromMap(messageData.data());
        final user = await userRemoteDatabase.get(message.sender.id);
        messages.insert(0, message.copyWith(sender: user));
      }
      return messages;
    });
  }

  @override
  Future<void> sendMessage(MessageEntity message) async {
    await FirebaseFirestore.instance
        .collection(GROUPS_COLLECTION)
        .doc(message.groupId)
        .collection(MESSAGES_COLLECTION)
        .add(message.toMap());
  }
}
