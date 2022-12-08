// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/usecases/delete_community.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';
import 'package:organizer_client/shared/utils/copy_to_clipboard.dart';

class CommunitySettingsController extends GetxController {
  final CommunityEntity community = Get.arguments;
  String get name => community.name;
  String get id => community.id;
  RxBool isDeleting = false.obs;
  final DeleteCommunityUseCase deleteCommunityUseCase;
  CommunitySettingsController({
    required this.deleteCommunityUseCase,
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
              style: Get.textTheme.bodyText1,
              children: [
                TextSpan(
                  text: name,
                  style: Get.textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: "community?"),
                TextSpan(
                  text:
                      " This will delete all the groups in it as well and cannot be undone. Proceed with caution.",
                  style: Get.textTheme.bodyText1,
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
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Get.theme.colorScheme.error,
                    // change the border color
                    side: BorderSide(
                      color: Get.theme.colorScheme.error,
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Get.back();
                    deleteCommunity();
                  },
                  icon: const Icon(Icons.thumb_up),
                  label: const Text("Proceed"),
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
      Get.offNamedUntil(
          AppRoutes.CREATED_COMMUNITIES, (route) => route.isFirst);
    });
  }
}

/*  Text(
              "Are you sure you want to delete the ${name.toUpperCase()} community? This will delete all the groups in it as well and cannot be undone. Proceed with caution.",
              style: Get.textTheme.bodyText1,
            ), */