import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/new_community_.controller.dart';
import 'custom_form_field.dart';

class GroupCountForm extends StatefulWidget {
  const GroupCountForm({Key? key}) : super(key: key);

  @override
  State<GroupCountForm> createState() => _GroupCountFormState();
}

class _GroupCountFormState extends State<GroupCountForm> {
  NewCommunityController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      keyboardType: TextInputType.number,
      title: 'How many Groups do you want to create?',
      hintText: 'The community will be divided into this number of groups.',
      controller: controller.groupCountController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
