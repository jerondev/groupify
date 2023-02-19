import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/groups_controller.dart';
import 'package:organizer_client/app/features/groups/presentation/widgets/no_groups.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/error_page.dart';

class GroupsPage extends GetView<GroupsController> {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = MediaQuery.of(context).size.width ~/ 170;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
      ),
      body: Obx(() {
        if (controller.errorOccurred.value) {
          return ErrorPage(
            subMessage: "Check your internet connection and try again",
            callback: () {
              controller.groups.bindStream(controller.findJoinedGroups());
            },
          );
        }
        if (controller.groups.isEmpty) {
          return const NoGroups();
        }
        return ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            final group = controller.groups[index];
            return ListTile(
              title: Text(group.name),
              subtitle: Text(group.communityName),
              onTap: () {
                Get.toNamed(
                  AppRoutes.GROUP_DETAILS,
                  arguments: {
                    "groupId": group.id,
                    "groupName": group.name,
                    "communityId": group.communityId,
                  },
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.CREATED_COMMUNITIES);
        },
        child: const Icon(IconlyLight.user_1),
      ),
    );
  }
}
