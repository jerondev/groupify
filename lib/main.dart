import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organizer_client/app/features/register/presentation/bindings/register_binding.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/theme/theme.dart';

void main() async {
  await GetStorage.init('theme');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GetStorage themeStore = GetStorage('theme');
    final isDarkMode = themeStore.read('isDarkMode') ?? Get.isDarkMode;
    return GetMaterialApp(
      title: 'Organizer Client',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: AppRoutes.REGISTER,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      getPages: AppPages.pages,
      initialBinding: RegisterBinding(),
      defaultTransition: Transition.cupertino,
    );
  }
}
