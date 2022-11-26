import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  GetStorage themeStore = GetStorage('theme');
  late final themeValue = themeStore.read('isDarkMode');
  late bool isDarkMode;

  void enableDarkMode() {
    Get.changeThemeMode(ThemeMode.dark);
    isDarkMode = true;
    themeStore.write('isDarkMode', true);
    update();
  }

  void enableLightMode() {
    Get.changeThemeMode(ThemeMode.light);
    isDarkMode = false;
    themeStore.write('isDarkMode', false);
    update();
  }

  @override
  void onInit() {
    getSavedTheme();
    super.onInit();
  }

  // get savedTheme value from storage or set it to Get.isDarkMode
  void getSavedTheme() {
    if (themeValue == null) {
      isDarkMode = Get.isDarkMode;
    } else {
      isDarkMode = themeValue;
    }
  }
}
