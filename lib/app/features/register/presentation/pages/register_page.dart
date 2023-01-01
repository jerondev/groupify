import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/register/presentation/controllers/register_controller.dart';
import 'package:organizer_client/shared/enums/spinner.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 8.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/learning.png',
                width: 300,
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: const Text(
                  "Groupify is a simple and intuitive app that makes it easy to create groups for class assignments. Try Groupify today and experience the power of efficient group collaboration!",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              Obx(
                () => ElevatedButton.icon(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          controller.signInWithGoogle();
                        },
                  icon: controller.isLoading.value
                      ? Spinner(
                          size: SpinnerSize.sm,
                          color: Get.theme.colorScheme.secondary,
                        )
                      : const Icon(Ionicons.logo_google),
                  label: const Text("Continue with Google"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
