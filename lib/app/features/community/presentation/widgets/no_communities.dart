import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoCommunities extends StatelessWidget {
  const NoCommunities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        children: [
          Image.asset(
            'assets/empty-box.png',
          ),
          const SizedBox(height: 10),
          Text(
            "No Communities yet? No problem!",
            style: Get.textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "Create your first community to get started.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
