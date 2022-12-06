import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/data/database/community_remote_database.dart';
import 'package:organizer_client/app/features/community/data/repositories/community_repository_impl.dart';
import 'package:organizer_client/app/features/community/domain/repositories/community_repository.dart';
import 'package:organizer_client/app/features/community/domain/usecases/find_created_communities.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/created_communities_controller.dart';
import 'package:organizer_client/shared/network/network.dart';

class CreatedCommunitiesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityRepository>(() => CommunityRepositoryImpl(
          networkInfo: Get.find<NetworkInfoImpl>(),
          remoteDatabase: Get.find<CommunityRemoteDatabase>(),
        ));
    Get.lazyPut<FindCreatedCommunitiesUseCase>(
        () => FindCreatedCommunitiesUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<CreatedCommunitiesController>(
      () => CreatedCommunitiesController(
        findCreatedCommunitiesUseCase: Get.find(),
      ),
    );
  }
}
