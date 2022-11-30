import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/groups_controller.dart';
import 'package:organizer_client/app/features/groups/presentation/widgets/no_groups.dart';

class GroupsPage extends GetView<GroupsController> {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
      ),
      body: Obx(
        () => controller.isEmpty.value
            ? const NoGroups()
            : const Center(
                child: Text('Groups'),
              ),
      ),
    );
  }
}
