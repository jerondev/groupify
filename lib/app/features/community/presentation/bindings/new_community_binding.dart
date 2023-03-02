import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/usecases/create_community.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/new_community_.controller.dart';

class NewCommunityBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CreateCommunityUseCase(
      repository: Get.find(),
    ));
    Get.lazyPut<NewCommunityController>(
      () => NewCommunityController(
        createCommunityUseCase: Get.find<CreateCommunityUseCase>(),
      ),
    );
  }
}
