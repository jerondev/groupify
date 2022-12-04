import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/data/database/groups_remote_database.dart';
import 'package:organizer_client/app/features/groups/data/repositories/groups_repository_impl.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/groups_repository.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_created_groups.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/groups_controller.dart';
import 'package:organizer_client/shared/network/network.dart';

class GroupsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupsRepository>(() => GroupsRepositoryImpl(
          networkInfo: Get.find<NetworkInfoImpl>(),
          remoteDatabase: Get.find<GroupsRemoteDatabase>(),
        ));
    Get.lazyPut<FindCreatedGroupsUseCase>(() => FindCreatedGroupsUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GroupsController>(() => GroupsController(
          findCreatedGroupsUseCase: Get.find(),
        ));
  }
}
