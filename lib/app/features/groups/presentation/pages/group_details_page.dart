import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_details_controller.dart';
import 'package:organizer_client/shared/ui/error_page.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class GroupDetailsPage extends GetView<GroupDetailsController> {
  const GroupDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => controller.isLoading.value
            ? const SizedBox.shrink()
            : Text(controller.group.name)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                controller.shareSubGroup();
              },
              splashRadius: 24,
            ),
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

          return ListView.builder(
            itemCount: controller.group.members.length,
            itemBuilder: (BuildContext context, int index) {
              final member = controller.group.members[index];
              final isMe = member.id == FirebaseAuth.instance.currentUser!.uid;
              return ListTile(
                title: Text(isMe ? "You" : member.fullName),
                subtitle: Text(member.phoneNumber),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(member.profile),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
