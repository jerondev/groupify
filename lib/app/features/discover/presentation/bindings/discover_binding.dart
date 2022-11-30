import 'package:get/get.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/discover_controller.dart';

class DiscoverBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiscoverController>(() => DiscoverController());
  }
}
