import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_preview_controller.dart';

class GroupPreviewPage extends GetView<GroupPreviewController> {
  const GroupPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Members'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.picture_as_pdf_outlined),
              onPressed: controller.exportPdf,
              splashRadius: 24,
              tooltip: "Download group data",
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: controller.groupEntity.members.length,
          itemBuilder: (context, index) {
            final member = controller.groupEntity.members[index];
            return ListTile(
              title: Text(member.fullName),
              subtitle: Text(member.phoneNumber),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(member.avatar),
              ),
            );
          },
        ),
      ),
    );
  }
}
