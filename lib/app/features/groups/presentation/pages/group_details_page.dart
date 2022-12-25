import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_details_controller.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/error_page.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class GroupDetailsPage extends GetView<GroupDetailsController> {
  const GroupDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.groupName),
        actions: [
          Obx(
            () => !controller.isLoading.value && !controller.group.isAnonymous
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      tooltip: "Copy group Id",
                      icon: const Icon(Ionicons.copy_outline),
                      onPressed: () {
                        controller.copyGroupId();
                      },
                      splashRadius: 24,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: Spinner(),
            );
          }
          if (controller.errorOccurred.value) {
            return ErrorPage(
              callback: () {
                controller.findGroup();
              },
            );
          }

          return const Center(
            child: Text(
              "Messages from Community Admin will appear here",
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
      floatingActionButton: Obx(
        () => controller.isLoading.value
            ? const SizedBox.shrink()
            : FloatingActionButton.extended(
                onPressed: () {
                  Get.toNamed(AppRoutes.GROUP_CHAT, arguments: {
                    'groupId': controller.groupId,
                    'groupName': controller.groupName,
                    "group": controller.group,
                  });
                },
                icon: const Icon(Ionicons.chatbubble_ellipses_outline),
                label: const Text("Group Chat"),
              ),
      ),
    );
  }
}
