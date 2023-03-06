import 'package:get/get.dart';
import 'package:groupify/app/features/community/domain/usecases/create.dart';

import '../controllers/create_community_controller.dart';

class CreateCommunityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateCommunity>(() => CreateCommunity(
          repository: Get.find(),
        ));
    Get.lazyPut<CreateCommunityController>(() => CreateCommunityController(
          createCommunity: Get.find(),
        ));
  }
}
