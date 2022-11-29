import 'package:get/get.dart';
import 'package:organizer_client/app/features/join/presentation/controllers/join_controller.dart';

class JoinBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoinController>(() => JoinController());
  }
}
