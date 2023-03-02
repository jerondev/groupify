import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/presentation/widgets/custom_form_field.dart';

import '../controllers/new_community_.controller.dart';

class HeadCountForm extends StatefulWidget {
  const HeadCountForm({Key? key}) : super(key: key);

  @override
  State<HeadCountForm> createState() => _HeadCountFormState();
}

class _HeadCountFormState extends State<HeadCountForm> {
  NewCommunityController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      keyboardType: TextInputType.number,
      title: 'How many people per group?',
      hintText: 'Every group will have this number of people.',
      controller: controller.headCountController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
