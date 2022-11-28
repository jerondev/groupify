import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:organizer_client/app/core/user/domain/usecases/signin.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

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
      (success) {
        isLoading.value = false;
        Get.offAllNamed(AppRoutes.USER_DETAILS);
      },
    );
  }
}
