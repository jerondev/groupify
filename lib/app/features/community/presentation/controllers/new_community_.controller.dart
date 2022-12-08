// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanoid/nanoid.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/usecases/create_community.dart';
import 'package:organizer_client/app/features/community/presentation/widgets/grouping_results.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/enums/spinner.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/ui/spinner.dart';
import 'package:organizer_client/shared/utils/copy_to_clipboard.dart';

class NewGroupController extends GetxController {
  /// The first value holds the group method and the second value
  /// holds the people method
  List<bool> selectedGroupingMethod = [false, true];
  bool anonymity = false;
  void changeSelectedGroup(int index) {
    for (var i = 0; i < selectedGroupingMethod.length; i++) {
      selectedGroupingMethod[i] = i == index;
    }
    update();
  }

  void changeAnonymity(value) {
    anonymity = value;
    update();
  }

  final formKey = GlobalKey<FormState>();
  final communityNameController = TextEditingController();
  final communityDescriptionController = TextEditingController();
  final totalPeopleController = TextEditingController();
  final peoplePerGroupController = TextEditingController();
  final numberOfGroupsController = TextEditingController();
  void computeGroupData() {
    final totalPeopleInput = int.parse(totalPeopleController.text);
    late final int resultingPeoplePerGroup;
    late final int resultingPeopleWithoutGroup;
    late final int resultingTotalGroups;

    /// Check if the selected grouping method is [group]
    if (selectedGroupingMethod[0]) {
      final numberOfGroupsInput = int.parse(numberOfGroupsController.text);
      resultingTotalGroups = numberOfGroupsInput;

      /// get the exact even number of people that can form a group
      resultingPeoplePerGroup = totalPeopleInput ~/ numberOfGroupsInput;

      /// Get the number of people that will be shared across groups
      resultingPeopleWithoutGroup =
          totalPeopleInput.remainder(numberOfGroupsInput);
    } else {
      final peoplePerGroupInput = int.parse(peoplePerGroupController.text);
      resultingPeoplePerGroup = peoplePerGroupInput;

      /// Get the number of groups that can be form without remainder
      resultingTotalGroups = totalPeopleInput ~/ peoplePerGroupInput;

      /// Get the number of people that will be shared across groups
      resultingPeopleWithoutGroup =
          totalPeopleInput.remainder(peoplePerGroupInput);
    }

    showGroupingResults(
      resultingPeoplePerGroup: resultingPeoplePerGroup,
      resultingPeopleWithoutGroup: resultingPeopleWithoutGroup,
      resultingTotalGroups: resultingTotalGroups,
      onConfirm: () {
        Get.back();
        Get.showOverlay(
          asyncFunction: () async {
            return createCommunity(
              peoplerPerGroup: resultingPeoplePerGroup,
              totalGroups: resultingTotalGroups,
              totalPeople: totalPeopleInput,
              resultingPeopleWithoutGroup: resultingPeopleWithoutGroup,
            );
          },
          loadingWidget: const Spinner(
            size: SpinnerSize.md,
          ),
        );
      },
    );
  }

  final CreateCommunityUseCase createCommunityUseCase;
  NewGroupController({
    required this.createCommunityUseCase,
  });

  Future createCommunity({
    required int peoplerPerGroup,
    required int totalGroups,
    required int totalPeople,
    required int resultingPeopleWithoutGroup,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    final communityId = "comm_${nanoid(10)}";

    final CommunityEntity community = CommunityEntity(
      createdBy: user!.uid,
      id: communityId,
      description: communityDescriptionController.text.trim(),
      name: GetUtils.capitalize(communityNameController.text)!.trim(),
      peoplePerGroup: peoplerPerGroup,
      totalGroups: totalGroups,
      totalPeople: totalPeople,
    );
    final List<GroupEntity> groups = List.generate(
      totalGroups,
      (index) {
        /// if resulting peopler without group is greater than 0
        /// then add 1 to the last n groups where n is the number of people without group
        final capacity = index < totalGroups - resultingPeopleWithoutGroup
            ? peoplerPerGroup
            : peoplerPerGroup + 1;
        return GroupEntity(
          id: "grp_${nanoid(10)}",
          name: "Group ${index + 1}",
          isAnonymity: anonymity,
          capacity: capacity,
          members: const [],
          communityId: communityId,
        );
      },
    );
    final results = await createCommunityUseCase
        .call(CreateCommunityParams(community: community, groups: groups));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
    }, (id) {
      Get.offNamedUntil(
          AppRoutes.CREATED_COMMUNITIES, (route) => route.isFirst);
      Get.snackbar("Success", "Community created successfully");
      copyToClipboard(id);
      Get.snackbar("Success", "Group Id copied to clipboard");
    });
  }
}
