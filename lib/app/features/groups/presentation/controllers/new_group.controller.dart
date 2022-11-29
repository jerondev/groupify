import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';

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

    showCustomBottomSheet(
        child: Expanded(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: Get.textTheme.bodyText1,
              text: "There will be ",
              children: [
                TextSpan(
                  text: "$resultingTotalGroups",
                  style: TextStyle(
                    color: Get.theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: " groups, each group will have ",
                ),
                TextSpan(
                  text: "$resultingPeoplePerGroup",
                  style: TextStyle(
                    color: Get.theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (resultingPeopleWithoutGroup == 0)
                  const TextSpan(
                    text: " members",
                  ),
                if (resultingPeopleWithoutGroup != 0)
                  const TextSpan(
                    text: " members, with ",
                  ),
                if (resultingPeopleWithoutGroup != 0)
                  TextSpan(
                    text: "$resultingPeopleWithoutGroup",
                    style: TextStyle(
                      color: Get.theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (resultingPeopleWithoutGroup != 0)
                  const TextSpan(
                    text: " Groups having an extra member",
                  ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.thumb_down),
                label: const Text("Cancel"),
                style: OutlinedButton.styleFrom(
                    foregroundColor: Get.theme.colorScheme.error),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.thumb_up),
                label: const Text("Proceed"),
              ),
            ],
          )
        ],
      ),
    ));
  }

  /// Ask user if he wants to discard the form
  Future willPop() async {
    return ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: const Text(
          "Are you sure you want to Exit?",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: "Yes",
          onPressed: () {
            return Get.back(result: true);
          },
        ),
      ),
    );
  }
}
