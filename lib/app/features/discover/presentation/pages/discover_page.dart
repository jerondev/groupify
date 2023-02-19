import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/discover_controller.dart';
import 'package:organizer_client/shared/enums/spinner.dart';
import 'package:organizer_client/shared/theme/theme.dart';
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
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(14),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/search.webp',
                    height: 250,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Find a community or group",
                    style: Get.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Simply enter the community or group code to gain access",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: controller.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: controller.codeController,
                      validator: Validator.validCode,
                      decoration: const InputDecoration(
                        labelText: 'Code',
                        contentPadding: inputPadding,
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
                                controller.find();
                              },
                        icon: controller.isLoading.value
                            ? const Spinner(
                                size: SpinnerSize.sm,
                              )
                            : const Icon(Ionicons.search_outline),
                        label: Text(controller.isLoading.value
                            ? "Searching"
                            : "Search"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
