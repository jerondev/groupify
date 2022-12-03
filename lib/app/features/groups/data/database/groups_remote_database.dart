import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_member_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/sub_group_entity.dart';

abstract class GroupsRemoteDatabase {
  Future<void> createGroup(GroupEntity group);
  Future<GroupEntity> findGroup(String groupId);
  Future<SubGroupEntity> findSubGroup(String subGroupId);
  Future<void> joinGroup({
    required String subGroupId,
    required GroupMemberEntity member,
  });
  Future<List<GroupEntity>> findCreatedGroups(String userId);
  Future<List<SubGroupEntity>> findJoinedGroups(GroupMemberEntity member);
}

class GroupsRemoteDatabaseImpl implements GroupsRemoteDatabase {
  @override
  Future<void> createGroup(GroupEntity group) async {
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(group.id)
        .set(group.toMap());
    // create a sub group collection for each group
    for (var i = 0; i < group.totalGroups; i++) {
      group.subGroups[i].groupRef = 'groups/${group.id}';
      await FirebaseFirestore.instance
          .collection('subGroups')
          .doc(group.subGroups[i].id)
          .set(group.subGroups[i].toMap());
    }
  }

  @override
  Future<void> joinGroup({
    required String subGroupId,
    required GroupMemberEntity member,
  }) async {
    await FirebaseFirestore.instance
        .collection('subGroups')
        .doc(subGroupId)
        .update({
      "members": FieldValue.arrayUnion([member.toMap()])
    });
  }

  @override
  Future<GroupEntity> findGroup(String groupId) async {
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final subGroups = await FirebaseFirestore.instance
          .collection('subGroups')
          .where('groupRef', isEqualTo: "groups/$groupId")
          .get();
      final subGroupsList =
          subGroups.docs.map((e) => SubGroupEntity.fromMap(e.data())).toList();
      final groupData = group.data()!;
      final List<GroupMemberEntity> allMembers = [];
      for (var element in subGroupsList) {
        allMembers.addAll(element.members);
      }
      groupData['subGroups'] = subGroupsList;
      groupData['members'] = allMembers;
      return GroupEntity.fromMap(groupData);
    } else {
      throw FirebaseException(
        plugin: 'Firebase',
        message: 'Group does not exist',
      );
    }
  }

  @override
  Future<SubGroupEntity> findSubGroup(String subGroupId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('subGroups')
        .doc(subGroupId)
        .get();
    return SubGroupEntity.fromMap(snapshot.data()!);
  }

  @override
  Future<List<GroupEntity>> findCreatedGroups(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('groups')
        .where('createdBy', isEqualTo: userId)
        .get();
    final results =
        snapshot.docs.map((e) => GroupEntity.fromMap(e.data())).toList();
    return results;
  }

  @override
  Future<List<SubGroupEntity>> findJoinedGroups(
      GroupMemberEntity member) async {
    // find all the sub groups where user is a member

    final snapshot = await FirebaseFirestore.instance
        .collection('subGroups')
        .where('members', arrayContains: member.toMap())
        .get();
    final results =
        snapshot.docs.map((e) => SubGroupEntity.fromMap(e.data())).toList();
    return results;
  }
}
