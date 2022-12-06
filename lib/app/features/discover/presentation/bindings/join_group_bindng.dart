import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/data/database/community_remote_database.dart';
import 'package:organizer_client/app/features/community/data/repositories/community_repository_impl.dart';
import 'package:organizer_client/app/features/community/domain/repositories/community_repository.dart';
import 'package:organizer_client/app/features/community/domain/usecases/find_community.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/join_group_controller.dart';
import 'package:organizer_client/shared/network/network.dart';

class JoinGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityRemoteDatabase>(() => CommunityRemoteDatabaseImpl());
    Get.lazyPut<CommunityRepository>(
      () => GroupsRepositoryImpl(
        networkInfo: Get.find<NetworkInfoImpl>(),
        remoteDatabase: Get.find<CommunityRemoteDatabase>(),
      ),
    );
    Get.lazyPut<FindGroupUseCase>(
        () => FindGroupUseCase(repository: Get.find<CommunityRepository>()));
    Get.lazyPut<JoinGroupController>(
      () => JoinGroupController(
        findGroupUseCase: Get.find<FindGroupUseCase>(),
      ),
    );
  }
}
