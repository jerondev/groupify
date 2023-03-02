import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/home/presentation/controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.currentPage),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: (value) {
            controller.changeIndex(value);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(IconlyLight.category),
              selectedIcon: Icon(IconlyBold.category),
              label: "Groups",
            ),
            NavigationDestination(
              icon: Icon(IconlyLight.user_1),
              selectedIcon: Icon(IconlyBold.user_3),
              label: "Communities",
            ),
            NavigationDestination(
              icon: Icon(Ionicons.person_outline),
              selectedIcon: Icon(Ionicons.person),
              label: "Me",
            ),
          ],
        ),
      ),
    );
  }
}
