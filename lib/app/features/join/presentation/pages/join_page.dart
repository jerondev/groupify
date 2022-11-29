import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/join/presentation/controllers/join_controller.dart';

class JoinPage extends GetView<JoinController> {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Text('JoinController'),
      ),
    );
  }
}
