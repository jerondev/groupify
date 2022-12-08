import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';

showGroupingExplanation() {
  Color primaryColor = Get.theme.colorScheme.primary;
  showCustomBottomSheet(
    height: Get.height * 0.3,
    child: RichText(
      text: TextSpan(
        style: Get.textTheme.bodyLarge!.copyWith(height: 1.35),
        text:
            "The Grouping Algorithm defines how you want your groups to be created. For instance choosing",
        children: [
          TextSpan(
            text: " Group",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text: " means you want to create ",
          ),
          TextSpan(
            text: "X ",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text:
                "total groups. You just enter the number of groups you want and we take care of the rest",
          ),
          const TextSpan(
            text: " Choosing ",
          ),
          TextSpan(
            text: "People ",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text: "on the other hand means you want at least ",
          ),
          TextSpan(
            text: "X ",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text:
                "number of people in a group, then we will take care of the rest",
          )
        ],
      ),
    ),
  );
}
