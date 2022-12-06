import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/community_details_controller.dart';
import 'package:organizer_client/shared/ui/error_page.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class CommunityDetailsPage extends GetView<CommunityDetailsController> {
  const CommunityDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.name),
        actions: [
          IconButton(
            onPressed: () {
              controller.copyCommunityId();
            },
            icon: const Icon(Ionicons.copy_outline),
            tooltip: "Copy community ID",
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
                    onTap: () {},
                    title: Text(group.name),
                    subtitle: Text(group.membersCount),
                  );
                },
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    controller.deleteCommunityWrapper();
                  },
                  icon: const Icon(Ionicons.trash_bin_outline),
                  label: const Text("Delete Community"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.errorColor,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
