import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/groups_controller.dart';

class GroupsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupsController>(() => GroupsController());
  }
}
