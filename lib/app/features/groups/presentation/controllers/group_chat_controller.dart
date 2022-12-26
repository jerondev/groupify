import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanoid/nanoid.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/chat/domain/entities/group_message.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/get_messages.dart';
import 'package:organizer_client/app/features/chat/presentation/widgets/controllers/chat_controller.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/shared/ui/custom_avatar.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class GroupChatController extends GetxController {
  final String groupId = Get.arguments['groupId'];
  final GroupEntity group = Get.arguments['group'];
  final GetMessagesUseCase getMessagesUseCase;
  final AuthenticatedUserUseCase authenticatedUser;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final textMessageController = TextEditingController();
  late AppUser appUser;
  RxBool isLoading = false.obs;
  RxBool errorOccurred = false.obs;
  RxBool isSendingMessage = false.obs;
  RxList<GroupMessageEntity> messages = RxList<GroupMessageEntity>();
  final scrollController = ScrollController();
  final ChatController _chatController = Get.find();
  final DraggableScrollableController draggableController =
      DraggableScrollableController();
  GroupChatController({
    required this.getMessagesUseCase,
    required this.authenticatedUser,
  });

  @override
  void onInit() {
    messages.bindStream(getMessages());
    getUserDetails();
    super.onInit();
  }

  Stream<List<GroupMessageEntity>> getMessages() async* {
    final results = await getMessagesUseCase.call(StringParams(groupId));
    yield* results.fold((failure) async* {
      errorOccurred.value = true;
      yield [];
    }, (success) async* {
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
    final message = GroupMessageEntity(
      groupId: groupId,
      content: textMessageController.text.trim(),
      sender: appUser,
      type: const MessageType.text(),
      timestamp: DateTime.now(),
      id: nanoid(),
    );
    textMessageController.clear();
    final results = await _chatController.sendMessage(message);
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
    }, (success) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // show group details in a bottom sheet
  void showGroupDetails() {
    showCustomBottomSheet(
      height: Get.height * 0.6,
      isScrollControlled: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CustomAvatar(
                radius: 60,
                imageUrl:
                    "https://avatars.dicebear.com/api/adventurer/${group.id}.png",
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Members",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: group.members.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CustomAvatar(
                    width: 45,
                    imageUrl: group.members[index].profile,
                  ),
                  title: Text(group.members[index].fullName),
                  subtitle: Text(group.members[index].phoneNumber),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
