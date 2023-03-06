import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:groupify/app/features/register/presentation/controllers/user_details_controller.dart';
import 'package:groupify/shared/theme/theme.dart';
import 'package:groupify/shared/ui/snackbars.dart';
import 'package:groupify/shared/validation/validator.dart';

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
                Form.of(primaryFocus!.context!).save();
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
                      contentPadding: inputPadding,
                      labelText: "Full Name",
                      helperText: "This will be your public facing name",
                    ),
                  ),
                  const SizedBox(height: 30),
                  IntlPhoneField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controller.phoneNumberController,
                    decoration: const InputDecoration(
                      hintText: "Phone Number",
                      helperText:
                          "Only Community admins can see your phone number",
                      alignLabelWithHint: true,
                      contentPadding: inputPadding,
                    ),
                    showDropdownIcon: false,
                    flagsButtonPadding:
                        const EdgeInsets.symmetric(horizontal: 15),
                    initialCountryCode: 'GH',
                    countries: const ['GH', 'NG'],
                    validator: (phoneNumber) =>
                        Validator.phoneNumber(phoneNumber?.number),
                    onChanged: (phone) {},
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.register();
                } else {
                  showErrorSnackbar(message: "Please fill all fields");
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
