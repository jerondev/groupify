// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizer_client/app/core/user/data/database/user_remote_database.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/features/community/data/database/community_remote_database.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/shared/constant/db_collections.dart';
import 'package:organizer_client/shared/enums/id.dart';

abstract class GroupRemoteDatabase {
  Future<GroupEntity> findGroup(String groupId);
  Future<void> joinGroup({
    required String groupId,
    required String userId,
  });
  Stream<List<GroupEntity>> findJoinedGroups(String userId);
  Future<List<GroupEntity>> findGroups(String communityId);
  Future<bool> isMember({
    required IdType idType,
    required String id,
    required String userId,
  });
}

class GroupRemoteDatabaseImpl implements GroupRemoteDatabase {
  final UserRemoteDatabase userRemoteDatabase;
  final CommunityRemoteDatabase communityRemoteDatabase;
  GroupRemoteDatabaseImpl({
    required this.userRemoteDatabase,
    required this.communityRemoteDatabase,
  });

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
    final List<AppUser> allMembers = [];
    final groupData = group.data()!;
    final communityId = groupData['communityId'];
    communityRemoteDatabase.findCommunity(communityId).then((value) {
      groupData['communityName'] = value.name;
    });
    final List membersId = groupData['members'];
    for (var id in membersId) {
      final user = await userRemoteDatabase.get(id);
      allMembers.add(user);
    }
    groupData['members'] = allMembers;

    return GroupEntity.fromMap(groupData);
  }

  @override
  Stream<List<GroupEntity>> findJoinedGroups(String userId) {
    final groupsSnapshot = FirebaseFirestore.instance
        .collection(GROUPS_COLLECTION)
        .where('members', arrayContains: userId)
        .snapshots();

    return groupsSnapshot.asyncMap((snapshot) async {
      final List<GroupEntity> data = [];
      final groups = snapshot.docs;
      for (var group in groups) {
        final List<AppUser> membersOfGroup = [];
        final groupData = group.data();
        final communityId = groupData['communityId'];
        communityRemoteDatabase.findCommunity(communityId).then((value) {
          groupData['communityName'] = value.name;
        });

        final List membersId = groupData['members'];
        for (var id in membersId) {
          final user = await userRemoteDatabase.get(id);
          membersOfGroup.add(user);
        }
        groupData['members'] = membersOfGroup;
        data.add(GroupEntity.fromMap(groupData));
      }
      return data;
    });
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
      final List members = groupData['members'];
      return members.contains(userId);
    } else {
      final group = await FirebaseFirestore.instance
          .collection(GROUPS_COLLECTION)
          .where('communityId', isEqualTo: id)
          .get();
      final groupData = group.docs;
      return groupData.any((element) => element['members'].contains(userId));
    }
  }

  @override
  Future<List<GroupEntity>> findGroups(String communityId) async {
    final groups = await FirebaseFirestore.instance
        .collection(GROUPS_COLLECTION)
        .where('communityId', isEqualTo: communityId)
        .get();

    final List data = [];

    for (var group in groups.docs) {
      final List<AppUser> allMembers = [];
      final groupData = group.data();
      final communityId = groupData['communityId'];
      communityRemoteDatabase.findCommunity(communityId).then((value) {
        groupData['communityName'] = value.name;
      });
      final List membersId = groupData['members'];
      for (var id in membersId) {
        final user = await userRemoteDatabase.get(id);
        allMembers.add(user);
      }
      groupData['members'] = allMembers;
      data.add(groupData);
    }

    final results = data.map((e) => GroupEntity.fromMap(e)).toList();
    return results;
  }
}
