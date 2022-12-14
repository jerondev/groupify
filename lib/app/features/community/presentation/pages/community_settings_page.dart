import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/community_settings_controller.dart';
import 'package:organizer_client/shared/enums/spinner.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class CommunitySettingsPage extends GetView<CommunitySettingsController> {
  const CommunitySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
              onTap: () {},
              title: const Text('Community name'),
              subtitle: Text(controller.name),
              trailing: IconButton(
                onPressed: () {
                  showCustomBottomSheet(
                    child: Flexible(
                      child: Column(
                        children: [
                          Form(
                            key: controller.communityNameFormKey,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: controller.communityNameController,
                              textInputAction: TextInputAction.done,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textCapitalization: TextCapitalization.words,
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
                          ),
                          const Spacer(),
                          SizedBox(
                            width: double.maxFinite,
                            child: Obx(
                              () => ElevatedButton.icon(
                                onPressed: controller.isUpdating.value
                                    ? null
                                    : () {
                                        controller.updateCommunityName();
                                      },
                                icon: controller.isUpdating.value
                                    ? const Spinner(
                                        size: SpinnerSize.sm,
                                      )
                                    : const Icon(Ionicons.cloud_upload_outline),
                                label: const Text("Update"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: Image.asset(
                  'assets/edit_icon.png',
                  width: 20,
                  color: Get.theme.colorScheme.onSurface,
                ),
                tooltip: "Edit community name",
                splashRadius: 24,
              )),
          ListTile(
            title: const Text('Community Description'),
            subtitle: Text(controller.community.description),
            isThreeLine: controller.community.description.length > 50,
            trailing: IconButton(
              onPressed: () {
                showCustomBottomSheet(
                  child: Flexible(
                    child: Column(
                      children: [
                        Form(
                          key: controller.communityDescFormKey,
                          child: TextFormField(
                            controller:
                                controller.communityDescriptionController,
                            maxLines: 3,
                            minLines: 1,
                            textInputAction: TextInputAction.done,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            maxLength: 70,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 10,
                              ),
                              labelText: "Description",
                              helperText: "What this community is about",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter community description.";
                              }
                              return null;
                            },
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.maxFinite,
                          child: Obx(
                            () => ElevatedButton.icon(
                              onPressed: controller.isUpdating.value
                                  ? null
                                  : () {
                                      controller.updateCommunityDesc();
                                    },
                              icon: controller.isUpdating.value
                                  ? const Spinner(
                                      size: SpinnerSize.sm,
                                    )
                                  : const Icon(Ionicons.cloud_upload_outline),
                              label: const Text("Update"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: Image.asset(
                'assets/edit_icon.png',
                width: 20,
                color: Get.theme.colorScheme.onSurface,
              ),
              tooltip: "Edit community Description",
              splashRadius: 24,
            ),
          ),
          ListTile(
            onTap: () {},
            title: const Text('Community ID'),
            subtitle: Text(controller.id),
            trailing: IconButton(
              onPressed: () {
                controller.copyCommunityId();
              },
              icon: const Icon(Ionicons.copy_outline),
              tooltip: "Copy community ID",
              splashRadius: 24,
            ),
          ),
          ListTile(
            title: const Text('IsAnonymous'),
            subtitle: Text(controller.community.isAnonymous.toString()),
            trailing: CupertinoSwitch(
              value: controller.community.isAnonymous,
              onChanged: (value) {},
              activeColor: Get.theme.colorScheme.primary,
            ),
          ),
          ListTile(
            title: const Text('Total groups'),
            subtitle: Text("${controller.community.totalGroups}"),
          ),
          ListTile(
            title: const Text('People per group'),
            subtitle: Text("${controller.community.peoplePerGroup}"),
          ),
          ListTile(
            title: const Text('Total members'),
            subtitle: Text("${controller.community.totalPeople}"),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Obx(
              () => ElevatedButton.icon(
                icon: controller.isDeleting.value
                    ? const Spinner(
                        size: SpinnerSize.sm,
                      )
                    : const Icon(Ionicons.trash_outline),
                onPressed: () {
                  controller.deleteCommunityWrapper();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Get.theme.colorScheme.onError,
                  backgroundColor: Get.theme.colorScheme.error,
                ),
                label: Text(controller.isDeleting.value
                    ? "Deleting..."
                    : "Delete community"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
