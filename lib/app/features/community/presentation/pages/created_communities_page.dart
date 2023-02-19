import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/created_communities_controller.dart';
import 'package:organizer_client/app/features/community/presentation/widgets/no_communities.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/error_page.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class CreatedCommunitiesPage extends GetView<CreatedCommunitiesController> {
  const CreatedCommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Communities'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: Spinner(),
          );
        }
        if (controller.errorOccurred.value) {
          return ErrorPage(callback: () {
            controller.communities
                .bindStream(controller.findCreatedCommunities());
          });
        }
        if (controller.communities.isEmpty) {
          return const NoCommunities();
        }
        return ListView.builder(
          itemCount: controller.communities.length,
          itemBuilder: (BuildContext context, int index) {
            final community = controller.communities[index];
            return ListTile(
              title: Text(
                community.name,
              ),
              subtitle: Text(
                community.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(IconlyBroken.arrow_right_2),
              onTap: () {
                Get.toNamed(
                  AppRoutes.COMMUNITY_DETAILS,
                  arguments: community,
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoutes.NEW_COMMUNITY);
        },
        label: const Text("New Community"),
        icon: const Icon(Ionicons.add),
      ),
    );
  }
}
