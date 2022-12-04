import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoCommunities extends StatelessWidget {
  const NoCommunities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
        child: Column(
          children: [
            Image.asset(
              'assets/empty-box.png',
            ),
            const SizedBox(height: 10),
            Text(
              "No Communities, new ones will appear here",
              style: Get.textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Hey, create a community and invite your friends to join it's groups",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
