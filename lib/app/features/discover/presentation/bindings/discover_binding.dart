import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/usecases/find_community.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/discover_controller.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/is_member.dart';

class DiscoverBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindCommunityUseCase>(
        () => FindCommunityUseCase(repository: Get.find()));
    Get.lazyPut<FindGroupUseCase>(
        () => FindGroupUseCase(repository: Get.find()));
    Get.lazyPut<IsMemberUseCase>(() => IsMemberUseCase(repository: Get.find()));
    Get.lazyPut<DiscoverController>(
      () => DiscoverController(
        findCommunityUseCase: Get.find(),
        findGroupUseCase: Get.find(),
        isMemberUseCase: Get.find(),
      ),
    );
  }
}
