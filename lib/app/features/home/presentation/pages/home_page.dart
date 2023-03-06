import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:organizer_client/app/features/account/presentation/pages/account_page.dart';
import 'package:organizer_client/app/features/home/presentation/controllers/home_controller.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/constant/images_path.dart';
import 'package:organizer_client/shared/enums/spinner.dart';
import 'package:organizer_client/shared/ui/appbar_title.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';
import 'package:organizer_client/shared/ui/spinner.dart';
import 'package:upgrader/upgrader.dart';

import '../../../../../shared/ui/custom_avatar.dart';
import '../../../../../shared/ui/empty_page.dart';
import '../../../community/presentation/pages/template_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appBarTitle("Groupify"),
              InkWell(
                onTap: () {
                  Get.to(() => const AccountPage());
                },
                borderRadius: BorderRadius.circular(100),
                child: Obx(
                  () => controller.accountController.isLoading.value
                      ? const Spinner(
                          size: SpinnerSize.sm,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(4),
                          child: CustomAvatar(
                            imageUrl:
                                controller.accountController.appUser.avatar,
                            radius: 19,
                            spinnerSize: SpinnerSize.sm,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        body: EmptyPage(
          illustration: AppImages.noGroups,
          headline: "It's lonely here",
          subText: "Join a community or create your own",
          buttonText: "Join a community",
          onTap: () {
            Get.toNamed(AppRoutes.JOIN_COMMUNITY_WITH_INVITE_LINK);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showCustomBottomSheet(
              height: Get.height * 0.18,
              paddingHorizontal: false,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Get.back();
                      Get.to(() => const CommunityTemplatePage());
                    },
                    leading: const Icon(IconlyBroken.plus),
                    title: const Text("Create Community"),
                  ),
                  ListTile(
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.JOIN_COMMUNITY_WITH_INVITE_LINK);
                    },
                    leading: const Icon(IconlyBroken.add_user),
                    title: const Text("Join Community"),
                  ),
                ],
              ),
            );
          },
          tooltip: 'Create Community',
          child: const Icon(IconlyBroken.plus),
        ),
      ),
    );
  }
}
