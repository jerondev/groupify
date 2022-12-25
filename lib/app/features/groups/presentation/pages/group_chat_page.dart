import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_chat_controller.dart';
import 'package:organizer_client/shared/ui/spinner.dart';
import 'package:swipe_to/swipe_to.dart';

class GroupChatPage extends GetView<GroupChatController> {
  const GroupChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    String previousSender = "";
    const otherColor = Color(0xff128C7E);
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
                if (controller.messages.isEmpty) {
                  return const Center(
                    child: Text("No messages yet"),
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
                    final bool isMyMessage =
                        controller.messages[index].sender.id ==
                            controller.userId;
                    final message = controller.messages[index];
                    final bool isSameSender =
                        previousSender == message.sender.fullName;
                    previousSender = message.sender.fullName;

                    return SwipeTo(
                      onRightSwipe: () {},
                      child: ChatBubble(
                        padding: const EdgeInsets.only(
                            top: 5, left: 14, right: 10, bottom: 10),
                        elevation: 0,
                        clipper: ChatBubbleClipper9(
                            type: isMyMessage
                                ? BubbleType.sendBubble
                                : BubbleType.receiverBubble),
                        alignment: isMyMessage
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        backGroundColor: isMyMessage ? userColor : otherColor,
                        child: SizedBox(
                          width: Get.width * 0.7,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isMyMessage && !isSameSender)
                                Text(
                                  message.sender.fullName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              SelectableText(
                                message.content,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  '12:00 pm',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                  suffixIcon: Obx(
                    () => controller.showSend.value
                        ? IconButton(
                            onPressed: () {
                              controller.sendMessage();
                            },
                            tooltip: "Send a message",
                            splashRadius: 20,
                            icon: const Icon(IconlyBroken.send),
                          )
                        : IconButton(
                            onPressed: () {},
                            icon: const Icon(Ionicons.attach_outline),
                            tooltip: "Attach a file",
                            splashRadius: 20,
                          ),
                  ),
                  // add record icon
                  prefixIcon: IconButton(
                    onPressed: () {},
                    tooltip: "Record a voice message",
                    splashRadius: 20,
                    icon: const Icon(Ionicons.mic_outline),
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
