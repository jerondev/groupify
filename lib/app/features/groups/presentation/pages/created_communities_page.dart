import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/created_communities_controller.dart';
import 'package:organizer_client/app/features/groups/presentation/widgets/no_communities.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class CreatedCommunitiesPage extends GetView<CreatedCommunitiesController> {
  const CreatedCommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Communities'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: Spinner(),
              )
            : controller.isEmpty.value
                ? const NoCommunities()
                : GridView.builder(
                    padding: const EdgeInsets.all(14),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final String name = controller.groups[index].name;
                      return Card(
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  name,
                                  style: Get.textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.groups.length,
                  ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoutes.NEW_GROUP);
        },
        label: const Text("New Community"),
        icon: const Icon(Ionicons.add),
      ),
    );
  }
}
