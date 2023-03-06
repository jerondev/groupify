import 'package:get/get.dart';
import 'package:groupify/app/core/user/data/repositories/user_repository_impl.dart';
import 'package:groupify/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:groupify/app/core/user/domain/usecases/signout.dart';
import 'package:groupify/app/features/account/presentation/controllers/account_controller.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SignOutUseCase(repository: Get.find<UserRepositoryImpl>()));
    Get.lazyPut<AccountController>(
      () => AccountController(
          authenticatedUser: Get.find<AuthenticatedUserUseCase>(),
          signOutUseCase: Get.find<SignOutUseCase>()),
    );
  }
}
