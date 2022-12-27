// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nanoid/nanoid.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/chat/domain/entities/community_message.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/get_community_messages.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/send_community_message.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class CommunityChatController extends GetxController {
  final CommunityEntity community = Get.arguments['community'];
  // get community id
  String get communityId => community.id;
  late AppUser appUser;
  final AuthenticatedUserUseCase authenticatedUser;
  final textMessageController = TextEditingController();
  RxList<CommunityMessageEntity> messages = RxList<CommunityMessageEntity>();
  final GetCommunityMessagesUseCase getMessagesUseCase;
  final SendCommunityMessageUseCase sendCommunityMessageUseCase;
  RxBool errorOccurred = false.obs;
  CommunityChatController({
    required this.authenticatedUser,
    required this.getMessagesUseCase,
    required this.sendCommunityMessageUseCase,
  });

  @override
  void onInit() {
    messages.bindStream(getMessages());
    getUserDetails();
    super.onInit();
  }

  Stream<List<CommunityMessageEntity>> getMessages() async* {
    final results = await getMessagesUseCase.call(StringParams(communityId));
    yield* results.fold((failure) async* {
      errorOccurred.value = true;
      yield [];
    }, (success) async* {
      errorOccurred.value = false;
      yield* success;
    });
  }

  Future<void> getUserDetails() async {
    final results = await authenticatedUser.call(NoParams());
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      appUser = AppUser.initial();
    }, (success) {
      appUser = success;
    });
  }

  Future<void> sendMessage() async {
    if (textMessageController.text.isEmpty) {
      return;
    }
    final message = CommunityMessageEntity(
      communityId: communityId,
      content: textMessageController.text.trim(),
      sender: appUser,
      type: const MessageType.text(),
      timestamp: DateTime.now(),
      id: nanoid(),
    );
    textMessageController.clear();
    final results = await sendCommunityMessageUseCase(message);
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
    }, (success) {});
  }
}
