import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future showGroupingExplanation() {
  Color primaryColor = Get.theme.colorScheme.primary;
  return Get.bottomSheet(
    SizedBox(
      height: Get.height * 0.35,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Grouping Methods",
                  style: Get.textTheme.headline6,
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: TextButton.styleFrom(
                      foregroundColor: Get.theme.colorScheme.error),
                  child: const Text("Close"),
                )
              ],
            ),
            RichText(
              text: TextSpan(
                style: Get.textTheme.bodyLarge!.copyWith(height: 1.35),
                text:
                    "The Grouping Method defines how you want your groups to be created. For instance choosing",
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
                    text:
                        " Choosing People on the other hand means you want at least ",
                  ),
                  TextSpan(
                    text: "People",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        " Choosing People on the other hand means you want at least ",
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
            )
          ],
        ),
      ),
    ),
    backgroundColor: Get.theme.backgroundColor,
  );
}
