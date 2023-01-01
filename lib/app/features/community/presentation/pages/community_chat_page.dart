import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/community_chat_controller.dart';

class CommunityChatPage extends GetView<CommunityChatController> {
  const CommunityChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Broadcast'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Obx(
            () => ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(12),
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 7),
              ),
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final message = controller.messages[index];
                return Column(
                  children: [
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
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onLongPress: () {
                        controller.showContextMenu(context, message);
                      },
                      onTapDown: (details) =>
                          controller.getTapPosition(details),
                      child: ChatBubble(
                        elevation: 0,
                        backGroundColor:
                            Get.theme.colorScheme.secondaryContainer,
                        clipper: ChatBubbleClipper3(),
                        alignment: Alignment.bottomRight,
                        child: Text(message.content),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (message.isSent)
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Icon(
                                  Ionicons.checkmark_done,
                                  size: 12,
                                  color: Get.theme.colorScheme.primary,
                                ),
                              ),
                            Text(
                              message.formattedTime,
                              style: TextStyle(
                                color: Get.theme.hintColor,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
            child: TextFormField(
              controller: controller.textMessageController,
              maxLines: 5,
              minLines: 1,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: controller.sendMessage,
                  icon: const Icon(IconlyBroken.send),
                  tooltip: "Send a message",
                  splashRadius: 20,
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
      )),
    );
  }
}
