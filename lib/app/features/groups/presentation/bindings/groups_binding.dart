import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/data/repositories/user_repository_impl.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/groups/data/database/groups_remote_database.dart';
import 'package:organizer_client/app/features/groups/data/repositories/groups_repository_impl.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/groups_repository.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_joined_groups.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/groups_controller.dart';
import 'package:organizer_client/shared/network/network.dart';

class GroupsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupsRepository>(() => GroupsRepositoryImpl(
          networkInfo: Get.find<NetworkInfoImpl>(),
          remoteDatabase: Get.find<GroupsRemoteDatabase>(),
        ));
    Get.lazyPut<FindJoinedGroupUseCase>(() => FindJoinedGroupUseCase(
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
