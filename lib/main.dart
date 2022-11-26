import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:organizer_client/app/features/register/presentation/bindings/register_binding.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Organizer Client',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: AppRoutes.REGISTER,
      getPages: AppPages.pages,
      initialBinding: RegisterBinding(),
      defaultTransition: Transition.cupertino,
    );
  }
}
