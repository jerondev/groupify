// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/signout.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class AccountController extends GetxController {
  final AuthenticatedUserUseCase authenticatedUser;
  final SignOutUseCase signOutUseCase;
  late AppUser appUser;
  RxBool isLoading = false.obs;

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
      showErrorSnackbar(message: failure.message);
      appUser = AppUser.initial();
      isLoading.value = false;
    }, (success) {
      appUser = success;
      isLoading.value = false;
    });
  }

  Future<Either<Failure, AppUser>> getUserDetailsTest() async {
    final results = await authenticatedUser.call(NoParams());
    return results;
  }

  Future<void> signOut() async {
    final results = await signOutUseCase.call(NoParams());
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
    }, (success) {
      Get.offAllNamed(AppRoutes.REGISTER);
    });
  }
}
