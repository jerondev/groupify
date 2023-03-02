// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nanoid/nanoid.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/usecases/create_community.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/enums/spinner.dart';
import 'package:organizer_client/shared/error/exception.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/ui/spinner.dart';
import 'package:organizer_client/shared/utils/copy_to_clipboard.dart';

import '../widgets/community_results.dart';
import '../widgets/description_form.dart';
import '../widgets/group_count_form.dart';
import '../widgets/grouping_algorithm_form.dart';
import '../widgets/head_count_form.dart';
import '../widgets/name_form.dart';
import '../widgets/total_people_form.dart';

class NewCommunityController extends GetxController {
  List<Widget> pages = [
    const NameForm(),
    const DescriptionForm(),
    const TotalPeopleForm(),
    const GroupingAlgorithmForm(),
    const GroupCountForm(),
    // const HeadCountForm(),
    const CommunityResults(),
  ];
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final communitySizeController = TextEditingController();
  final headCountController = TextEditingController();
  final groupCountController = TextEditingController();

  final pageController = PageController(initialPage: 0);
  final currentPage = 0.obs;
  final hideNextButton = true.obs;
  final disableNextButton = false.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  Future<bool> onBackPress() async {
    if (currentPage.value == 0) {
      return true;
    } else {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      return false;
    }
  }

  @override
  void onInit() {
    nameController.addListener(() {
      if (nameController.text.isEmpty) {
        hideNextButton.value = true;
      } else {
        hideNextButton.value = false;
      }
    });
    communitySizeController.addListener(() {
      if (communitySizeController.text.isEmpty) {
        disableNextButton.value = true;
      } else {
        disableNextButton.value = false;
      }
    });
    groupCountController.addListener(() {
      if (groupCountController.text.isEmpty) {
        disableNextButton.value = true;
      } else {
        disableNextButton.value = false;
      }
    });
    headCountController.addListener(() {
      if (headCountController.text.isEmpty) {
        disableNextButton.value = true;
      } else {
        disableNextButton.value = false;
      }
    });

    currentPage.listen((value) {
      if (value == 2 && communitySizeController.text.isEmpty) {
        disableNextButton.value = true;
      } else {
        disableNextButton.value = false;
      }

      if (value == 4) {
        if (selectedAlgorithm == 0 && groupCountController.text.isEmpty) {
          disableNextButton.value = true;
          return;
        } else if (selectedAlgorithm == 0 &&
            groupCountController.text.isNotEmpty) {
          disableNextButton.value = false;
        } else if (selectedAlgorithm == 1 && headCountController.text.isEmpty) {
          disableNextButton.value = true;
        } else {
          disableNextButton.value = false;
        }
      }
    });
    super.onInit();
  }

  /// 0 is group count and second 1 is head count
  List<int> groupingAlgorithms = [0, 1];
  int selectedAlgorithm = 0;
  bool anonymity = false;
  void changeGroupingAlgorithm(int? index) {
    selectedAlgorithm = index!;
    if (selectedAlgorithm == 0) {
      pages = [
        const NameForm(),
        const DescriptionForm(),
        const TotalPeopleForm(),
        const GroupingAlgorithmForm(),
        const GroupCountForm(),
        // const HeadCountForm(),
        const CommunityResults()
      ];
    } else {
      pages = [
        const NameForm(),
        const DescriptionForm(),
        const TotalPeopleForm(),
        const GroupingAlgorithmForm(),
        // const GroupCountForm(),
        const HeadCountForm(),
        const CommunityResults(),
      ];
    }
    update();
  }

  void changeAnonymity(value) {
    anonymity = value;
    update();
  }

  late int resultingPeoplePerGroup;
  late int resultingPeopleWithoutGroup;
  late int resultingTotalGroups;

  void floatingActionBtnPressed() {
    try {
      if (currentPage.value == pages.length - 1) {
        Get.showOverlay(
          asyncFunction: () async {
            return createCommunity(
              peoplerPerGroup: resultingPeoplePerGroup,
              totalGroups: resultingTotalGroups,
              totalPeople: int.parse(communitySizeController.text),
              resultingPeopleWithoutGroup: resultingPeopleWithoutGroup,
            );
          },
          loadingWidget: const Spinner(
            size: SpinnerSize.md,
          ),
        );
      } else if (currentPage.value == pages.length - 2) {
        checkConstraints();
        computeGroupData();
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    } on DeviceException catch (e) {
      showErrorSnackbar(message: e.message);
    }
  }

  Widget buildFloatingActionBtnIcon() {
    if (currentPage.value == pages.length - 1) {
      return const Icon(Ionicons.checkmark);
    }
    if (disableNextButton.value) {
      return const Icon(IconlyLight.danger);
    }
    return const Icon(IconlyBold.arrow_right);
  }

  void checkConstraints() {
    if (selectedAlgorithm == 0) {
      final numberOfPeoplerPerGroup = int.parse(communitySizeController.text) /
          int.parse(groupCountController.text);
      if (numberOfPeoplerPerGroup < 2) {
        throw DeviceException("A group should have at least 2 people");
      }
    } else {
      final numberOfGroups = int.parse(communitySizeController.text) /
          int.parse(headCountController.text);
      if (numberOfGroups < 2) {
        throw DeviceException("A community should have at least 2 groups");
      }
    }
  }

  void computeGroupData() {
    final totalPeopleInput = int.parse(communitySizeController.text);

    /// Check if the selected grouping method is [group]
    if (selectedAlgorithm == 0) {
      final numberOfGroupsInput = int.parse(groupCountController.text);
      resultingTotalGroups = numberOfGroupsInput;

      /// get the exact even number of people that can form a group
      resultingPeoplePerGroup = totalPeopleInput ~/ numberOfGroupsInput;

      /// Get the number of people that will be shared across groups
      resultingPeopleWithoutGroup =
          totalPeopleInput.remainder(numberOfGroupsInput);
    } else {
      final peoplePerGroupInput = int.parse(headCountController.text);
      resultingPeoplePerGroup = peoplePerGroupInput;

      /// Get the number of groups that can be form without remainder
      resultingTotalGroups = totalPeopleInput ~/ peoplePerGroupInput;

      /// Get the number of people that will be shared across groups
      resultingPeopleWithoutGroup =
          totalPeopleInput.remainder(peoplePerGroupInput);
    }
  }

  final CreateCommunityUseCase createCommunityUseCase;
  NewCommunityController({
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
      description: descriptionController.text.trim(),
      name: GetUtils.capitalize(nameController.text)!.trim(),
      peoplePerGroup: peoplerPerGroup,
      totalGroups: totalGroups,
      totalPeople: totalPeople,
      isAnonymous: anonymity,
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
          communityName: GetUtils.capitalize(nameController.text)!.trim(),
          name: "Group ${index + 1}",
          isAnonymous: anonymity,
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
      // move to home page, but make the active index to be the community page
      Get.offAllNamed(AppRoutes.HOME, arguments: 1);
      Get.snackbar("Success", "Community created successfully");
      copyToClipboard(id);
      Get.snackbar("Success", "Community Id copied to clipboard");
    });
  }
}
