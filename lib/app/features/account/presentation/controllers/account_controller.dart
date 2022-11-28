// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/signout.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class AccountController extends GetxController {
  final AuthenticatedUserUseCase authenticatedUser;
  final SignOutUseCase signOutUseCase;
  late AppUser appUser;
  RxBool isLoading = false.obs;
  RxBool isLoggingOut = false.obs;
  AccountController(
      {required this.authenticatedUser, required this.signOutUseCase});

  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }

  Future<void> getUserDetails() async {
    isLoading.value = true;
    final results = await authenticatedUser.call(NoParams());
    results.fold((failure) {
      Get.snackbar("Error", failure.message);
      appUser = AppUser.initial();
      isLoading.value = false;
    }, (success) {
      appUser = success;
      isLoading.value = false;
    });
  }

  Future<void> signOut() async {
    isLoggingOut.value = true;
    final results = await signOutUseCase.call(NoParams());
    results.fold((failure) {
      Get.snackbar(
        "Error",
        failure.message,
      );
      isLoggingOut.value = false;
    }, (success) {
      Get.offAllNamed(AppRoutes.REGISTER);
      isLoggingOut.value = false;
    });
  }
}
