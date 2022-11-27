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
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Group Code",
                      helperText: "CSM 257",
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Group Name",
                      helperText: "Structured Program Design",
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    textInputAction: TextInputAction.next,
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
                      GetBuilder<NewGroupController>(
                        init: NewGroupController(),
                        initState: (_) {},
                        builder: (_) {
                          return ToggleButtons(
                            constraints: const BoxConstraints(
                              minHeight: 36,
                              minWidth: 65,
                            ),
                            isSelected: controller.selectedGroupingMethod,
                            selectedBorderColor: Get.theme.colorScheme.primary,
                            onPressed: (int index) {
                              controller.changeSelectedGroup(index);
                            },
                            children: const [
                              Text("Group"),
                              Text("People"),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  GetBuilder(
                    initState: (_) {},
                    init: NewGroupController(),
                    builder: (controller) {
                      return controller.selectedGroupingMethod[0]
                          ? TextFormField(
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              decoration: const InputDecoration(
                                labelText: "Number of Groups",
                                helperText: "10",
                                counter: SizedBox.shrink(),
                              ),
                            )
                          : TextFormField(
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              decoration: const InputDecoration(
                                labelText: "People per Group",
                                helperText: "15",
                                counter: SizedBox.shrink(),
                              ),
                            );
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(),
                      icon: const Icon(Icons.celebration_outlined),
                      label: const Text("Create Group"),
                    ),
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
