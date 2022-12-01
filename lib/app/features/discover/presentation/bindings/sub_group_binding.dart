import 'package:get/get.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/sub_group_controller.dart';

class SubGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubGroupController>(() => SubGroupController());
  }
}
