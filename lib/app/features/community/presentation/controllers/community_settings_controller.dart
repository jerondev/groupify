// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/usecases/delete_community.dart';
import 'package:organizer_client/app/features/community/domain/usecases/update_community.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/community_details_controller.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';
import 'package:organizer_client/shared/utils/copy_to_clipboard.dart';

class CommunitySettingsController extends GetxController {
  final CommunityEntity community = Get.arguments;
  String get name => community.name;
  String get id => community.id;
  String get description => community.description;
  // Make name and description reactive
  RxString nameRx = "".obs;
  RxString descriptionRx = "".obs;

  RxBool isDeleting = false.obs;
  RxBool isUpdating = false.obs;
  final DeleteCommunityUseCase deleteCommunityUseCase;
  final UpdateCommunityUseCase updateCommunityUseCase;
  late TextEditingController communityNameController;
  late TextEditingController communityDescriptionController;
  final communityNameFormKey = GlobalKey<FormState>();
  final communityDescFormKey = GlobalKey<FormState>();
  final communityDetailsController = Get.find<CommunityDetailsController>();

  @override
  void onInit() {
    communityNameController = TextEditingController(text: name);
    communityDescriptionController = TextEditingController(text: description);
    nameRx.value = name;
    descriptionRx.value = description;
    super.onInit();
  }

  CommunitySettingsController({
    required this.deleteCommunityUseCase,
    required this.updateCommunityUseCase,
  });

  void copyCommunityId() {
    copyToClipboard(id);
    Get.snackbar("Success", "Community Id copied to clipboard");
  }

  void deleteCommunityWrapper() async {
    showCustomBottomSheet(
      child: Expanded(
        child: Column(
          children: [
            RichText(
                text: TextSpan(
              text: "Are you sure you want to delete the ",
              style: Get.textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: name,
                  style: Get.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: " community?"),
                TextSpan(
                  text:
                      " This will delete all the groups in it as well and cannot be undone. Proceed with caution.",
                  style: Get.textTheme.bodyLarge,
                )
              ],
            )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.thumb_down),
                  label: const Text("Cancel"),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Get.back();
                    deleteCommunity();
                  },
                  icon: const Icon(Icons.thumb_up),
                  label: const Text("Proceed"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Get.theme.colorScheme.error,
                    // change the border color
                    side: BorderSide(
                      color: Get.theme.colorScheme.error,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void deleteCommunity() async {
    isDeleting.value = true;
    final results = await deleteCommunityUseCase.call(StringParams(id));
    results.fold((failure) {
      isDeleting.value = false;
      showErrorSnackbar(message: failure.message);
    }, (id) {
      Get.snackbar("Success", "Community deleted successfully");
      isDeleting.value = false;
      Get.offAllNamed(AppRoutes.HOME, arguments: 1);
    });
  }

  void updateCommunityName() async {
    if (!communityNameFormKey.currentState!.validate()) {
      showErrorSnackbar(message: "Fix the errors");
      return;
    }
    isUpdating.value = true;
    final updatedCommunity = community.copyWith(
      name: communityNameController.text.trim(),
    );
    final results = await updateCommunityUseCase.call(updatedCommunity);
    results.fold((l) {
      showErrorSnackbar(message: "Error updating community name");
      isUpdating.value = false;
    }, (_) {
      Get.back();
      isUpdating.value = false;
      Get.snackbar("Success", "Community name updated");
      // update the RxName
      nameRx.value = communityNameController.text.trim();
      // update the community name in the community details controller
      communityDetailsController.nameRx.value =
          communityNameController.text.trim();
    });
  }

  void updateCommunityDesc() async {
    if (!communityDescFormKey.currentState!.validate()) {
      showErrorSnackbar(message: "Fix the errors");
      return;
    }
    isUpdating.value = true;
    final updatedCommunity = community.copyWith(
      description: communityDescriptionController.text.trim(),
    );
    final results = await updateCommunityUseCase.call(updatedCommunity);
    results.fold((l) {
      isUpdating.value = false;
      showErrorSnackbar(message: "Error updating community description");
    }, (_) {
      isUpdating.value = false;
      Get.back();
      Get.snackbar("Success", "Community description updated");
      // update the RxDesc
      descriptionRx.value = communityDescriptionController.text.trim();
    });
  }
}
