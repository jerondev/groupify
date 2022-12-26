import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/community_chat_controller.dart';

class CommunityChatPage extends GetView<CommunityChatController> {
  const CommunityChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Chat'),
      ),
      body: SafeArea(
          child: Column(
        children: const [],
      )),
    );
  }
}
