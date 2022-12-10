import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/shared/constant/db_collections.dart';

abstract class CommunityRemoteDatabase {
  Future<String> createCommunity({
    required CommunityEntity community,
    required List<GroupEntity> groups,
  });
  Future<CommunityEntity> findCommunity(String communityId);

  Future<List<CommunityEntity>> findCreatedCommunities(String userId);
  Future<String> deleteCommunity(String communityId);
  Future<void> updateCommunity(CommunityEntity community);
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
  Future<String> deleteCommunity(String communityId) async {
    await FirebaseFirestore.instance
        .collection(COMMUNITIES_COLLECTION)
        .doc(communityId)
        .delete();

    final groups = await FirebaseFirestore.instance
        .collection(GROUPS_COLLECTION)
        .where('communityId', isEqualTo: communityId)
        .get();
    for (var group in groups.docs) {
      await group.reference.delete();
    }

    return communityId;
  }

  @override
  Future<void> updateCommunity(CommunityEntity community) async {
    await FirebaseFirestore.instance
        .collection(COMMUNITIES_COLLECTION)
        .doc(community.id)
        .update(community.toMap());
  }
}
