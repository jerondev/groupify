import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:groupify/app/core/user/domain/usecases/signin.dart';
import 'package:groupify/app/routes/app_pages.dart';
import 'package:groupify/shared/ui/snackbars.dart';
import 'package:groupify/shared/usecase/usecase.dart';

class RegisterController extends GetxController {
  final SignInUseCase signInUseCase;
  RxBool isLoading = false.obs;
  RegisterController({
    required this.signInUseCase,
  });

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    final result = await signInUseCase(NoParams());
    result.fold(
      (failure) {
        isLoading.value = false;
        showErrorSnackbar(message: failure.message);
      },
      (userExists) {
        isLoading.value = false;
        if (userExists) {
          Get.offAllNamed(AppRoutes.HOME);
        } else {
          Get.offAllNamed(AppRoutes.USER_DETAILS);
        }
      },
    );
  }
}
