import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
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
        title: Column(
          children: [
            Text(controller.groupName),
            Text("Community messages will appear here",
                style: Get.textTheme.caption)
          ],
        ),
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
          if (controller.messages.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "Messages from the Community Admin will appear here",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(12),
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 7),
            ),
            itemCount: controller.messages.length,
            itemBuilder: (context, index) {
              final message = controller.messages[index];
              return Column(
                children: [
                  if (index == 0 ||
                      controller.messages[index - 1].formattedDate !=
                          message.formattedDate)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Chip(
                        label: Text(message.formattedDate),
                        avatar: const Icon(IconlyBroken.calendar),
                      ),
                    ),
                  ChatBubble(
                    elevation: 0,
                    backGroundColor: Get.theme.colorScheme.secondaryContainer,
                    clipper: ChatBubbleClipper4(),
                    alignment: Alignment.bottomLeft,
                    child: Text(message.content),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        message.formattedTime,
                        style: TextStyle(
                          color: Get.theme.hintColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
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
