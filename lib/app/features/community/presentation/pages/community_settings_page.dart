import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/community_settings_controller.dart';
import 'package:organizer_client/shared/enums/spinner.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class CommunitySettingsPage extends GetView<CommunitySettingsController> {
  const CommunitySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
              onTap: () {},
              title: const Text('Community name'),
              subtitle: Text(controller.name),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                tooltip: "Edit community name",
                splashRadius: 24,
              )),
          ListTile(
            onTap: () {},
            title: const Text('Community ID'),
            subtitle: Text(controller.id),
            trailing: IconButton(
              onPressed: () {
                controller.copyCommunityId();
              },
              icon: const Icon(Ionicons.copy_outline),
              tooltip: "Copy community ID",
              splashRadius: 24,
            ),
          ),
          ListTile(
            title: const Text('Community Description'),
            subtitle: Text(controller.community.description),
            isThreeLine: controller.community.description.length > 50,
          ),
          ListTile(
            title: const Text('Total groups'),
            subtitle: Text("${controller.community.totalGroups}"),
          ),
          ListTile(
            title: const Text('Total members'),
            subtitle: Text("${controller.community.totalPeople}"),
          ),
          ListTile(
            title: const Text('People per group'),
            subtitle: Text("${controller.community.peoplePerGroup}"),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Obx(
              () => ElevatedButton.icon(
                icon: controller.isDeleting.value
                    ? const Spinner(
                        size: SpinnerSize.sm,
                      )
                    : const Icon(Ionicons.trash_outline),
                onPressed: () {
                  controller.deleteCommunityWrapper();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Get.theme.colorScheme.onError,
                  backgroundColor: Get.theme.colorScheme.error,
                ),
                label: Text(controller.isDeleting.value
                    ? "Deleting..."
                    : "Delete community"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
