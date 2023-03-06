import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groupify/app/core/user/domain/entities/user.dart';

abstract class UserRemoteDatabase {
  Future<void> save(AppUser appUser);
  Future<bool> exists(String id);
  Future<AppUser> get(String id);
  Future<void> update(AppUser appUser);
}

class UserRemoteDatabaseImpl implements UserRemoteDatabase {
  @override
  Future<void> save(AppUser appUser) async {
    await FirebaseFirestore.instance.collection('users').doc(appUser.id).set(
          appUser.toMap(),
          SetOptions(merge: true),
        );
  }

  @override
  Future<bool> exists(String id) {
    return FirebaseFirestore.instance.collection('users').doc(id).get().then(
          (value) => value.exists,
        );
  }

  @override
  Future<AppUser> get(String id) {
    return FirebaseFirestore.instance.collection('users').doc(id).get().then(
          (value) => AppUser.fromMap(value.data()!),
        );
  }

  @override
  Future<void> update(AppUser appUser) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(appUser.id)
        .update(appUser.toMap());
  }
}
