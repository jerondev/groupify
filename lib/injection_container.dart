import 'package:get/get.dart';
import 'package:groupify/app/core/user/data/database/user_local_database.dart';
import 'package:groupify/app/core/user/data/database/user_remote_database.dart';
import 'package:groupify/app/core/user/data/repositories/user_repository_impl.dart';
import 'package:groupify/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:groupify/app/features/community/data/database/community_remote_database.dart';
import 'package:groupify/app/features/community/data/repositories/community_repository_impl.dart';
import 'package:groupify/app/features/community/domain/repositories/community_repository.dart';
import 'package:groupify/app/features/groups/data/database/group_remote_database.dart';
import 'package:groupify/app/features/groups/data/repositories/group_repository_impl.dart';
import 'package:groupify/app/features/groups/domain/repositories/group_repository.dart';
import 'package:groupify/shared/network/network.dart';

import 'app/features/groups/domain/usecases/is_member.dart';

class InitialBinding {
  static void inject() {
    Get.put(NetworkInfoImpl(), permanent: true);
    Get.put(UserLocalDatabaseImpl(), permanent: true);
    Get.put(UserRemoteDatabaseImpl(), permanent: true);
    Get.put(CommunityRemoteDatabaseImpl(), permanent: true);

    Get.put(
      GroupRemoteDatabaseImpl(
          userRemoteDatabase: Get.find<UserRemoteDatabaseImpl>(),
          communityRemoteDatabase: Get.find<CommunityRemoteDatabaseImpl>()),
      permanent: true,
    );

    Get.put(UserRepositoryImpl(
      networkInfo: Get.find<NetworkInfoImpl>(),
      userRemoteDatabase: Get.find<UserRemoteDatabaseImpl>(),
      userLocalDatabase: Get.find<UserLocalDatabaseImpl>(),
    ));
    Get.lazyPut<GroupRepository>(
      () => GroupRepositoryImpl(
        networkInfo: Get.find<NetworkInfoImpl>(),
        remoteDatabase: Get.find<GroupRemoteDatabaseImpl>(),
      ),
      fenix: true,
    );
    Get.lazyPut<CommunityRepository>(
      () => CommunityRepositoryImpl(
        networkInfo: Get.find<NetworkInfoImpl>(),
        remoteDatabase: Get.find<CommunityRemoteDatabaseImpl>(),
      ),
      fenix: true,
    );
    Get.put(
      AuthenticatedUserUseCase(userRepository: Get.find<UserRepositoryImpl>()),
    );
    Get.lazyPut<IsMemberUseCase>(() => IsMemberUseCase(repository: Get.find()));
  }
}
