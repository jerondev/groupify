import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/usecases/delete_community.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/community_settings_controller.dart';

class CommunitySettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeleteCommunityUseCase>(() => DeleteCommunityUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<CommunitySettingsController>(
      () => CommunitySettingsController(
        deleteCommunityUseCase: Get.find(),
      ),
    );
  }
}
