import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/presentation/widgets/grouping_explanation.dart';

import '../controllers/new_community_.controller.dart';

class GroupingAlgorithmForm extends StatefulWidget {
  const GroupingAlgorithmForm({Key? key}) : super(key: key);

  @override
  State<GroupingAlgorithmForm> createState() => _GroupingAlgorithmFormState();
}

class _GroupingAlgorithmFormState extends State<GroupingAlgorithmForm> {
  NewCommunityController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose a grouping algorithm",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            text:
                "The grouping algorithm defines how you want your groups to be created",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            children: [
              TextSpan(
                text: " Learn more",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    showGroupingExplanation();
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        ...List.generate(
          2,
          (index) {
            return GetBuilder(
              init: controller,
              initState: (_) {},
              builder: (_) {
                return RadioListTile(
                  title: Text(
                    index == 0 ? "Group Count" : "Head Count",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  value: controller.groupingAlgorithms[index],
                  groupValue: controller.selectedAlgorithm,
                  onChanged: controller.changeGroupingAlgorithm,
                );
              },
            );
          },
        )
      ],
    );
  }
}
