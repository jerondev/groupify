import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/new_community_.controller.dart';
import 'custom_form_field.dart';

class TotalPeopleForm extends StatefulWidget {
  const TotalPeopleForm({Key? key}) : super(key: key);

  @override
  State<TotalPeopleForm> createState() => _TotalPeopleFormState();
}

class _TotalPeopleFormState extends State<TotalPeopleForm> {
  NewCommunityController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      keyboardType: TextInputType.number,
      title: 'How many people are in your community?',
      hintText: 'This is the size of your community.',
      controller: controller.communitySizeController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
