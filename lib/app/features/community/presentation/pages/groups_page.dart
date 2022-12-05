import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/groups_controller.dart';
import 'package:organizer_client/app/features/community/presentation/widgets/no_groups.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class GroupsPage extends GetView<GroupsController> {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: Spinner(),
              )
            : controller.isEmpty.value
                ? const NoGroups()
                : GridView.builder(
                    padding: const EdgeInsets.all(14),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final String name = controller.groups[index].name;
                      final String subGroupId = controller.groups[index].id;
                      final groupId = controller.groups[index].communityId;
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(
                                '/sub_group/$subGroupId?groupId=$groupId');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  name,
                                  style: Get.textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.groups.length,
                  ),
      ),
      floatingActionButton: Obx(
        () => controller.isEmpty.value
            ? const SizedBox.shrink()
            : FloatingActionButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.CREATED_COMMUNITIES);
                },
                child: const Icon(Ionicons.people),
              ),
      ),
    );
  }
}
