import 'package:get/get.dart';
import 'package:organizer_client/app/features/register/presentation/controllers/user_details_controller.dart';

class UserDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDetailsController>(() => UserDetailsController());
  }
}
