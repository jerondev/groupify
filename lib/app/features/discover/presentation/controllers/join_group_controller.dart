// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/join_group.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class JoinGroupController extends GetxController {
  final FindGroupUseCase findGroupUseCase;
  final JoinGroupUseCase joinGroupUseCase;
  final String? groupId = Get.parameters['id'];
  late GroupEntity groupEntity;
  RxBool isLoading = false.obs;
  RxBool isJoining = false.obs;
  RxBool errorOccurred = false.obs;
  JoinGroupController({
    required this.findGroupUseCase,
    required this.joinGroupUseCase,
  });
  @override
  void onInit() {
    findGroup();
    super.onInit();
  }

  void findGroup() async {
    isLoading.value = true;
    final results = await findGroupUseCase.call(StringParams(groupId!));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      errorOccurred.value = true;
      isLoading.value = false;
    }, (group) {
      groupEntity = group;
      isLoading.value = false;
    });
  }

  void joinGroupWrapper() async {
    showCustomBottomSheet(
      child: Expanded(
        child: Column(
          children: [
            RichText(
                text: TextSpan(
              text: "Are you sure you want to Join ",
              style: Get.textTheme.bodyText1,
              children: [
                TextSpan(
                  text: groupEntity.name,
                  style: Get.textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: " in ${groupEntity.communityName} community?"),
                TextSpan(
                  text:
                      " Note that you will not be able to join any other group in this community.",
                  style: Get.textTheme.bodyText1,
                )
              ],
            )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Get.theme.colorScheme.error,
                    // change the border color
                    side: BorderSide(
                      color: Get.theme.colorScheme.error,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.thumb_down),
                  label: const Text("Cancel"),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Get.back();
                    joinGroup();
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

  void joinGroup() async {
    isJoining.value = true;
    final results = await joinGroupUseCase.call(JoinGroupParams(
        groupId: groupId!, userId: FirebaseAuth.instance.currentUser!.uid));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      isJoining.value = false;
    }, (_) {
      isJoining.value = false;
      Get.snackbar('Success', 'You have joined the group');
      Get.offNamedUntil(
        AppRoutes.GROUP_DETAILS,
        (route) => route.isFirst,
        arguments: {
          "groupId": groupId,
          "groupName": groupEntity.name,
        },
      );
    });
  }
}
