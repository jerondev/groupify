import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizer_client/app/core/user/data/database/user_remote_database.dart';
import 'package:organizer_client/app/features/chat/domain/entities/community_message.dart';
import 'package:organizer_client/shared/constant/db_collections.dart';

abstract class CommunityChatRemoteDatabase {
  Stream<List<CommunityMessageEntity>> getMessages(String communityId);
  Future<void> sendMessage(
    CommunityMessageEntity message,
  );
  Future<void> deleteMessage(
    CommunityMessageEntity message,
  );
}

class CommunityChatRemoteDatabaseImpl implements CommunityChatRemoteDatabase {
  final UserRemoteDatabase userRemoteDatabase;
  CommunityChatRemoteDatabaseImpl({required this.userRemoteDatabase});

  @override
  Stream<List<CommunityMessageEntity>> getMessages(String communityId) {
    final messagesSnapshot = FirebaseFirestore.instance
        .collection(COMMUNITIES_COLLECTION)
        .doc(communityId)
        .collection(MESSAGES_COLLECTION)
        .orderBy('timestamp', descending: true)
        .snapshots();
    return messagesSnapshot.asyncMap((snapshot) async {
      final messagesData = snapshot.docs;
      final List<CommunityMessageEntity> messages = [];
      for (final message in messagesData) {
        final data = message.data();
        final sender = await userRemoteDatabase.get(data['sender']);
        data['sender'] = sender.toMap();
        messages.insert(0, CommunityMessageEntity.fromMap(data));
      }
      return messages;
    });
  }

  @override
  Future<void> sendMessage(CommunityMessageEntity message) async {
    final Map<String, dynamic> messageData = message.toMap();
    messageData['sender'] = message.sender.id;

    // if chat type is group, add the message to the group collection else add it the community collection

    await FirebaseFirestore.instance
        .collection(COMMUNITIES_COLLECTION)
        .doc(message.communityId)
        .collection(MESSAGES_COLLECTION)
        .doc(message.id)
        .set(messageData);
  }

  @override
  Future<void> deleteMessage(CommunityMessageEntity message) async {
    //  update the isDeleted field to true
    await FirebaseFirestore.instance
        .collection(COMMUNITIES_COLLECTION)
        .doc(message.communityId)
        .collection(MESSAGES_COLLECTION)
        .doc(message.id)
        .delete();
  }
}
