import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/join_group_controller.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/enums/spinner.dart';
import 'package:organizer_client/shared/ui/error_page.dart';
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
                Get.offAllNamed(AppRoutes.HOME);
              },
              message: "Group does not exist",
              buttonText: "Go Back",
            );
          }

          if (controller.groupEntity.isFull) {
            return ErrorPage(
              callback: () {
                Get.offAllNamed(AppRoutes.HOME);
              },
              message: "Group is full",
              buttonText: "Go Back",
            );
          }
          if (controller.groupEntity.isAnonymous) {
            return const Center(
              child: Text(
                "This group is anonymous, you can only see other members after joining",
                textAlign: TextAlign.center,
              ),
            );
          }

          if (controller.groupEntity.members.isEmpty) {
            return const Center(
              child: Text(
                "Be the first person to join this group",
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.groupEntity.members.length,
            itemBuilder: (BuildContext context, int index) {
              final member = controller.groupEntity.members[index];
              return ListTile(
                title: Text(member.fullName),
                subtitle: Text(member.email),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(member.avatar),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Obx(() => FloatingActionButton.extended(
            onPressed: controller.isJoining.value
                ? null
                : () {
                    controller.joinGroupWrapper();
                  },
            label: Text(controller.isJoining.value ? "Joining..." : "Join"),
            icon: controller.isJoining.value
                ? const Spinner(
                    size: SpinnerSize.sm,
                  )
                : const Icon(Ionicons.person_add_outline),
          )),
    );
  }
}
