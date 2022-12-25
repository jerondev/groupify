import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/groups_controller.dart';
import 'package:organizer_client/app/features/groups/presentation/widgets/no_groups.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/error_page.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class GroupsPage extends GetView<GroupsController> {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = MediaQuery.of(context).size.width ~/ 180;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Spinner();
        }
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
        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(14),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: controller.groups.length,
          itemBuilder: (context, index) {
            final group = controller.groups[index];
            final int membersLength = group.members.length;
            return Card(
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.GROUP_DETAILS,
                    arguments: {
                      "groupId": group.id,
                      "groupName": group.name,
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${group.communityName} community",
                        style: Get.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        group.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        membersLength == 1
                            ? "$membersLength Member"
                            : "$membersLength Members",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
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
