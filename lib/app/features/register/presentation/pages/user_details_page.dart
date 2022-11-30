import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/register/presentation/controllers/user_details_controller.dart';
import 'package:organizer_client/shared/validation/validator.dart';

class UserDetailsPage extends GetView<UserDetailsController> {
  const UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almost There'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(14),
          children: [
            RichText(
              text: TextSpan(
                style: Get.textTheme.bodyLarge,
                text: "Hi ",
                children: [
                  TextSpan(
                    text: controller.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Letting us know a little about you will help us serve you better. We will not share your data with anyone.",
            ),
            const SizedBox(height: 20),
            Form(
              onChanged: () {
                Form.of(primaryFocus!.context!)!.save();
              },
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter,
                      FilteringTextInputFormatter.deny(RegExp('[0-9]')),
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    maxLength: 30,
                    textCapitalization: TextCapitalization.words,
                    controller: controller.nameController,
                    validator: Validator.name,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      helperText: "This will be your public facing name",
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    controller: controller.phoneNumberController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: Validator.phoneNumber,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      helperText:
                          "A valid phone number for contacting purposes",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.register();
                } else {
                  Get
                    ..closeAllSnackbars()
                    ..snackbar(
                      "Error",
                      "Please fix the errors",
                      backgroundColor: Get.theme.colorScheme.errorContainer,
                      colorText: Get.theme.colorScheme.onErrorContainer,
                      snackPosition: SnackPosition.BOTTOM,
                      icon: const Icon(Ionicons.warning_outline),
                    );
                }
              },
              icon: const Icon(Icons.celebration),
              label: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
