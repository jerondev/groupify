import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';

void showGroupingResults({
  required int resultingPeoplePerGroup,
  required int resultingPeopleWithoutGroup,
  required int resultingTotalGroups,
  required VoidCallback onConfirm,
}) {
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
              if (resultingPeopleWithoutGroup == 0 &&
                  resultingPeoplePerGroup != 1)
                const TextSpan(
                  text: " members",
                ),
              if (resultingPeopleWithoutGroup == 0 &&
                  resultingPeoplePerGroup == 1)
                const TextSpan(
                  text: " member",
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
                foregroundColor: Get.theme.colorScheme.error,
                // change the border color
                side: BorderSide(
                  color: Get.theme.colorScheme.error,
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: onConfirm,
              icon: const Icon(Icons.thumb_up),
              label: const Text("Proceed"),
            ),
          ],
        )
      ],
    ),
  ));
}
