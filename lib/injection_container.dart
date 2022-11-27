import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/data/database/user_local_database.dart';
import 'package:organizer_client/app/core/user/data/database/user_remote_database.dart';
import 'package:organizer_client/app/core/user/data/repositories/user_repository_impl.dart';
import 'package:organizer_client/shared/network/network.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NetworkInfoImpl(), permanent: true);
    Get.put(UserLocalDatabaseImpl(), permanent: true);
    Get.put(UserRemoteDatabaseImpl(), permanent: true);
    Get.put(UserRepositoryImpl(
      networkInfo: Get.find<NetworkInfoImpl>(),
      userRemoteDatabase: Get.find<UserRemoteDatabaseImpl>(),
      userLocalDatabase: Get.find<UserLocalDatabaseImpl>(),
    ));
  }
}
