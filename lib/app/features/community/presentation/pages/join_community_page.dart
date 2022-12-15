import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/join_community_controller.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/shared/ui/error_page.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class JoinCommunityPage extends GetView<JoinCommunityController> {
  const JoinCommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Join Community'),
        ),
        body: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(
                child: Spinner(),
              );
            }
            if (controller.errorOccurred.value) {
              return ErrorPage(callback: () {
                controller.findGroups();
              });
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.groups.length,
              itemBuilder: (BuildContext context, int index) {
                final GroupEntity group = controller.groups[index];
                return ListTile(
                  onTap: () {
                    Get.toNamed('/join_group/${group.id}');
                  },
                  enabled: !group.isFull,
                  title: Text(group.name),
                  trailing: const Icon(Icons.chevron_right),
                  subtitle: Text(
                      group.isFull ? 'This group is full' : group.membersCount),
                );
              },
            );
          },
        ));
  }
}
