// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/chat/domain/entities/message.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/send_message.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/utils/copy_to_clipboard.dart';

class ChatController extends GetxController {
  Offset tapLocation = Offset.zero;
  final SendMessageUseCase sendMessageUseCase;
  ChatController({
    required this.sendMessageUseCase,
  });

  //  get tap position for context menu
  void getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = Get.context!.findRenderObject() as RenderBox;
    final Offset localPosition =
        referenceBox.globalToLocal(details.globalPosition);
    tapLocation = localPosition;
  }

  void showContextMenu(BuildContext context, MessageEntity message) {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        tapLocation & const Size(40, 40), // smaller rect, the touch area
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          value: "copy",
          child: Row(
            children: const [
              Icon(
                Ionicons.copy_outline,
                size: 20,
              ),
              SizedBox(width: 10),
              Text("Copy"),
            ],
          ),
        ),
        // only show edit and delete if the message is sent by the user
        if (message.isMyMessage) ...[
          PopupMenuItem(
            value: "edit",
            child: Row(
              children: const [
                Icon(
                  IconlyBroken.edit,
                  size: 20,
                ),
                SizedBox(width: 10),
                Text("Edit"),
              ],
            ),
          ),
          PopupMenuItem(
            value: "delete",
            child: Row(
              children: const [
                Icon(
                  IconlyBroken.delete,
                  size: 20,
                ),
                SizedBox(width: 10),
                Text("Delete"),
              ],
            ),
          ),
        ],
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == "copy") {
        copyToClipboard(message.content);
      } else if (value == "edit") {
        print("edit");
      } else if (value == "delete") {
        print("delete");
      }
    });
  }

  // send message
  Future<Either<Failure, Unit>> sendMessage(MessageEntity message) async {
    return sendMessageUseCase(message);
  }
}
