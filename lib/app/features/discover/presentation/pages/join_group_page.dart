import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/join_group_controller.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class JoinGroupPage extends GetView<JoinGroupController> {
  const JoinGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => controller.isLoading.value
            ? const SizedBox.shrink()
            : Text(controller.groupEntity.name)),
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: Spinner(),
                )
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final String subGroupName =
                        controller.groupEntity.subGroups[index].name;
                    final int totalMembers =
                        controller.groupEntity.subGroups[index].members.length;
                    final int capacity =
                        controller.groupEntity.subGroups[index].capacity;
                    final String id =
                        controller.groupEntity.subGroups[index].id;
                    final String groupId = controller.groupEntity.id;

                    return ListTile(
                      enabled: totalMembers < capacity,
                      onTap: () {
                        Get.toNamed('/sub_group/$id?groupId=$groupId');
                      },
                      title: Text(subGroupName),
                      subtitle: Text(
                        controller.formatJoinedText(totalMembers, capacity),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0),
                  itemCount: controller.groupEntity.subGroups.length,
                ),
        ),
      ),
    );
  }
}
