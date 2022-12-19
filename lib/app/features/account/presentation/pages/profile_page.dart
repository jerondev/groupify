import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:organizer_client/app/features/account/presentation/controllers/profile_controller.dart';
import 'package:organizer_client/shared/theme/theme.dart';
import 'package:organizer_client/shared/validation/validator.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: const CloseButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Obx(
              () => TextButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        controller.updateUserDetails();
                      },
                child: Text(controller.isLoading.value ? "Saving" : "Save"),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Form(
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
                    alignLabelWithHint: true,
                  ),
                  showDropdownIcon: false,
                  flagsButtonPadding:
                      const EdgeInsets.symmetric(horizontal: 15),
                  initialCountryCode: 'GH',
                  validator: (phoneNumber) =>
                      Validator.phoneNumber(phoneNumber?.number),
                  onChanged: (phone) {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
