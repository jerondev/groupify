import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/chat/domain/entities/message.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/get_messages.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/send_message.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';
import 'package:organizer_client/shared/utils/copy_to_clipboard.dart';

class GroupChatController extends GetxController {
  final String groupId = Get.arguments['groupId'];
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final AuthenticatedUserUseCase authenticatedUser;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final textMessageController = TextEditingController();
  RxBool showSend = false.obs;
  late AppUser appUser;
  RxBool isLoading = false.obs;
  RxBool errorOccurred = false.obs;
  RxBool isSendingMessage = false.obs;
  RxList<MessageEntity> messages = RxList<MessageEntity>();
  final scrollController = ScrollController();
  GroupChatController({
    required this.getMessagesUseCase,
    required this.authenticatedUser,
    required this.sendMessageUseCase,
  });

  @override
  void onInit() {
    messages.bindStream(getMessages());
    textMessageController.addListener(() {
      if (textMessageController.text.isEmpty) {
        showSend.value = false;
      } else {
        showSend.value = true;
      }
    });
    getUserDetails();
    super.onInit();
  }

  Stream<List<MessageEntity>> getMessages() async* {
    isLoading.value = true;
    final results = await getMessagesUseCase.call(StringParams(groupId));
    yield* results.fold((failure) async* {
      isLoading.value = false;
      errorOccurred.value = true;
      yield [];
    }, (success) async* {
      isLoading.value = false;
      errorOccurred.value = false;
      yield* success;
    });
  }

  Future<void> getUserDetails() async {
    isLoading.value = true;
    final results = await authenticatedUser.call(NoParams());
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      appUser = AppUser.initial();
      isLoading.value = false;
    }, (success) {
      appUser = success;
      isLoading.value = false;
    });
  }

  Future<void> sendMessage() async {
    isSendingMessage.value = true;
    final message = MessageEntity(
      groupId: groupId,
      content: textMessageController.text.trim(),
      sender: appUser,
      type: const MessageType.text(),
      timestamp: DateTime.now(),
    );
    final results = await sendMessageUseCase.call(message);
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      isSendingMessage.value = false;
    }, (success) {
      textMessageController.clear();
      isSendingMessage.value = false;
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
      // scroll to bottom
      // scrollController.animateTo(
      //   scrollController.position.maxScrollExtent,
      //   duration: const Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );
    });
  }

  Offset tapLocation = Offset.zero;

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
}
