import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    // responsive crossAxisCount
    final int crossAxisCount = MediaQuery.of(context).size.width ~/ 180;
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
          return ErrorPage(callback: () {});
        }
        if (controller.noCommunities.value) {
          return const NoCommunities();
        }
        return GridView.builder(
          padding: const EdgeInsets.all(14),
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final String name = controller.groups[index].name;
            final int totalPeople = controller.groups[index].totalPeople;
            return Card(
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.COMMUNITY_DETAILS,
                    arguments: controller.groups[index],
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        name,
                        style: Get.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$totalPeople people',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: controller.groups.length,
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
