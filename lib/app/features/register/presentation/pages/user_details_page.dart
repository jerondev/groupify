import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/register/presentation/controllers/user_details_controller.dart';

class UserDetailsPage extends GetView<UserDetailsController> {
  const UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserDetailsPage'),
      ),
      body: const SafeArea(
        child: Text('UserDetailsController'),
      ),
    );
  }
}
