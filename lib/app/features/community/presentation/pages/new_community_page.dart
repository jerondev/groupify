import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/new_community_.controller.dart';

class NewCommunityPage extends GetView<NewCommunityController> {
  const NewCommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onBackPress,
      child: Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            minimum: const EdgeInsets.all(20),
            child: GetBuilder(
              init: controller,
              initState: (_) {},
              builder: (_) {
                return PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.pages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: controller.pages[index],
                    );
                  },
                );
              },
            ),
          ),
          floatingActionButton: Obx(
            () => controller.hideNextButton.value
                ? const SizedBox.shrink()
                : FloatingActionButton(
                    backgroundColor: controller.disableNextButton.value
                        ? Theme.of(context).colorScheme.error
                        : null,
                    onPressed: controller.disableNextButton.value
                        ? null
                        : controller.floatingActionBtnPressed,
                    child: controller.buildFloatingActionBtnIcon(),
                  ),
          )),
    );
  }
}
