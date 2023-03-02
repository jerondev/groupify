import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/new_community_.controller.dart';
import 'custom_form_field.dart';

class DescriptionForm extends StatefulWidget {
  const DescriptionForm({Key? key}) : super(key: key);

  @override
  State<DescriptionForm> createState() => _DescriptionFormState();
}

class _DescriptionFormState extends State<DescriptionForm> {
  NewCommunityController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      title: 'Describe your community.',
      hintText:
          'Enter a brief description so people know what this community is about.',
      controller: controller.descriptionController,
    );
  }
}
