// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/chat/domain/entities/message.dart';
import 'package:organizer_client/app/features/chat/presentation/widgets/controllers/chat_controller.dart';

class SingleMessage extends StatelessWidget {
  SingleMessage({
    Key? key,
    required this.message,
    required this.isSameSender,
    required this.showTime,
  }) : super(key: key);
  final MessageEntity message;
  final bool isSameSender;
  final chatController = Get.find<ChatController>();
  final bool showTime;

  @override
  Widget build(BuildContext context) {
    final otherColor = Get.theme.colorScheme.secondaryContainer;
    final userColor = Get.theme.colorScheme.inversePrimary;
    return Column(
      crossAxisAlignment: message.isMyMessage
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        if (message.isDeleted)
          Align(
            alignment: message.isMyMessage
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Chip(
              backgroundColor: Get.theme.colorScheme.errorContainer,
              avatar: Icon(
                IconlyBroken.delete,
                color: Get.theme.colorScheme.error,
              ),
              label: Text(message.isMyMessage
                  ? "You deleted this message"
                  : "${message.sender.fullName} deleted this message"),
            ),
          ),
        if (!message.isDeleted)
          ChatBubble(
            elevation: 0,
            clipper: ChatBubbleClipper1(
                type: message.isMyMessage
                    ? BubbleType.sendBubble
                    : BubbleType.receiverBubble),
            alignment:
                message.isMyMessage ? Alignment.topRight : Alignment.topLeft,
            backGroundColor: message.isMyMessage ? userColor : otherColor,
            child: message.isMyMessage
                ? ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.7,
                    ),
                    child: GestureDetector(
                      onLongPress: () {
                        chatController.showContextMenu(context, message);
                      },
                      onTapDown: (details) =>
                          chatController.getTapPosition(details),
                      child: Text(message.content),
                    ),
                  )
                : ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.7,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            chatController.showContextMenu(context, message);
                          },
                          onTapDown: (details) =>
                              chatController.getTapPosition(details),
                          child: Text(message.content),
                        ),
                      ],
                    ),
                  ),
          ),
        // show time only if the time is different from the previous message
        Padding(
          padding: message.isMyMessage
              ? EdgeInsets.only(right: message.isDeleted ? 10 : 20)
              : EdgeInsets.only(left: message.isDeleted ? 10 : 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!message.isMyMessage && message.isEdited)
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    Ionicons.pencil,
                    size: 12,
                    color: Get.theme.hintColor,
                  ),
                ),
              if (message.isMyMessage && !message.isEdited)
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    Ionicons.checkmark_done,
                    size: 12,
                    color: Get.theme.hintColor,
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
      ],
    );
  }
}
