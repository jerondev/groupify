import 'package:get/get.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/join_group_controller.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/join_group.dart';

class JoinGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindGroupUseCase>(
        () => FindGroupUseCase(repository: Get.find()));
    Get.lazyPut<JoinGroupUseCase>(
        () => JoinGroupUseCase(repository: Get.find()));
    Get.lazyPut<JoinGroupController>(
      () => JoinGroupController(
        findGroupUseCase: Get.find<FindGroupUseCase>(),
        joinGroupUseCase: Get.find<JoinGroupUseCase>(),
      ),
    );
  }
}
