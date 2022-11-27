import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/account/presentation/controllers/account_controller.dart';
import 'package:organizer_client/shared/theme/theme_controller.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      radius: 53,
                      backgroundColor: Get.theme.secondaryHeaderColor,
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/user.jpg'),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Katie Howard",
                        style: Get.textTheme.headline6,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "jada@bol.pe",
                        style: Get.theme.textTheme.bodySmall,
                      )
                    ],
                  )
                ],
              ),
            ),
            const Divider(height: 0),
            const SizedBox(height: 5),
            // ExpansionTile(
            //   leading: const Icon(Ionicons.bulb_outline),
            //   title: const Text("Theme"),
            //   children: [
            //     GetBuilder<ThemeController>(
            //       init: ThemeController(),
            //       initState: (_) {},
            //       builder: (controller) {
            //         return ListTile(
            //           onTap: () {
            //             controller.enableLightMode();
            //           },
            //           leading: const Icon(Ionicons.sunny_outline),
            //           title: const Text("Light Mode"),
            //           trailing: !controller.isDarkMode
            //               ? const Icon(Ionicons.checkmark)
            //               : null,
            //         );
            //       },
            //     ),
            //     GetBuilder<ThemeController>(
            //       init: ThemeController(),
            //       initState: (_) {},
            //       builder: (controller) {
            //         return ListTile(
            //           onTap: () {
            //             controller.enableDarkMode();
            //           },
            //           leading: const Icon(Ionicons.moon_outline),
            //           title: const Text("Dark Mode"),
            //           trailing: controller.isDarkMode
            //               ? const Icon(Ionicons.checkmark)
            //               : null,
            //         );
            //       },
            //     ),
            //   ],
            // ),
            ListTile(
              title: const Text("Theme"),
              leading: const Icon(Icons.light_outlined),
              trailing: GetBuilder<ThemeController>(
                init: ThemeController(),
                initState: (_) {},
                builder: (controller) {
                  return ToggleButtons(
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 35,
                    ),
                    borderRadius: BorderRadius.circular(100),
                    selectedBorderColor: Get.theme.colorScheme.primary,
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
                    selectedColor: Get.theme.primaryColor,
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
              title: const Text("Privacy Policy"),
              leading: const Icon(Icons.privacy_tip_outlined),
            ),
            ListTile(
              onTap: () {},
              title: const Text("Log out"),
              leading: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
