import 'package:get/get.dart';
import 'package:organizer_client/app/features/account/presentation/controllers/account_controller.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
