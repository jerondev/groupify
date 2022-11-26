import 'package:get/get.dart';
import 'package:organizer_client/app/features/register/presentation/controllers/register_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
