import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class NewGroupController extends GetxController {
  /// The first value holds the group method and the second value
  /// holds the people method
  List<bool> selectedGroupingMethod = [false, true];
  void changeSelectedGroup(int index) {
    for (var i = 0; i < selectedGroupingMethod.length; i++) {
      selectedGroupingMethod[i] = i == index;
    }
    update();
  }

  final formKey = GlobalKey<FormState>();
  final groupCodeController = TextEditingController();
  final groupNameController = TextEditingController();
  final totalPeopleController = TextEditingController();
  final peoplePerGroupController = TextEditingController();
  final numberOfGroupsController = TextEditingController();

  void computeGroupData() {}

  /// Ask user if he wants to discard the form
  Future<bool?> willPop() async {
    return Get.dialog<bool>(
      AlertDialog(
        title: const Text("Are you sure you want to quit?"),
        titleTextStyle: Get.textTheme.headline6!.copyWith(
          fontSize: 17,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        icon: const Icon(Ionicons.warning_outline),
        iconColor: Get.theme.colorScheme.error,
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(
              foregroundColor: Get.theme.colorScheme.error,
            ),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}
