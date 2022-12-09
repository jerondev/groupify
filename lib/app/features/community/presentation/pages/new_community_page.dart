import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/new_community_.controller.dart';
import 'package:organizer_client/app/features/community/presentation/widgets/anonymity_explanation.dart';
import 'package:organizer_client/app/features/community/presentation/widgets/grouping_explanation.dart';
import 'package:organizer_client/shared/theme/theme.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';

class NewCommunityPage extends GetView<NewGroupController> {
  const NewCommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Community'),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(14),
          children: [
            Form(
              onChanged: () {
                Form.of(primaryFocus!.context!)!.save();
              },
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: controller.communityNameController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 10,
                      ),
                      labelText: "Community Name",
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
                    controller: controller.communityDescriptionController,
                    // make it multiline
                    maxLines: 3,
                    minLines: 1,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 70,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 10,
                      ),
                      labelText: "Description",
                      helperText: "A community for structured program design",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter community description.";
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
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 10,
                      ),
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
                          label: const Text('Grouping Algorithm'),
                        ),
                      ),
                      GetBuilder<NewGroupController>(
                        init: controller,
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
                    init: controller,
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
                                contentPadding: inputPadding,
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
                                contentPadding: inputPadding,
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
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            showAnonymityExplanation();
                          },
                          icon: const Icon(Ionicons.help_circle_outline),
                          label: const Text("Anonymity")),
                      const Spacer(),
                      GetBuilder(
                        init: controller,
                        initState: (_) {},
                        builder: (_) {
                          return CupertinoSwitch(
                            value: controller.anonymity,
                            onChanged: (value) {
                              controller.changeAnonymity(value);
                            },
                            activeColor: Get.theme.colorScheme.primary,
                          );
                        },
                      ),
                    ],
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
                      label: const Text("Create Community"),
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
