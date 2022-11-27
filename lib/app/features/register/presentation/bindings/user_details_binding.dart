import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/data/repositories/user_repository_impl.dart';
import 'package:organizer_client/app/core/user/domain/usecases/register.dart';
import 'package:organizer_client/app/features/register/presentation/controllers/user_details_controller.dart';

class UserDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterUseCase(repository: Get.find<UserRepositoryImpl>()));
    Get.lazyPut<UserDetailsController>(
      () => UserDetailsController(
        registerUseCase: Get.find<RegisterUseCase>(),
      ),
    );
  }
}
