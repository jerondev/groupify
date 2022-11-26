import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/new_group.controller.dart';

class NewGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewGroupController>(() => NewGroupController());
  }
}
