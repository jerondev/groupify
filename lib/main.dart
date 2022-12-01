// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organizer_client/app/core/user/data/database/user_local_database.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/injection_container.dart';
import 'package:organizer_client/shared/theme/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init('theme');
  await GetStorage.init('userBox');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final localDb = Get.put(UserLocalDatabaseImpl());
  final bool isAuthenticated = await localDb.authStatus();
  runApp(DevicePreview(
    enabled: false,
    builder: (_) => MyApp(
      isAuthenticated: isAuthenticated,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.isAuthenticated,
  }) : super(key: key);

  final bool isAuthenticated;

  @override
  Widget build(BuildContext context) {
    GetStorage themeStore = GetStorage('theme');
    final isDarkMode = themeStore.read('isDarkMode');
    late ThemeMode activeThemeMode;
    if (isDarkMode == null) {
      activeThemeMode = ThemeMode.system;
    } else if (isDarkMode == true) {
      activeThemeMode = ThemeMode.dark;
    } else {
      activeThemeMode = ThemeMode.light;
    }
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Organizer Client',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: isAuthenticated ? AppRoutes.HOME : AppRoutes.REGISTER,
      themeMode: activeThemeMode,
      getPages: AppPages.pages,
      initialBinding: InitialBinding(),
      defaultTransition: Transition.cupertino,
    );
  }
}
