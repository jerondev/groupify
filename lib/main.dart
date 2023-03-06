// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groupify/app/core/user/data/database/user_local_database.dart';
import 'package:groupify/app/features/deeplink/presentation/controllers/deep_link_controller.dart';
import 'package:groupify/app/routes/app_pages.dart';
import 'package:groupify/injection_container.dart';
import 'package:groupify/shared/theme/theme.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'firebase_options.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    tz.initializeTimeZones();
    await GetStorage.init('theme');
    await GetStorage.init('userBox');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    InitialBinding.inject();
    final localDb = Get.put(UserLocalDatabaseImpl());
    DeepLinkController deepLinkController = Get.put(DeepLinkController());
    final bool isAuthenticated = await localDb.authStatus();
    FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData? dynamicLink) async {
        if (dynamicLink != null) {
          if (isAuthenticated) {
            deepLinkController.handleLink(dynamicLink.link);
          } else {
            GetStorage userBox = GetStorage('userBox');
            userBox.write('pendingDynamicLink', dynamicLink.link.toString());
          }
        }
      },
      onError: (e) async {
        /// Handle error
      },
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(DevicePreview(
      enabled: false,
      builder: (_) => MyApp(
        isAuthenticated: isAuthenticated,
      ),
    ));
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
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
      title: 'Groupify',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: isAuthenticated ? AppRoutes.HOME : AppRoutes.REGISTER,
      themeMode: activeThemeMode,
      getPages: AppPages.pages,
      // initialBinding: InitialBinding(),
      defaultTransition: Transition.cupertino,
    );
  }
}
