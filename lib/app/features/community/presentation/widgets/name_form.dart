import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/new_community_.controller.dart';

import 'custom_form_field.dart';

class NameForm extends StatefulWidget {
  const NameForm({Key? key}) : super(key: key);

  @override
  State<NameForm> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  NewCommunityController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      title: 'Give your community a name.',
      hintText: 'Enter a short distinct name',
      controller: controller.nameController,
    );
  }
}
