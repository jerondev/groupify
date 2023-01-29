import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_preview_controller.dart';

class GroupPreviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupPreviewController>(() => GroupPreviewController());
  }
}
