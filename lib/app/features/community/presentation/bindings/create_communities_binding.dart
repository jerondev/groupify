import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/usecases/find_created_communities.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/created_communities_controller.dart';

class CreatedCommunitiesBinding implements Bindings {
  @override
  void dependencies() {
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
