import 'package:get_storage/get_storage.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';

abstract class UserLocalDatabase {
  Future<void> save(AppUser appUser);
  Future<AppUser> get();
  Future<void> delete();
  Future<void> update(AppUser appUser);
  Future<bool> authStatus();
}

class UserLocalDatabaseImpl implements UserLocalDatabase {
  final boxName = 'userBox';
  final userKey = 'userKey';

  @override
  Future<void> delete() async {
    final box = GetStorage(boxName);
    await box.erase();
  }

  @override
  Future<AppUser> get() async {
    final box = GetStorage(boxName);
    final userDetails = box.read(userKey);
    final user =
        userDetails != null ? AppUser.fromMap(userDetails) : AppUser.initial();
    return Future.value(user);
  }

  @override
  Future<void> save(AppUser appUser) async {
    final box = GetStorage(boxName);
    await box.write(userKey, appUser.toMap());
  }

  @override
  Future<void> update(AppUser appUser) async {
    final box = GetStorage(boxName);
    await box.write(userKey, appUser.toMap());
  }

  @override
  Future<bool> authStatus() async {
    final box = GetStorage(boxName);
    final user = await box.read(userKey);
    return user != null;
  }
}
