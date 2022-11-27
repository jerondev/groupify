import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/register/presentation/controllers/user_details_controller.dart';
import 'package:organizer_client/shared/validation/validator.dart';

class UserDetailsPage extends GetView<UserDetailsController> {
  const UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almost There'),
        centerTitle: true,
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
                controller.isFormValid.value =
                    controller.formKey.currentState!.validate();
              },
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    controller: controller.nameController,
                    validator: Validator.name,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      helperText: "Tetteh Jeron Asiedu",
                    ),
                    onChanged: (name) {},
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller.phoneNumberController,
                    validator: Validator.phoneNumber,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      helperText: "0544751048",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Obx(
              () => ElevatedButton.icon(
                onPressed: controller.isFormValid.value
                    ? () {
                        controller.register();
                      }
                    : null,
                icon: const Icon(Icons.celebration),
                label: const Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
