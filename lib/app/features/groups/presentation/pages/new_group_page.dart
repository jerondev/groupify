import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/new_group.controller.dart';
import 'package:organizer_client/app/features/groups/presentation/widgets/grouping_explanation.dart';

class NewGroupPage extends GetView<NewGroupController> {
  const NewGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Group'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(14),
          children: [
            Form(
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 8,
                    autofocus: true,
                    validator: (value) {
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Group Code",
                      helperText: "CSM 257",
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Group Name",
                      helperText: "Structured Program Design",
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: const InputDecoration(
                      labelText: "Total People",
                      helperText: "520",
                      counter: SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Tooltip(
                        message: "More info on Grouping Methods",
                        child: TextButton.icon(
                          onPressed: () {
                            showGroupingExplanation();
                          },
                          icon: const Icon(Ionicons.information_circle_outline),
                          label: const Text('Grouping Method'),
                        ),
                      ),
                      ToggleButtons(
                        constraints: const BoxConstraints(
                          minHeight: 36,
                          minWidth: 65,
                        ),
                        isSelected: const [false, true],
                        selectedBorderColor: Get.theme.colorScheme.primary,
                        onPressed: (index) {},
                        children: const [
                          Text("Group"),
                          Text("People"),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
