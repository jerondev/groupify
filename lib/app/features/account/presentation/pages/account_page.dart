import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/account/presentation/controllers/account_controller.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/theme/theme_controller.dart';
import 'package:organizer_client/shared/ui/custom_avatar.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              child: Obx(() => controller.isLoading.value
                  ? const Center(child: Spinner())
                  : Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: CircleAvatar(
                            radius: 53,
                            backgroundColor:
                                Theme.of(context).secondaryHeaderColor,
                            child: CustomAvatar(
                              imageUrl: controller.appUser.profile,
                              radius: 50,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.appUser.fullName,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              controller.appUser.email,
                              style: Theme.of(context).textTheme.titleSmall!,
                            ),
                            const SizedBox(height: 5),
                            TextButton.icon(
                              onPressed: () {
                                Get.toNamed(AppRoutes.PROFILE,
                                    arguments: controller.appUser);
                              },
                              icon: const Icon(Ionicons.color_wand_outline),
                              label: const Text("Edit Profile"),
                            )
                          ],
                        )
                      ],
                    )),
            ),
            const Divider(height: 0),
            const SizedBox(height: 5),
            ListTile(
              title: const Text("Theme"),
              leading: const Icon(Icons.light_outlined),
              trailing: GetBuilder<ThemeController>(
                init: ThemeController(),
                initState: (_) {},
                builder: (controller) {
                  return ToggleButtons(
                    selectedBorderColor: Theme.of(context).colorScheme.primary,
                    isSelected: controller.selectedThemeIcon,
                    onPressed: (index) {
                      switch (index) {
                        case 0:
                          controller.enableLightMode();
                          break;
                        case 1:
                          controller.enableSystemThemeMode();
                          break;
                        case 2:
                          controller.enableDarkMode();
                          break;
                        default:
                      }
                    },
                    children: controller.themeIcons,
                  );
                },
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text("Share App"),
              leading: const Icon(Icons.share_outlined),
            ),
            ListTile(
              onTap: () {},
              title: const Text("Rate App"),
              leading: const Icon(Ionicons.heart_outline),
            ),
            ListTile(
              onTap: () {},
              title: const Text("Privacy"),
              leading: const Icon(Ionicons.document_text_outline),
            ),
            ListTile(
              onTap: () {
                controller.signOut();
              },
              title: const Text("Log out"),
              leading: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
      ),
    );
  }
}

/* 
Row(
 

 */