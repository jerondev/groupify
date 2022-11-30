import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/new_group.controller.dart';
import 'package:organizer_client/app/features/groups/presentation/widgets/grouping_explanation.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';

class NewGroupPage extends GetView<NewGroupController> {
  const NewGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Group'),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(14),
          children: [
            Form(
              onWillPop: () async {
                final shouldPop = await controller.willPop();
                return shouldPop ?? false;
              },
              onChanged: () {
                Form.of(primaryFocus!.context!)!.save();
              },
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: controller.groupNameController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: "Group Name",
                      helperText: "Structured Program Design",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Group Name.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: controller.totalPeopleController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: "Total People",
                      helperText: "Total people involved in this grouping",
                      counter: SizedBox.shrink(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter total Number of People.";
                      }
                      if (int.parse(value) < 2) {
                        return "Total Number of People must be greater than 1.";
                      }
                      return null;
                    },
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: controller.numberOfGroupsController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                labelText: "Number of Groups",
                                helperText: "The total groups you want to have",
                                counter: SizedBox.shrink(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter number of groups.";
                                }
                                if (controller
                                    .totalPeopleController.text.isEmpty) {
                                  return "Please enter total number of people before continuing";
                                }
                                final numberOfPeoplerPerGroup = int.parse(
                                        controller.totalPeopleController.text) /
                                    int.parse(value);
                                if (numberOfPeoplerPerGroup < 2) {
                                  return "A group should have at least 2 people. Consider reducing the number of groups";
                                }

                                return null;
                              },
                            )
                          : TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: controller.peoplePerGroupController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                labelText: "People per Group",
                                helperText:
                                    "The number of people you want a group to have",
                                counter: SizedBox.shrink(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter the number of people per group.";
                                }
                                if (controller
                                    .totalPeopleController.text.isEmpty) {
                                  return "Please enter total number of people before continuing";
                                }
                                final numberOfGroups = int.parse(
                                        controller.totalPeopleController.text) /
                                    int.parse(value);
                                if (numberOfGroups < 2) {
                                  return "There should be at least 2 groups. Consider decreasing the number of people per group";
                                }
                                return null;
                              },
                            );
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.computeGroupData();
                        } else {
                          showErrorSnackbar(
                              message: "Please provide all the information");
                        }
                      },
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
