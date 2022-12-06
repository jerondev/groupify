import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/community_details_controller.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_groups.dart';

class CommunityDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindGroupsUseCase>(() => FindGroupsUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<CommunityDetailsController>(
      () => CommunityDetailsController(
        findGroupsUseCase: Get.find(),
      ),
    );
  }
}
