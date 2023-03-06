import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groupify/shared/ui/snackbars.dart';
import 'package:iconly/iconly.dart';

import '../controllers/create_community_controller.dart';

class CreatePage extends GetView<CreateCommunityController> {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(14),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                "Create Your Community",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Your community is where you and your mates hang out. Make yours and start talking",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 100,
              child: InkWell(
                onTap: controller.pickImage,
                child: GetBuilder(
                  init: controller,
                  builder: (controller) => Center(
                    child: controller.communityProfile.isEmpty
                        ? CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withOpacity(0.3),
                            child: const Icon(IconlyBroken.image_2),
                          )
                        : CircleAvatar(
                            radius: 45,
                            backgroundImage: FileImage(
                              File(controller.communityProfile),
                            ),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'COMMUNITY NAME',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: controller.nameController,
                autofocus: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall,
                    text: "By creating a community, you agree to Groupify's ",
                    children: [
                      TextSpan(
                        text: "community guidelines",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: Obx(
                () => ElevatedButton(
                  onPressed: controller.enableButton.value
                      ? () {
                          showSuccessSnackbar(message: "Community created");
                        }
                      : null,
                  child: const Text("Create community"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
