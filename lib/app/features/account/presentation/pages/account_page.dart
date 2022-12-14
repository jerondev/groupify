import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/account/presentation/controllers/account_controller.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/theme/theme_controller.dart';
import 'package:organizer_client/shared/ui/custom_avatar.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';
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
            // ListTile(
            //   onTap: () {},
            //   title: const Text("Share App"),
            //   leading: const Icon(Icons.share_outlined),
            // ),
            // ListTile(
            //   onTap: () {},
            //   title: const Text("Rate App"),
            //   leading: const Icon(Ionicons.heart_outline),
            // ),
            ListTile(
              onTap: () {},
              title: const Text("Privacy"),
              leading: const Icon(Ionicons.document_text_outline),
            ),
            ListTile(
              onTap: () {
                showCustomBottomSheet(
                  height: Get.height * 0.6,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 6),
                        child: Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage('assets/profile.jpg'),
                          ),
                        ),
                      ),
                      const Text(
                        "Tetteh Jeron Asiedu",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Hi there, thanks for downloading my app, I'm a highly skilled and motivated fullstack web and mobile app developer with experience in designing, developing and implementing cutting-edge web and mobile applications.",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "I'm currently available for hire, if you have any project you would like to discuss, please feel free to contact me.",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: controller.socialMediaIcons
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  splashRadius: 24,
                                  onPressed: () {
                                    controller.launchSocialLink(e.url);
                                  },
                                  color: e.color,
                                  icon: e.icon,
                                ),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                );
              },
              title: const Text("About Developer"),
              leading: const Icon(Ionicons.code_outline),
            ),
            ListTile(
              onTap: () {
                controller.signOut();
              },
              title: const Text("Log out"),
              leading: const Icon(Ionicons.walk_outline),
            ),
          ],
        ),
      ),
    );
  }
}
