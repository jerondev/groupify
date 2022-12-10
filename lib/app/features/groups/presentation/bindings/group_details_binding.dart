import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/data/repositories/user_repository_impl.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/add_social_link.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/delete_social_link.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_details_controller.dart';

class GroupDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FindGroupUseCase(repository: Get.find()));
    Get.lazyPut<AddSocialLinkUseCase>(() => AddSocialLinkUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<AuthenticatedUserUseCase>(() => AuthenticatedUserUseCase(
        userRepository: Get.find<UserRepositoryImpl>()));

    Get.lazyPut<DeleteSocialLinkUseCase>(() => DeleteSocialLinkUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<GroupDetailsController>(
      () => GroupDetailsController(
          findGroupUseCase: Get.find(),
          addSocialLinkUseCase: Get.find(),
          authenticatedUserUseCase: Get.find(),
          deleteSocialLinkUseCase: Get.find()),
    );
  }
}
