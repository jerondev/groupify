import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/new_group.controller.dart';

class NewGroupPage extends GetView<NewGroupController> {
  const NewGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewGroup'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Form(
              child: Column(
                children: const [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
