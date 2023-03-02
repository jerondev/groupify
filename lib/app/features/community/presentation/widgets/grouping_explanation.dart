import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';

showGroupingExplanation() {
  Color primaryColor = Get.theme.colorScheme.primary;
  showCustomBottomSheet(
    height: Get.height * 0.55,
    isScrollControlled: true,
    child: RichText(
      text: TextSpan(
        style: Get.textTheme.bodyLarge!.copyWith(height: 1.35),
        text: "The",
        children: [
          TextSpan(
            text: " Group Count Algorithm ",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text:
                "groups members based on the total number of groups you want to create. For example, if you have 20 members and you select a total of 4 groups, Groupify will automatically create 4 groups with an equal number of members in each group. This algorithm is useful when you want to create a specific number of groups, regardless of the size of each group. On the other hand, The ",
          ),
          TextSpan(
            text: "Head Count Algorithm",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text:
                " groups members based on the number of people you want in each group. For example, if you have 20 members and you select a group size of 5, Groupify will automatically create 4 groups of 5 members each. This algorithm is useful when you want to create groups of a specific size for an assignment or project.",
          ),
        ],
      ),
    ),
  );
}
