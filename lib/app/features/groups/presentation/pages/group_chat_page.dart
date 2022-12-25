import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/chat/presentation/widgets/single_message.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_chat_controller.dart';
import 'package:organizer_client/shared/enums/spinner.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class GroupChatPage extends GetView<GroupChatController> {
  const GroupChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    String previousSender = "";

    return Scaffold(
      appBar: AppBar(title: const Text("Group Chat")),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(child: Obx(
              () {
                if (controller.isLoading.value) {
                  return const Center(
                    child: Spinner(),
                  );
                }
                if (controller.errorOccurred.value) {
                  return const Center(
                    child: Text("Error occurred"),
                  );
                }

                return ListView.separated(
                  controller: controller.scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(12),
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    final bool isSameSender =
                        previousSender == message.sender.fullName;
                    previousSender = message.sender.fullName;
                    final bool showTime = index == 0 ||
                        controller.messages[index - 1].formattedTime !=
                            message.formattedTime;

                    return Column(
                      children: [
                        // show chat date, like today, yesterday, 3rd May
                        if (index == 0 ||
                            controller.messages[index - 1].formattedDate !=
                                message.formattedDate)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Chip(
                              label: Text(message.formattedDate),
                              avatar: const Icon(IconlyBroken.calendar),
                            ),
                          ),
                        SingleMessage(
                          message: message,
                          isSameSender: isSameSender,
                          showTime: showTime,
                        )
                      ],
                    );
                  },
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
              child: TextFormField(
                controller: controller.textMessageController,
                maxLines: 5,
                minLines: 1,
                // scroll the list to the bottom when the user focuses on the text field

                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: controller.sendMessage,
                    icon: Obx(
                      () => controller.isSendingMessage.value
                          ? const Spinner(
                              size: SpinnerSize.sm,
                            )
                          : const Icon(IconlyBroken.send),
                    ),
                    tooltip: "Send a message",
                    splashRadius: 20,
                  ),
                  // add record icon
                  prefixIcon: IconButton(
                    onPressed: () {},
                    tooltip: "Share an image",
                    splashRadius: 20,
                    icon: const Icon(Ionicons.image_outline),
                  ),
                  hintText: 'Type a message',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
