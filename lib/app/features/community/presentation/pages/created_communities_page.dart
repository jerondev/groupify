import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
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
        title: const Text('Communities'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    suggestions: controller.communities,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.NEW_COMMUNITY);
        },
        tooltip: 'Create Community',
        child: const Icon(IconlyBroken.plus),
      ),
    );
  }
}

// custom search delegate
class CustomSearchDelegate extends SearchDelegate {
  final List<CommunityEntity> suggestions;
  final List<CommunityEntity> history;

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
    final List<CommunityEntity> suggestionsList = query.isEmpty
        ? history
        : suggestions
            .where((obj) =>
                obj.name.toLowerCase().contains(query.toLowerCase().trim()) ||
                obj.description
                    .toLowerCase()
                    .contains(query.toLowerCase().trim()))
            .toList();

    if (query.isNotEmpty && suggestionsList.isEmpty) {
      return const Center(
        child: Text("No communities found"),
      );
    }

    return ListView.builder(
      itemCount: suggestionsList.length,
      itemBuilder: (BuildContext context, int index) {
        final CommunityEntity community = suggestionsList[index];
        return ListTile(
          title: Text(
            community.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            community.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            showResults(context);
            Get.toNamed(
              AppRoutes.COMMUNITY_DETAILS,
              arguments: community,
            )?.then((value) {
              Get.back();
            });
          },
        );
      },
    );
  }
}
