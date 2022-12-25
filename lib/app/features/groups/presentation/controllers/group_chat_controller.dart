import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanoid/nanoid.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/chat/domain/entities/message.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/get_messages.dart';
import 'package:organizer_client/app/features/chat/presentation/widgets/controllers/chat_controller.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class GroupChatController extends GetxController {
  final String groupId = Get.arguments['groupId'];
  final GetMessagesUseCase getMessagesUseCase;
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
  final ChatController _chatController = Get.find();
  GroupChatController({
    required this.getMessagesUseCase,
    required this.authenticatedUser,
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
    if (textMessageController.text.isEmpty) {
      return;
    }
    isSendingMessage.value = true;
    final message = MessageEntity(
      groupId: groupId,
      content: textMessageController.text.trim(),
      sender: appUser,
      type: const MessageType.text(),
      timestamp: DateTime.now(),
      id: nanoid(),
    );
    final results = await _chatController.sendMessage(message);
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      isSendingMessage.value = false;
    }, (success) {
      isSendingMessage.value = false;
      textMessageController.clear();
      showSend.value = false;
    });
  }
}
