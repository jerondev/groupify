import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/shared/constant/db_collections.dart';
import 'package:organizer_client/shared/enums/id.dart';

abstract class GroupRemoteDatabase {
  Future<GroupEntity> findGroup(String groupId);
  Future<void> joinGroup({
    required String groupId,
    required String userId,
  });
  Future<List<GroupEntity>> findJoinedGroups(String userId);
  Future<bool> isMember({
    required IdType idType,
    required String id,
    required String userId,
  });
}

class GroupRemoteDatabaseImpl implements GroupRemoteDatabase {
  @override
  Future<void> joinGroup({
    required String groupId,
    required String userId,
  }) async {
    await FirebaseFirestore.instance
        .collection(GROUPS_COLLECTION)
        .doc(groupId)
        .update({
      "members": FieldValue.arrayUnion([userId])
    });
  }

  @override
  Future<GroupEntity> findGroup(String groupId) async {
    final group = await FirebaseFirestore.instance
        .collection(GROUPS_COLLECTION)
        .doc(groupId)
        .get();
    if (!group.exists) {
      throw FirebaseException(
        plugin: 'Firebase',
        message: 'Group does not exist',
      );
    }
    return GroupEntity.fromMap(group.data()!);
  }

  @override
  Future<List<GroupEntity>> findJoinedGroups(String userId) async {
    final groups = await FirebaseFirestore.instance
        .collection(GROUPS_COLLECTION)
        .where('members', arrayContains: userId)
        .get();
    final results =
        groups.docs.map((e) => GroupEntity.fromMap(e.data())).toList();
    return results;
  }

  @override
  Future<bool> isMember({
    required IdType idType,
    required String id,
    required String userId,
  }) async {
    if (idType == IdType.group) {
      final group = await FirebaseFirestore.instance
          .collection(GROUPS_COLLECTION)
          .doc(id)
          .get();
      final groupData = group.data()!;
      final List<String> members = groupData['members'];
      return members.contains(userId);
    } else {
      final group = await FirebaseFirestore.instance
          .collection(GROUPS_COLLECTION)
          .where('communityId', isEqualTo: id)
          .limit(1)
          .get();
      final groupData = group.docs[0];
      final List<String> members = groupData['members'];
      return members.contains(userId);
    }
  }
}
