import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/join_community_controller.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_groups.dart';

class JoinCommunityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindGroupsUseCase>(() => FindGroupsUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<JoinCommunityController>(
        () => JoinCommunityController(findGroupsUseCase: Get.find()));
  }
}
