import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/groups_controller.dart';
import 'package:organizer_client/app/features/groups/presentation/widgets/no_groups.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/error_page.dart';

class GroupsPage extends GetView<GroupsController> {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
        // add a search bar
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    suggestions: controller.groups,
                    history: [],
                  ),
                );
              },
              splashRadius: 24,
              icon: const Icon(IconlyBroken.search),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.errorOccurred.value) {
          return ErrorPage(
            subMessage: "Check your internet connection and try again",
            callback: () {
              controller.groups.bindStream(controller.findJoinedGroups());
            },
          );
        }
        if (controller.groups.isEmpty) {
          return const NoGroups();
        }
        return ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            final group = controller.groups[index];
            return ListTile(
              title: Text(
                group.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(group.communityName),
                  ),
                  Text(group.membersCount.toString(),
                      style: Get.textTheme.bodyMedium!.copyWith(
                        color: Get.theme.hintColor,
                      )),
                ],
              ),
              trailing: const Icon(IconlyBroken.arrow_right_2),
              onTap: () {
                Get.toNamed(
                  AppRoutes.GROUP_DETAILS,
                  arguments: {
                    "groupId": group.id,
                    "groupName": group.name,
                    "communityId": group.communityId,
                  },
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.CREATED_COMMUNITIES);
        },
        child: const Icon(IconlyLight.user_1),
      ),
    );
  }
}

// custom search delegate
class CustomSearchDelegate extends SearchDelegate {
  final List<GroupEntity> suggestions;
  final List<GroupEntity> history;

  CustomSearchDelegate({required this.suggestions, required this.history});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
        splashRadius: 24,
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      splashRadius: 24,
      icon: const Icon(IconlyBroken.arrow_left),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<GroupEntity> suggestionsList = query.isEmpty
        ? history
        : suggestions
            .where((obj) =>
                obj.name.toLowerCase().contains(query.toLowerCase().trim()) ||
                obj.communityName
                    .toLowerCase()
                    .contains(query.toLowerCase().trim()))
            .toList();

    if (query.isNotEmpty && suggestionsList.isEmpty) {
      return const Center(
        child: Text("No groups found"),
      );
    }

    return ListView.builder(
      itemCount: suggestionsList.length,
      itemBuilder: (BuildContext context, int index) {
        final GroupEntity group = suggestionsList[index];
        return ListTile(
          title: Text(
            group.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(group.communityName),
              ),
              Text(
                group.membersCount,
                style: Get.textTheme.bodyMedium!.copyWith(
                  color: Get.theme.hintColor,
                ),
              ),
            ],
          ),
          onTap: () {
            showResults(context);
            Get.toNamed(
              AppRoutes.GROUP_DETAILS,
              arguments: {
                "groupId": group.id,
                "groupName": group.name,
                "communityId": group.communityId,
              },
            )?.then((value) {
              Get.back();
            });
          },
        );
      },
    );
  }
}
