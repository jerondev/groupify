import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/account/presentation/controllers/profile_controller.dart';
import 'package:organizer_client/shared/theme/theme.dart';
import 'package:organizer_client/shared/ui/custom_avatar.dart';
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
              Form.of(primaryFocus!.context!).save();
            },
            key: controller.formKey,
            child: Column(
              children: [
                Hero(
                  tag: controller.user.id,
                  child: CustomAvatar(
                    imageUrl: controller.avatar,
                    radius: 70,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    TextButton.icon(
                        onPressed: controller.showHideProfileExplanation,
                        icon: const Icon(Ionicons.help_circle_outline),
                        label: const Text("Hide Profile")),
                    const Spacer(),
                    GetBuilder(
                      init: controller,
                      initState: (_) {},
                      builder: (_) {
                        return CupertinoSwitch(
                          value: controller.isProfileHidden,
                          onChanged: controller.toggleHideProfile,
                          activeColor: Get.theme.colorScheme.primary,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                    contentPadding: inputPadding,
                    hintText: "Phone Number",
                    alignLabelWithHint: true,
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
        ),
      ),
    );
  }
}
