// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/social_link_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/add_social_link.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';
import 'package:organizer_client/shared/utils/copy_to_clipboard.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupDetailsController extends GetxController {
  final String groupId = Get.arguments['groupId'];
  final String groupName = Get.arguments['groupName'];
  RxBool isLoading = false.obs;
  RxBool errorOccurred = false.obs;
  RxBool isAddingSocial = false.obs;
  List<Widget> socialMediaIcons = [
    Tooltip(
      message: "WhatsApp",
      child: Image.asset(
        'assets/socials/whatsapp.png',
        width: 30,
      ),
    ),
    Tooltip(
      message: "Telegram",
      child: Image.asset(
        'assets/socials/telegram.png',
        width: 30,
      ),
    ),
    Tooltip(
      message: "Discord",
      child: Image.asset(
        'assets/socials/discord.png',
        width: 30,
      ),
    ),
    Tooltip(
      message: "Slack",
      child: Image.asset(
        'assets/socials/slack.png',
        width: 30,
      ),
    ),
  ];
  List<bool> selectedSocial = [
    true,
    false,
    false,
    false,
  ];
  Widget socialIconToDisplay(String type) {
    switch (type) {
      case "WhatsApp":
        return socialMediaIcons[0];
      case "Telegram":
        return socialMediaIcons[1];
      case "Discord":
        return socialMediaIcons[2];
      case "Slack":
        return socialMediaIcons[3];
      default:
        return socialMediaIcons[0];
    }
  }

  List socialNames = [
    "WhatsApp",
    "Telegram",
    "Discord",
    "Slack",
  ];
  final TextEditingController groupLinkController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void addSocialGroup() async {
    if (!formKey.currentState!.validate()) {
      showErrorSnackbar(message: "Please enter a valid link");
      return;
    }
    // check if the group doesn't already have the same social link
    for (final social in group.socialLinks) {
      if (social.type == socialNames[selectedSocial.indexOf(true)]) {
        showErrorSnackbar(message: "Group already has this social link");
        return;
      }
    }
    isAddingSocial.value = true;
    final results = await addSocialLinkUseCase.call(AddSocialLinkParams(
      groupId: groupId,
      socialLink: SocialLinkEntity(
        link: groupLinkController.text.trim(),
        type: socialNames[selectedSocial.indexOf(true)],
      ),
    ));
    results.fold((failure) {
      isAddingSocial.value = false;
      showErrorSnackbar(message: failure.message);
    }, (success) {
      group.socialLinks.add(success);
      isAddingSocial.value = false;
      Get.back();
      Get.snackbar('Success',
          "${socialNames[selectedSocial.indexOf(true)]} group added");
      update();
    });
  }

  void toggleSocial(int index) {
    for (int i = 0; i < selectedSocial.length; i++) {
      if (i == index) {
        selectedSocial[i] = true;
      } else {
        selectedSocial[i] = false;
      }
    }
    update();
  }

  void launchSocialLink(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      showErrorSnackbar(message: "Could not open link");
    }
  }

  late GroupEntity group;
  final FindGroupUseCase findGroupUseCase;
  final AddSocialLinkUseCase addSocialLinkUseCase;
  GroupDetailsController({
    required this.findGroupUseCase,
    required this.addSocialLinkUseCase,
  });

  @override
  void onInit() {
    findGroup();
    super.onInit();
  }

  void copyGroupId() {
    copyToClipboard(groupId);
    Get.snackbar("Success", "Group Id copied to clipboard");
  }

  void findGroup() async {
    isLoading.value = true;
    final results = await findGroupUseCase.call(StringParams(groupId));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      errorOccurred.value = true;
      isLoading.value = false;
    }, (success) {
      group = success;
      isLoading.value = false;
    });
  }
}
