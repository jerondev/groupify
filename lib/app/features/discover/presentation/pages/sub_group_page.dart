import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/sub_group_controller.dart';
import 'package:organizer_client/shared/ui/custom_avatar.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class SubGroupPage extends GetView<SubGroupController> {
  const SubGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => controller.isLoading.value
            ? const SizedBox.shrink()
            : Text(controller.subGroupEntity.name)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
              splashRadius: 22,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: Spinner(),
                )
              : controller.subGroupEntity.members.isEmpty
                  ? const Center(
                      child: Text(
                        "Be the first person to join this group",
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final member = controller.subGroupEntity.members[index];
                        return ListTile(
                          title: Text(member.name),
                          leading: CustomAvatar(imageUrl: member.profile),
                          subtitle: Text(member.phoneNumber),
                          onTap: () {},
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const Divider(height: 0),
                      itemCount: controller.subGroupEntity.members.length,
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Obx(
          () => controller.isLoading.value
              ? const Spinner()
              : Text("Join ${controller.subGroupEntity.name}"),
        ),
      ),
    );
  }
}
