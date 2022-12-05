// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanoid/nanoid.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/community/domain/usecases/create_community.dart';
import 'package:organizer_client/app/features/community/presentation/widgets/grouping_results.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/ui/spinner.dart';
import 'package:organizer_client/shared/utils/copy_to_clipboard.dart';

class NewGroupController extends GetxController {
  /// The first value holds the group method and the second value
  /// holds the people method
  List<bool> selectedGroupingMethod = [false, true];
  void changeSelectedGroup(int index) {
    for (var i = 0; i < selectedGroupingMethod.length; i++) {
      selectedGroupingMethod[i] = i == index;
    }
    update();
  }

  final formKey = GlobalKey<FormState>();
  final groupCodeController = TextEditingController();
  final groupNameController = TextEditingController();
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
            return createGroup(
              peoplerPerGroup: resultingPeoplePerGroup,
              totalGroups: resultingTotalGroups,
              totalPeople: totalPeopleInput,
              resultingPeopleWithoutGroup: resultingPeopleWithoutGroup,
            );
          },
          loadingWidget: const Spinner(
            size: 25,
          ),
        );
      },
    );
  }

  final CreateCommunityUseCase createGroupUseCase;
  NewGroupController({
    required this.createGroupUseCase,
  });

  Future createGroup({
    required int peoplerPerGroup,
    required int totalGroups,
    required int totalPeople,
    required int resultingPeopleWithoutGroup,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    final groupId = "grp_${nanoid(10)}";

    final CommunityEntity groupEntity = CommunityEntity(
      createdBy: user!.uid,
      id: groupId,
      name: GetUtils.capitalize(groupNameController.text)!.trim(),
      peoplePerGroup: peoplerPerGroup,
      totalGroups: totalGroups,
      totalPeople: totalPeople,
      // generate unique sub groups based on the groups
      subGroups: List.generate(
        totalGroups,
        (index) => GroupEntity(
          id: "sub_grp_${nanoid(10)}",
          name: "Group ${index + 1}",
          communityId: groupId,
          // if resulting peopler without group is greater than 0
          // then add 1 to the last n groups where n is the number of people without group
          capacity: index < totalGroups - resultingPeopleWithoutGroup
              ? peoplerPerGroup
              : peoplerPerGroup + 1,
          members: const [],
        ),
      ),
    );
    final results = await createGroupUseCase(groupEntity);
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
    }, (groupId) {
      Get.offNamedUntil(AppRoutes.HOME, (route) => false);
      Get.snackbar("Success", "Group created successfully");
      copyToClipboard(groupId);
      Get.snackbar("Success", "Group Id copied to clipboard");
      return true;
    });
  }
}
