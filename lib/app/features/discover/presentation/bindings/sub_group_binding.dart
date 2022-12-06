import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/sub_group_controller.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/join_group.dart';

class SubGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubGroupController>(
      () => SubGroupController(
        joinGroupUseCase: Get.find<JoinGroupUseCase>(),
        authenticatedUserUseCase: Get.find<AuthenticatedUserUseCase>(),
      ),
    );
  }
}
