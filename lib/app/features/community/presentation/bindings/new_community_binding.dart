import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/data/database/community_remote_database.dart';
import 'package:organizer_client/app/features/community/data/repositories/community_repository_impl.dart';
import 'package:organizer_client/app/features/community/domain/usecases/create_community.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/new_community_.controller.dart';
import 'package:organizer_client/shared/network/network.dart';

class NewGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityRemoteDatabase>(() => CommunityRemoteDatabaseImpl());
    Get.put(
      CommunityRepositoryImpl(
        networkInfo: Get.find<NetworkInfoImpl>(),
        remoteDatabase: Get.find<CommunityRemoteDatabase>(),
      ),
    );
    Get.put(CreateCommunityUseCase(
      repository: Get.find<CommunityRepositoryImpl>(),
    ));
    Get.lazyPut<NewGroupController>(
      () => NewGroupController(
        createGroupUseCase: Get.find<CreateCommunityUseCase>(),
      ),
    );
  }
}
