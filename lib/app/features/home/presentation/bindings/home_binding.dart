import 'package:get/get.dart';
import 'package:groupify/app/features/home/presentation/controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
