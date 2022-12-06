import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/discover_controller.dart';
import 'package:organizer_client/shared/enums/spinner.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/ui/spinner.dart';
import 'package:organizer_client/shared/validation/validator.dart';

class DiscoverPage extends GetView<DiscoverController> {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(14),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/guy.png',
                  height: 250,
                ),
                const SizedBox(height: 10),
                Text(
                  "Hey, join a group to start planning",
                  style: Get.textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  "Find your friends and join their group",
                  style: Get.textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Form(
                  key: controller.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: controller.groupCodeController,
                    validator: Validator.validGroupCode,
                    decoration: const InputDecoration(
                      labelText: 'Group Code',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.maxFinite,
                  child: Obx(
                    () => ElevatedButton.icon(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                              if (controller.formKey.currentState!.validate()) {
                              } else {
                                showErrorSnackbar(
                                    message: "Please fix the errors");
                              }
                            },
                      icon: controller.isLoading.value
                          ? const Spinner(
                              size: SpinnerSize.sm,
                            )
                          : const Icon(Ionicons.search_outline),
                      label: Text(controller.isLoading.value
                          ? "Searching for group"
                          : "Find Group"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
