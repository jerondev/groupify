import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/data/database/groups_remote_database.dart';
import 'package:organizer_client/app/features/groups/data/repositories/groups_repository_impl.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/create_group.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/new_group.controller.dart';
import 'package:organizer_client/shared/network/network.dart';

class NewGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupsRemoteDatabase>(() => GroupsRemoteDatabaseImpl());
    Get.put(
      GroupsRepositoryImpl(
        networkInfo: Get.find<NetworkInfoImpl>(),
        remoteDatabase: Get.find<GroupsRemoteDatabase>(),
      ),
    );
    Get.put(CreateGroupUseCase(
      repository: Get.find<GroupsRepositoryImpl>(),
    ));
    Get.lazyPut<NewGroupController>(
      () => NewGroupController(
        createGroupUseCase: Get.find<CreateGroupUseCase>(),
      ),
    );
  }
}
