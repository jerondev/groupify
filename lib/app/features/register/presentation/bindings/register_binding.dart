import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/data/repositories/user_repository_impl.dart';
import 'package:organizer_client/app/core/user/domain/usecases/signin.dart';
import 'package:organizer_client/app/features/register/presentation/controllers/register_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SignInUseCase(repository: Get.find<UserRepositoryImpl>()));
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        signInUseCase: Get.find<SignInUseCase>(),
      ),
    );
  }
}
