import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/sub_group_controller.dart';

class SubGroupPage extends GetView<SubGroupController> {
  const SubGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${Get.parameters['groupId']} Members"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
              splashRadius: 22,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Person ${index + 1}"),
                onTap: () {},
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemCount: 10),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {}, label: Text("Join Group ${Get.parameters['id']}")),
    );
  }
}
