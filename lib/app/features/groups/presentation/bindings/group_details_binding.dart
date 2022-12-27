import 'package:get/get.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/get_community_messages.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_details_controller.dart';

class GroupDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FindGroupUseCase(repository: Get.find()));
    Get.lazyPut<GetCommunityMessagesUseCase>(() => GetCommunityMessagesUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GroupDetailsController>(
      () => GroupDetailsController(
        findGroupUseCase: Get.find(),
        getMessagesUseCase: Get.find(),
      ),
    );
  }
}
