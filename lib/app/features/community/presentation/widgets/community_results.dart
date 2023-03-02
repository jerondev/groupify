import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/new_community_.controller.dart';

class CommunityResults extends StatefulWidget {
  const CommunityResults({Key? key}) : super(key: key);

  @override
  State<CommunityResults> createState() => _CommunityResultsState();
}

class _CommunityResultsState extends State<CommunityResults> {
  NewCommunityController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
        text: "${controller.nameController.text.trim()} Community will have",
        children: [
          TextSpan(
            text: " ${controller.resultingTotalGroups}",
            style: TextStyle(
              color: Get.theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text: " groups, each group will have ",
          ),
          TextSpan(
            text: "${controller.resultingPeoplePerGroup}",
            style: TextStyle(
              color: Get.theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (controller.resultingPeopleWithoutGroup == 0 &&
              controller.resultingPeoplePerGroup != 1)
            const TextSpan(
              text: " members.",
            ),
          if (controller.resultingPeopleWithoutGroup == 0 &&
              controller.resultingPeoplePerGroup == 1)
            const TextSpan(
              text: " member",
            ),
          if (controller.resultingPeopleWithoutGroup != 0)
            const TextSpan(
              text: " members, with ",
            ),
          if (controller.resultingPeopleWithoutGroup != 0)
            TextSpan(
              text: "${controller.resultingPeopleWithoutGroup}",
              style: TextStyle(
                color: Get.theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (controller.resultingPeopleWithoutGroup != 0)
            const TextSpan(
              text: " Groups having an extra member.",
            ),
          const TextSpan(
              text: "\n\nProceed to create this awesome community 👏")
        ],
      ),
    );
  }
}
