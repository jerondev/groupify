import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_details_controller.dart';

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
      body: SafeArea(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final member = controller.group.members[index];
            // if member id is yours, show a different widget
            bool isMe = member.id == FirebaseAuth.instance.currentUser!.uid;
            return ListTile(
              title: Text(isMe ? "You" : member.fullName),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(member.profile),
              ),
              subtitle: Text(member.phoneNumber),
              onTap: () {},
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 0),
          itemCount: controller.group.members.length,
        ),
      ),
    );
  }
}
