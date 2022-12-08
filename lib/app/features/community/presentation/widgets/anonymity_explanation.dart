import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';

void showAnonymityExplanation() {
  showCustomBottomSheet(
    child: Text(
      "When enabled, users will join groups without knowing who else is in the group. This is useful when you want to create a group of people who don't know each other.",
      style: Get.textTheme.bodyLarge,
    ),
  );
}
