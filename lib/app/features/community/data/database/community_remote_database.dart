import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groupify/app/features/community/domain/entities/community.dart';
import 'package:groupify/shared/constant/db_collections.dart';

abstract class CommunityRemoteDatabase {
  Future<String> create(Community community);
  Future<Community> get(String id);
  Stream<List<Community>> list(String id);
  Future<String> delete(String communityId);
  Future<String> update(Community community);
}

class CommunityRemoteDatabaseImpl implements CommunityRemoteDatabase {
  @override
  Future<Community> get(String communityId) async {
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
    return Community.fromMap(community.data()!);
  }

  @override
  Stream<List<Community>> list(String userId) {
    final snapshot = FirebaseFirestore.instance
        .collection(COMMUNITIES_COLLECTION)
        .where('createdBy', isEqualTo: userId)
        .snapshots();
    return snapshot.map(
        (event) => event.docs.map((e) => Community.fromMap(e.data())).toList());
  }

  @override
  Future<String> delete(String id) async {
    await FirebaseFirestore.instance
        .collection(COMMUNITIES_COLLECTION)
        .doc(id)
        .delete();
    return id;
  }

  @override
  Future<String> update(Community community) async {
    await FirebaseFirestore.instance
        .collection(COMMUNITIES_COLLECTION)
        .doc(community.id)
        .update(community.toMap());
    return community.id;
  }

  @override
  Future<String> create(Community community) async {
    await FirebaseFirestore.instance
        .collection(COMMUNITIES_COLLECTION)
        .doc(community.id)
        .set(community.toMap());
    return community.id;
  }
}
