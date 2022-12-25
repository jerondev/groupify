import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_chat_controller.dart';
import 'package:organizer_client/shared/enums/spinner.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class GroupChatPage extends GetView<GroupChatController> {
  const GroupChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    String previousSender = "";
    final otherColor = Get.theme.colorScheme.secondaryContainer;
    final userColor = Get.theme.colorScheme.inversePrimary;
    // use whatsapp colors
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

                        Column(
                          crossAxisAlignment: message.isMyMessage
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            ChatBubble(
                              elevation: 0,
                              clipper: ChatBubbleClipper1(
                                  type: message.isMyMessage
                                      ? BubbleType.sendBubble
                                      : BubbleType.receiverBubble),
                              alignment: message.isMyMessage
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              backGroundColor:
                                  message.isMyMessage ? userColor : otherColor,
                              child: message.isMyMessage
                                  ? ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: Get.width * 0.7,
                                      ),
                                      child: GestureDetector(
                                        onLongPress: () {
                                          controller.showContextMenu(
                                              context, message);
                                        },
                                        onTapDown: (details) =>
                                            controller.getTapPosition(details),
                                        child: message.isDeleted
                                            ? Chip(
                                                avatar: Icon(
                                                  IconlyBroken.delete,
                                                  size: 18,
                                                  color: Get.theme.errorColor,
                                                ),
                                                label: const Text(
                                                  "You deleted this message",
                                                ),
                                              )
                                            : Text(message.content),
                                      ),
                                    )
                                  : ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: Get.width * 0.7,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (!isSameSender)
                                            Text(
                                              message.sender.fullName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          GestureDetector(
                                            onLongPress: () {
                                              controller.showContextMenu(
                                                  context, message);
                                            },
                                            onTapDown: (details) => controller
                                                .getTapPosition(details),
                                            child: message.isDeleted
                                                ? Chip(
                                                    avatar: Icon(
                                                      IconlyBroken.delete,
                                                      size: 18,
                                                      color:
                                                          Get.theme.errorColor,
                                                    ),
                                                    label: const Text(
                                                      "This message was deleted",
                                                    ),
                                                  )
                                                : Text(message.content),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                            // show time only if the time is different from the previous message
                            if (index == 0 ||
                                controller.messages[index - 1].formattedTime !=
                                    message.formattedTime)
                              Padding(
                                padding: message.isMyMessage
                                    ? const EdgeInsets.only(right: 20)
                                    : const EdgeInsets.only(left: 20),
                                child: Text(
                                  message.formattedTime,
                                  style: TextStyle(
                                    color: Get.theme.hintColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
              child: TextFormField(
                controller: controller.textMessageController,
                maxLines: 5,
                minLines: 1,
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
