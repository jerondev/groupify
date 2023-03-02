import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/community_details_controller.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/error_page.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

import '../../../deeplink/data/generate_link.dart';

class CommunityDetailsPage extends GetView<CommunityDetailsController> {
  const CommunityDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(controller.nameRx.value),
        ),
        actions: [
          IconButton(
            onPressed: () {
              generateDeepLink(
                path: 'join/community/${controller.community.id}',
                title:
                    "Join ${controller.community.name} community on Groupify",
                description: controller.community.description,
              );
            },
            icon: const Icon(Ionicons.copy_outline),
            tooltip: "Share Community",
            splashRadius: 24,
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(
                AppRoutes.COMMUNITY_SETTINGS,
                arguments: controller.community,
              );
            },
            icon: const Icon(Ionicons.settings_outline),
            tooltip: "Community Settings",
            splashRadius: 24,
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Spinner();
          }
          if (controller.errorOccurred.value) {
            return ErrorPage(
              callback: () {
                controller.findGroups();
              },
            );
          }
          return Column(
            children: [
              Expanded(
                  child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.groups.length,
                itemBuilder: (context, index) {
                  final group = controller.groups[index];
                  return ListTile(
                    onTap: group.members.isEmpty
                        ? null
                        : () {
                            Get.toNamed(
                              AppRoutes.GROUP_PREVIEW,
                              arguments: {
                                "group": group,
                              },
                            );
                          },
                    title: Text(group.name),
                    subtitle: Text(group.membersCount),
                    trailing: const Icon(IconlyBroken.arrow_right_2),
                  );
                },
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.COMMUNITY_CHAT,
                      arguments: {
                        "community": controller.community,
                      },
                    );
                  },
                  icon: const Icon(Ionicons.chatbubble_ellipses_outline),
                  label: const Text("Broadcast Message"),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
