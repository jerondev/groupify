import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/sub_group_entity.dart';

abstract class GroupsRemoteDatabase {
  Future<void> createGroup(GroupEntity group);
  Future<GroupEntity> findGroup(String groupId);
}

class GroupsRemoteDatabaseImpl implements GroupsRemoteDatabase {
  @override
  Future<void> createGroup(GroupEntity group) async {
    // create a groups collection and then loop over the total groups and create a sub group collection for each group
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(group.id)
        .set(group.toMap());
    // create a sub group collection for each group
    for (var i = 0; i < group.totalGroups; i++) {
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(group.id)
          .collection('subGroups')
          .doc(group.subGroups[i].id)
          .set(group.subGroups[i].toMap());
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(
          group.createdBy,
        )
        .update({
      "groupsCreated": FieldValue.arrayUnion([group.id])
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
          .collection('groups')
          .doc(groupId)
          .collection('subGroups')
          .get();
      final subGroupsList =
          subGroups.docs.map((e) => SubGroupEntity.fromMap(e.data())).toList();
      final groupData = group.data()!;
      groupData['subGroups'] = subGroupsList;
      return GroupEntity.fromMap(groupData);
    } else {
      throw FirebaseException(
        plugin: 'Firebase',
        message: 'Group does not exist',
      );
    }
  }
}
