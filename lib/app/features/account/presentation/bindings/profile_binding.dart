import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/data/repositories/user_repository_impl.dart';
import 'package:organizer_client/app/core/user/domain/usecases/update.dart';
import 'package:organizer_client/app/features/account/presentation/controllers/profile_controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateUserUseCase>(() => UpdateUserUseCase(
          repository: Get.find<UserRepositoryImpl>(),
        ));
    Get.lazyPut<ProfileController>(
        () => ProfileController(updateUserUseCase: Get.find()));
  }
}
