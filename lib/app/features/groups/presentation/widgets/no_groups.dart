import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class NoGroups extends StatelessWidget {
  const NoGroups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/empty-folder.png',
        ),
        const SizedBox(height: 10),
        Text(
          "No Groups",
          style: Get.textTheme.headline6,
        ),
        const SizedBox(height: 8),
        const Text("Create your first group, it's just a button away"),
        const SizedBox(height: 30),
        ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Ionicons.add),
            label: const Text("New Group"))
      ],
    );
  }
}
