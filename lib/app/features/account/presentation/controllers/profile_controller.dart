// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/update.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';
import 'package:organizer_client/shared/ui/snackbars.dart';

class ProfileController extends GetxController {
  final AppUser user = Get.arguments;
  String get name => user.fullName;
  String get phone => user.phoneNumber;
  String get avatar => user.avatar;
  bool get isAnonymous => user.isAnonymous;
  RxBool isLoading = false.obs;
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  final formKey = GlobalKey<FormState>();
  final UpdateUserUseCase updateUserUseCase;
  ProfileController({
    required this.updateUserUseCase,
  });
  late bool isProfileHidden;
  void toggleHideProfile(value) {
    isProfileHidden = value;
    update();
  }

  @override
  void onInit() {
    nameController = TextEditingController(
      text: name,
    );
    phoneNumberController = TextEditingController(
      text: phone,
    );
    isProfileHidden = isAnonymous;
    super.onInit();
  }

  void updateUserDetails() async {
    isLoading.value = true;
    final newUserDetails = AppUser(
      displayName: user.displayName,
      email: user.email,
      id: user.id,
      profile: user.profile,
      phoneNumber: phoneNumberController.text,
      fullName: nameController.text.trim(),
      isAnonymous: isProfileHidden,
    );
    final results = await updateUserUseCase.call(newUserDetails);
    results.fold((failure) {
      isLoading.value = false;
      showErrorSnackbar(message: failure.message);
    }, (success) {
      isLoading.value = false;
      Get.back();
    });
  }

  void showHideProfileExplanation() {
    showCustomBottomSheet(
      child: Text(
        "When enabled, your public profile will be replaced with a custom avatar generated using your name. Try it out 😃.",
        style: Get.textTheme.bodyLarge,
      ),
    );
  }
}
