import 'package:get/get.dart';
import 'package:groupify/app/core/user/data/repositories/user_repository_impl.dart';
import 'package:groupify/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:groupify/app/features/groups/domain/usecases/find_joined_groups.dart';
import 'package:groupify/app/features/groups/presentation/controllers/groups_controller.dart';

class GroupsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindJoinedGroupsUseCase>(() => FindJoinedGroupsUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GroupsController>(() => GroupsController(
          findJoinedGroupUseCase: Get.find(),
          authenticatedUserUseCase: Get.put(
            AuthenticatedUserUseCase(
              userRepository: Get.find<UserRepositoryImpl>(),
            ),
          ),
        ));
  }
}
