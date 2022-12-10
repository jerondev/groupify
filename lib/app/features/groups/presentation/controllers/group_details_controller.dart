// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';
import 'package:organizer_client/shared/utils/copy_to_clipboard.dart';

class GroupDetailsController extends GetxController {
  final String groupId = Get.arguments['groupId'];
  final String groupName = Get.arguments['groupName'];
  RxBool isLoading = false.obs;
  RxBool errorOccurred = false.obs;
  List<Widget> socialMediaIcons = [
    Image.asset(
      'assets/socials/whatsapp.png',
      width: 30,
    ),
    Image.asset(
      'assets/socials/telegram.png',
      width: 30,
    ),
    Image.asset(
      'assets/socials/discord.png',
      width: 30,
    ),
    Image.asset(
      'assets/socials/slack.png',
      width: 30,
    ),
  ];
  List<bool> selectedSocial = [
    true,
    false,
    false,
    false,
  ];
  final TextEditingController groupLinkController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void addSocialGroup() {
    if (!formKey.currentState!.validate()) {
      showErrorSnackbar(message: "Please enter a valid link");
    }
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

  late GroupEntity group;
  final FindGroupUseCase findGroupUseCase;
  GroupDetailsController({
    required this.findGroupUseCase,
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
