import 'package:get/get.dart';

import '../controllers/create_community_controller.dart';

class CreateCommunityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateCommunityController>(() => CreateCommunityController());
  }
}
