import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_preview_controller.dart';

class GroupPreviewPage extends GetView<GroupPreviewController> {
  const GroupPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GroupPreviewPage'),
      ),
      body: const SafeArea(
        child: Text('GroupPreviewController'),
      ),
    );
  }
}
