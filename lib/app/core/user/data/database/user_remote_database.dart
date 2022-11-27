import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';

abstract class UserRemoteDatabase {
  Future<void> save(AppUser appUser);
}

class UserRemoteDatabaseImpl implements UserRemoteDatabase {
  @override
  Future<void> save(AppUser appUser) async {
    FirebaseFirestore.instance.collection('users').doc(appUser.id).set(
          appUser.toMap(),
          SetOptions(merge: true),
        );
  }
}
