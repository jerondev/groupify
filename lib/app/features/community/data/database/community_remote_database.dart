import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/shared/constant/db_collections.dart';
import 'package:organizer_client/shared/enums/id.dart';

abstract class CommunityRemoteDatabase {
  Future<String> createCommunity({
    required CommunityEntity community,
    required List<GroupEntity> groups,
  });
  Future<CommunityEntity> findCommunity(String groupId);
  Future<GroupEntity> findGroup(String subGroupId);
  Future<void> joinGroup({
    required String groupId,
    required String userId,
  });
  Future<List<CommunityEntity>> findCreatedCommunities(String userId);
  Future<List<GroupEntity>> findJoinedGroups(String userId);
  Future<bool> isMember({
    required IdType idType,
    required String id,
    required String userId,
  });
}

class CommunityRemoteDatabaseImpl implements CommunityRemoteDatabase {
  @override
  Future<String> createCommunity(
      {required CommunityEntity community,
      required List<GroupEntity> groups}) async {
    await FirebaseFirestore.instance
        .collection(COMMUNITIES_COLLECTION)
        .doc(community.id)
        .set(community.toMap());

    for (var group in groups) {
      await FirebaseFirestore.instance
          .collection(GROUPS_COLLECTION)
          .doc(group.id)
          .set(group.toMap());
    }

    return community.id;
  }

  @override
  Future<CommunityEntity> findCommunity(String communityId) async {
    final community = await FirebaseFirestore.instance
        .collection(COMMUNITIES_COLLECTION)
        .doc(communityId)
        .get();
    if (!community.exists) {
      throw FirebaseException(
        plugin: 'Firebase',
        message: 'Community does not exist',
      );
    }
    return CommunityEntity.fromMap(community.data()!);
  }

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
  Future<List<CommunityEntity>> findCreatedCommunities(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(COMMUNITIES_COLLECTION)
        .where('createdBy', isEqualTo: userId)
        .get();
    final results =
        snapshot.docs.map((e) => CommunityEntity.fromMap(e.data())).toList();
    return results;
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
