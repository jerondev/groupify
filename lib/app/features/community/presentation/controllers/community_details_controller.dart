import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/usecases/delete_community.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_groups.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';
import 'package:organizer_client/shared/utils/copy_to_clipboard.dart';

class CommunityDetailsController extends GetxController {
  final CommunityEntity _community = Get.arguments;
  String get name => _community.name;
  String get id => _community.id;
  final FindGroupsUseCase findGroupsUseCase;
  final DeleteCommunityUseCase deleteCommunityUseCase;
  RxBool isLoading = false.obs;
  RxBool errorOccurred = false.obs;
  RxBool isDeleting = false.obs;
  late List<GroupEntity> groups;
  CommunityDetailsController({
    required this.findGroupsUseCase,
    required this.deleteCommunityUseCase,
  });

  @override
  void onInit() {
    findGroups();
    super.onInit();
  }

  copyCommunityId() {
    copyToClipboard(id);
    Get.snackbar("Success", "Community Id copied to clipboard");
  }

  void findGroups() async {
    isLoading.value = true;
    final results = await findGroupsUseCase.call(StringParams(id));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      errorOccurred.value = true;
      isLoading.value = false;
    }, (success) {
      groups = success;
      groups.sort((a, b) {
        final aNumber = int.parse(a.name.split(' ')[1]);
        final bNumber = int.parse(b.name.split(' ')[1]);
        return aNumber.compareTo(bNumber);
      });
      isLoading.value = false;
    });
  }

  void deleteCommunityWrapper() async {
    showCustomBottomSheet(
      child: Expanded(
        child: Column(
          children: [
            Text(
              "Are you sure you want to delete the ${name.toUpperCase()} community? This will delete all the groups in it as well and cannot be undone. Proceed with caution.",
              style: Get.textTheme.bodyText1,
            ),
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
