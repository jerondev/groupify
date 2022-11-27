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
  // init getx storage
  final boxName = 'user';
  void init() async {
    await GetStorage.init('user');
  }

  @override
  Future<void> delete() async {
    init();
    final box = GetStorage(boxName);
    await box.erase();
  }

  @override
  Future<AppUser> get() async {
    init();
    final box = GetStorage(boxName);
    final user = AppUser.fromMap(box.read('user'));
    return Future.value(user);
  }

  @override
  Future<void> save(AppUser appUser) async {
    init();
    final box = GetStorage(boxName);
    await box.write('user', appUser.toMap());
  }

  @override
  Future<void> update(AppUser appUser) async {
    init();
    final box = GetStorage(boxName);
    await box.write('user', appUser.toMap());
  }

  @override
  Future<bool> authStatus() async {
    init();
    final box = GetStorage(boxName);
    final user = await box.read('user');
    return Future.value(user != null);
  }
}
